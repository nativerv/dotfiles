-- | Author: nrv
-- | Description: press `p` to open file in clipboard

local mp = require'mp'
local utils = require'mp.utils'
local msg = require'mp.msg'

local xclip_cmd = { 'xclip', '-out', '-selection', 'clipboard' }

mp.add_key_binding(nil, 'paste', function ()
  local result = utils.subprocess({ args = xclip_cmd, cancellable = false })

  -- | Pop a message on fail to read clipboard
  if result.status ~= 0 then
    local error_message = 'error running xclip: "' .. result.error .. '"'
    msg.error(error_message)
    mp.osd_message('[paste] ' .. error_message)
    return
  end

  -- | Try to load a file by name from clipboard
  msg.info('[paste] opening "' .. result.stdout .. '"')
  mp.commandv("loadfile", result.stdout)

  -- | Pop a message on fail to load
  mp.register_event("end-file", function (event)
    print(utils.to_string(event))
    if event.reason == 'error' then
      local error_message = 'no such file: \"' .. result.stdout .. '"'
      mp.osd_message('[paste] ' .. error_message)
      msg.error(error_message)
    end
  end)
end)
