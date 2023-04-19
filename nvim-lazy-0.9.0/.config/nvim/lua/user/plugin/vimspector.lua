-- This is from my legacy config, kept it in case i would lose my 
-- mind and install vimspactor instead of dap again
local M = {}

M.setup = function()
  -- Move vimspector's crap from "${HOME}"
  vim.cmd [[
    augroup nrv#move_vimspector_crap_from_home
      autocmd!
      autocmd User VimspectorDebugEnded call system("mv ~/.vimspector.log " . exists('$XDG_CACHE_HOME') ? $XDG_CACHE_HOME : '~/.cache' . "/nvim/vimspector.log")
    augroup END
  ]]
end
-- 

return M
