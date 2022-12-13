local M = {}

function M.hex_to_channels(hex_str)
  local hex = '[a-fA-F0-9][a-fA-F0-9]'
  local pat = '^#?(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)

  assert(
    string.find(hex_str, pat) ~= nil,
    'hex_to_rgb: invalid hex_str: ' .. tostring(hex_str)
  )

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

function M.blend(fg, bg, alpha)
  local fg_channels = M.hex_to_channels(string.format('%06x', fg))
  local bg_channels = M.hex_to_channels(string.format('%06x', bg))

  local function blend_channel(i)
    local ret = (alpha * fg_channels[i] + ((1 - alpha) * bg_channels[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format(
    '#%02X%02X%02X',
    blend_channel(1),
    blend_channel(2),
    blend_channel(3)
  )
end

---@param color (number) Color to lighten
---@param amount (number) Amount, 0-N
---@param bg (number|nil) Some shit that you don't need to specify, 0-N
function M.darken(color, amount, bg)
  return M.blend(color, bg or 0xffffff, math.abs(amount))
end

---@param color (number) Color to lighten
---@param amount (number) Amount, 0-N
---@param fg (number|nil) Some shit that you don't need to specify, 0-N
function M.lighten(color, amount, fg)
  return M.blend(color, fg or 0x000000, math.abs(amount))
end

return M
