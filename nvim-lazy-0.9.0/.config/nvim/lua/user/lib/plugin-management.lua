local M = {}

--- Example mappings schema: 
--- M.mappings = {
---   {
---     keys = { '<A-C-h>', '<A-C-р>' },
---     { { 'n' }, function() end },
---     { { 'v' }, function() end },
---     opts = { desc = '' },
---   },
--- }
function M.apply_module_mappings(module_mappings)
  for _, mapping_group in ipairs(module_mappings) do
    for _, mapping in ipairs(mapping_group) do
      for _, key in ipairs(mapping_group.keys) do
        if not mapping[2] then return end
        vim.keymap.set(
          mapping[1],
          key,
          mapping[2],
          vim.tbl_deep_extend('keep', mapping[3] or {}, mapping_group.opts)
        )
      end
    end
  end
end

function M.extract_keys_from_module_mappings(module_mappings, include_rhs)
  include_rhs = include_rhs or false
  local keys = {}
  for _, mapping_group in pairs(module_mappings) do
    for _, mapping in ipairs(mapping_group) do
      for _, key in ipairs(mapping_group.keys) do
        table.insert(
          keys, 
          vim.tbl_deep_extend(
            'error', 
            { key, include_rhs and mapping[2] or nil, mode = mapping[1] }, 
            vim.tbl_deep_extend('keep', mapping[3] or {}, mapping_group.opts)
          )
        )
      end
    end
  end
  return keys
end

return M
