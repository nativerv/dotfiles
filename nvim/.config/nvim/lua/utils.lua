vim.cmd [[
  function! SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc
]]

local util = {}

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()

  if raw then return s end

  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function util.xdg_user_dir(name)
  os.capture('xdg-user-dir ' .. name, false)
end

util.DOCUMENTS = util.xdg_user_dir('DOCUMENTS')
util.PICTURES = util.xdg_user_dir('PICTURES')
util.DOWNLOADS = util.xdg_user_dir('DOWNLOADS')
util.VIDEOS = util.xdg_user_dir('VIDEOS')
util.DESKTOP = util.xdg_user_dir('DESKTOP')
util.TEMPLATES = util.xdg_user_dir('TEMPLATES')
util.MUSIC = util.xdg_user_dir('MUSIC')
util.CONFIG = os.getenv('XDG_CONFIG_HOME')
util.DATA = os.getenv('XDG_DATA_HOME')
util.CACHE = os.getenv('XDG_CACHE_HOME')

-- | Simulate (cond ? T : F)
function ternary ( cond , T , F )
    if cond then
      return T
    else
      return F
    end
end

-- | Merge passed tables
function merge(...)
  local result = {}
  for _, t in ipairs{...} do
    for k, v in pairs(t) do
      result[k] = v
    end
    local mt = getmetatable(t)
    if mt then
      setmetatable(result, mt)
    end
  end
  return result
end

-- | See if the file exists
function is_file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- | Get all lines from a file, returns an empty
-- | list/table if the file does not exist
function read_lines(file)
  if not is_file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

return util
