-- | Author: nrv
-- | Description: press `p` to open file in clipboard

local mp = require'mp'
local utils = require'mp.utils'
local msg = require'mp.msg'

mp.add_key_binding(nil, 'yank', function ()
  -- Get currently playing file path
  local filepath = mp.get_property('path')

  if filepath == nil then
    local message = 'can\'t yank: no file opened'
    mp.osd_message('[yank] ' .. message)
    msg.info(message)
    return
  end

  -- Construct xclip command that gets filepath into clipboard
  local xclip_cmd = { 'sh', '-c', 'echo ' .. filepath .. '| yank' }

  local result = utils.subprocess({ args = xclip_cmd, cancellable = false })
  if result.status == 0 then
    -- Success
    local message = 'yanked: "' .. result.error .. '"'
    mp.osd_message('[yank] ' .. message)
    msg.info(message)
  else
    -- Error
    local error_message = 'failed to yank to clipboard: "' .. result.error .. '"'
    mp.osd_message('[yank] ' .. error_message)
    msg.error(error_message)
  end
end)
