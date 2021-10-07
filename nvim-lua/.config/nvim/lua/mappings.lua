-- Unmap <space> so it don't interfere with the leader>
vim.api.nvim_set_keymap('n', '<space>', '<nop>', { noremap = true, silent = true })

-- Make db adequate (not actually works in this form)
--nnoremap db ldb
--
-- Make x/X adequate
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'X', '"_X', { noremap = true, silent = true })


-- | Select all: Ctrl-A
vim.api.nvim_set_keymap('n', '<C-a>', '<esc>ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<esc>ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-a>', '<esc>ggVG', { noremap = true, silent = true })

-- | Reload config
vim.api.nvim_set_keymap('n', '<leader>dr', ':so ~/.config/nvim/init.lua<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dp', ':PackerInstall<cr>',              { noremap = true, silent = true })

-- | Tabs 
vim.api.nvim_set_keymap('n', '<M-i>', ':tabprevious<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-i>', ':tabnext<cr>',     { noremap = true, silent = true })

-- Make p in VISUAL adequate
vim.api.nvim_set_keymap('v', 'p', '"_dP', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'P', '"_dP', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'p', '""p',  { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'P', '""p',  { noremap = true, silent = true })

-- | Ranger
vim.api.nvim_set_keymap('n', '<leader>v', ':Ranger<cr>', { noremap = true, silent = true })

-- | gb's
-- vim.g.VM_maps = {}
-- vim.g.VM_maps['Find Under']         = 'gb'           -- replace C-n
-- vim.g.VM_maps['Find Subword Under'] = 'gb'           -- replace C-n visual
-- vim.g.VM_maps = { 
--   'Find Under'         : 'gb' 
--   'Find Subword Under' : 'gb'
-- }

-- | vim-surround
-- | Surround word
vim.api.nvim_set_keymap('n', 'S', 'ysiw', { noremap = false, silent = true })

-- Identify highlight group under cursor
vim.api.nvim_set_keymap('n', '<F10>', [[
  :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
]], { noremap = true, silent = true })

--" Explorer pane
vim.api.nvim_set_keymap('n', '<C-b>', ':NERDTreeToggle<cr>', { noremap = true, silent = true })

-- --" GitGutter
vim.api.nvim_set_keymap('n', 'gz', '<Plug>(GitGutterPreviewHunk)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g[', '<Plug>(GitGutterPrevHunk)',    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g]', '<Plug>(GitGutterNextHunk)',    { noremap = true, silent = true })

-- | hop.nvim
vim.api.nvim_set_keymap('n', 'f', '<cmd>lua require"hop".hint_words()<cr>', { noremap = true, silent = true })

-- -- Alt-Dublicate lines
vim.api.nvim_set_keymap('n', '<M-J>', ':t .<cr>==',          { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-K>', ':t .-1<cr>==',        { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-J>', '<Esc>:t .<cr>==gi',   { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-J>', ':t \'><cr>gv=gv',     { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-K>', '<Esc>:t .-1<cr>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-K>', ':t \'<-1<cr>gv=gv',   { noremap = true, silent = true })

-- | Move wrapped lines with j/k
vim.cmd [[
  noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k') 
]]

-- | nerdcommenter
vim.api.nvim_set_keymap("n", "<C-_>", "<plug>NERDCommenterToggle", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<plug>NERDCommenterToggle", {})
vim.api.nvim_set_keymap("v", "?",     "<plug>NERDCommenterSexy",   {})

