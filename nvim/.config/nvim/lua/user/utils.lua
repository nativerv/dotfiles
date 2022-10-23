local util = {}

--
-- function os.capture(cmd, raw)
--   local f = assert(io.popen(cmd, 'r'))
--   local s = assert(f:read('*a'))
--   f:close()
--
--   if raw then return s end
--
--   s = string.gsub(s, '^%s+', '')
--   s = string.gsub(s, '%s+$', '')
--   s = string.gsub(s, '[\n\r]+', ' ')
--   return s
-- end
--
-- function util.xdg_user_dir(name)
--   os.capture('xdg-user-dir ' .. name, false)
-- end
--
-- -- Simulate (cond ? T : F)
-- function util.ternary ( cond , T , F )
--     if cond then
--       return T
--     else
--       return F
--     end
-- end
--
-- -- See if the file exists
-- function util.is_file_exists(file)
--   local f = io.open(file, "rb")
--   if f then f:close() end
--   return f ~= nil
-- end
--
-- -- Get all lines from a file, returns an empty
-- -- list/table if the file does not exist
-- function util.read_lines(file)
--   if not util.is_file_exists(file) then return {} end
--   local lines = {}
--   for line in io.lines(file) do
--     lines[#lines + 1] = line
--   end
--   return lines
-- end
--
-- -- Define constants
-- util.XDG_DOCUMENTS_DIR = util.xdg_user_dir('DOCUMENTS')
-- util.XDG_PICTURES_DIR = util.xdg_user_dir('PICTURES')
-- util.XDG_DOWNLOADS_DIR = util.xdg_user_dir('DOWNLOADS')
-- util.XDG_VIDEOS_DIR = util.xdg_user_dir('VIDEOS')
-- util.XDG_DESKTOP_DIR = util.xdg_user_dir('DESKTOP')
-- util.XDG_TEMPLATES_DIR = util.xdg_user_dir('TEMPLATES')
-- util.XDG_MUSIC_DIR = util.xdg_user_dir('MUSIC')
-- util.XDG_CONFIG_HOME = os.getenv('XDG_CONFIG_HOME')
-- util.XDG_DATA_HOME = os.getenv('XDG_DATA_HOME')
-- util.XDG_CACHE_HOME = os.getenv('XDG_CACHE_HOME')


function util.is_empty(value)
  return value == nil or value == ""
end
return util
