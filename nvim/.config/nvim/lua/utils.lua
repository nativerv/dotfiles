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
