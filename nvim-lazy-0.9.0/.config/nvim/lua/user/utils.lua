local M = {}

function M.xdg_user_dir(name)
  vim.fn.system { 'xdg-user-dir', name }
end

-- Simulate (cond ? T : F)
function M.ternary(cond, T, F)
  if cond then
    return T
  else
    return F
  end
end

-- Map multiple left hand sides to the same rhs
function M.map_keys(mode, lhss, rhs, opts)
  for _, lhs in ipairs(lhss) do
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.flatten_keys(keys)
  return vim.tbl_flatten(vim.tbl_values(keys))
end

M.os_separator = package.config:sub(1, 1)
function M.join_path(path_object)
  return table.concat(path_object, M.os_separator)
end

M.is_inside_git_worktree = function()
  vim.fn.system { 'git', 'rev-parse', '--is-inside-work-tree' }
  if vim.v.shell_error == 0 then
    return true
  else
    return false
  end
end

-- Define constants
M.XDG_DOCUMENTS_DIR = M.xdg_user_dir 'DOCUMENTS'
M.XDG_PICTURES_DIR = M.xdg_user_dir 'PICTURES'
M.XDG_DOWNLOADS_DIR = M.xdg_user_dir 'DOWNLOADS'
M.XDG_VIDEOS_DIR = M.xdg_user_dir 'VIDEOS'
M.XDG_DESKTOP_DIR = M.xdg_user_dir 'DESKTOP'
M.XDG_TEMPLATES_DIR = M.xdg_user_dir 'TEMPLATES'
M.XDG_MUSIC_DIR = M.xdg_user_dir 'MUSIC'
M.XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME'
    or (M.join_path { os.getenv 'HOME', '.cache' })
M.XDG_CONFIG_HOME = os.getenv 'XDG_CONFIG_HOME'
    or (M.join_path { os.getenv 'HOME', '.config' })
M.XDG_DATA_HOME = os.getenv 'XDG_DATA_HOME'
    or (M.join_path { os.getenv 'HOME', '.local', 'share' })

function M.is_empty(value)
  return value == nil or value == ''
end

return M
