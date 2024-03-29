local utils = require 'mp.utils'
local options = require 'mp.options'
local msg = require 'mp.msg'

-- Defaulting XDG_STATE_HOME to $HOME/.local/state if it's not set
local xdg_state_home = os.getenv("XDG_STATE_HOME") or ("%s/.local/state"):format(os.getenv("HOME"))
local continue_dir = ("%s/mpv/continue"):format(xdg_state_home)

function log_error(message)
  msg.error(("ERROR: %s"):format(message))
end

function log_warn(message)
  msg.warn(("WARNING: %s"):format(message))
end

function log_info(message)
  msg.info(("INFO: %s"):format(message))
end

-- Ensure the directory exists
function ensure_dir(dir)
    if not os.execute(("mkdir -p '%s'"):format(dir)) then
        log_error("failed to create directory: " .. dir)
    end
end

-- Calculate md5 of a string
local function md5(data)
    -- Create a temporary file and write the data into it
  local tmpfile = os.tmpname()
  local file = io.open(tmpfile, "w")
  if file then
      file:write(data)
      file:close()
  else
      log_error("unable to create temporary file")
      return
  end

  -- Run the md5sum command and read its output
  local handle = io.popen("md5sum " .. tmpfile)
  local result = handle:read("*a")
  handle:close()

  -- Remove the temporary file
  os.remove(tmpfile)

  -- Extract and return the actual MD5 hash from the md5sum output
  return result:gsub("%s.*", "")
end

-- Write the current timing to a file
function write_timing_to_file()
    local is_paused = mp.get_property_bool("pause")
    if is_paused == nil then log_error("cound not get property 'pause' from mpv") end
    if is_paused == true then return end

    local current_file = mp.get_property("path")
    if not current_file then
      log_error("could not get file path for writing")
      return
    end

    local _, file_name = utils.split_path(current_file)
    local hash = md5(file_name)
    local timing_file_path = ("%s/%s"):format(continue_dir, hash:upper())
    local current_time = mp.get_property("time-pos")

    if not current_time then
      log_error("could not get time pos for writing")
      return
    end

    local file = io.open(timing_file_path, "w")
    if not file then
      log_error(("could not open timing file for writing: %s"):format(timing_file_path))
      return
    end

    file:write(current_time)
    file:close()
end

-- Read the timing from a file if it exists and seek to that position
function read_timing_from_file()
  local current_file = mp.get_property("path")
  if not current_file then
    log_error("could not get file path for reading")
    return
  end

  local _, file_name = utils.split_path(current_file)
  log_info(file_name)
  local hash = md5(file_name)
  local timing_file_path = ("%s/%s"):format(continue_dir, hash:upper())

  local file = io.open(timing_file_path, "r")
  if not file then
    log_warn("could not open file for reading")
    return
  end

  local timing = file:read("*all")
  file:close()
  mp.commandv("seek", timing, "absolute")
end

function write_timing_to_file_timer()
  -- Every second, write the current timing to a file
  mp.add_periodic_timer(1, write_timing_to_file)
end

-- Make sure the state directory exists
ensure_dir(continue_dir)

-- When a new file is loaded, check for an existing timing file and seek to that time if it exists
mp.register_event("file-loaded", read_timing_from_file)
mp.register_event("file-loaded", write_timing_to_file_timer)
mp.register_event("seek", write_timing_to_file)
