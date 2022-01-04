-- | VIM world

-- | FIX RUSSIAN ;;;;;->$$$$$$!!!111
vim.api.nvim_set_keymap('n', ';', '$', { unique = true });

-- | Toggle 80 color column
vim.api.nvim_set_keymap('n', '<leader>ul', [[<cmd>lua if vim.opt.colorcolumn == '80' then vim.opt.colorcolumn = '0' else vim.opt.colorcolumn = '80' end<cr>]], { noremap = true, silent = true })

-- | Toggle wrap
vim.api.nvim_set_keymap('n', '<leader>uw', '<cmd>set wrap!<cr>',             { noremap = true, silent = true })

-- | Unmap <space> so it don't interfere with the leader>
vim.api.nvim_set_keymap('n', '<space>', '<nop>',             { noremap = true, silent = true })

-- | Unmap annoying q:/Q
vim.api.nvim_set_keymap('n', 'q:', '<nop>',                  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'Q',  '<nop>',                  { noremap = true, silent = true })

-- | Make db adequate (not actually works in this form)
vim.api.nvim_set_keymap('n', 'db', 'dvb',                    { noremap = true, silent = true })

-- | Redirect x/X to void register
vim.api.nvim_set_keymap('n', 'x', '"_x',                     { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'X', '"_X',                     { noremap = true, silent = true })

-- | Select all: Ctrl-A
vim.api.nvim_set_keymap('n', '<C-a>', '<esc>ggVG',           { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<esc>ggVG',           { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-a>', '<esc>ggVG',           { noremap = true, silent = true })

-- | Reload config
vim.api.nvim_set_keymap('n', '<leader>dr', ':so %<cr>',                       { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>dr', ':so ~/.config/nvim/init.lua<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dp', ':PackerInstall<cr>',              { noremap = true, silent = true })

-- | Make p in `VISUAL` adequate
vim.api.nvim_set_keymap('v', 'p', '"_dP',                    { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'P', '"_dP',                    { noremap = true, silent = true })

-- | Dublicate lines
vim.api.nvim_set_keymap('n', '<M-J>', ':t .<cr>==',          { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-K>', ':t .-1<cr>==',        { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-K>', '<Esc>:t .<cr>==gi',   { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-K>', ':t \'><cr>gv=gv',     { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-J>', '<Esc>:t .-1<cr>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-J>', ':t \'<-1<cr>gv=gv',   { noremap = true, silent = true })

-- | Print highlight group under cursor
vim.api.nvim_set_keymap('n', '<F10>', [[
  :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
]], { noremap = true, silent = true })

-- | Move cursor on wrapped lines with j/k
vim.cmd [[
  noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
]]

-- | Close current buffer instead of window
--vim.api.nvim_set_keymap('c', 'wq', 'w<bar>BufDel', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('c', 'q', 'BufDel',        { noremap = true, silent = true })
--vim.api.nvim_set_keymap('c', 'q!', 'BufDel!',      { noremap = true, silent = true })
vim.cmd [[
  cnoreabbrev wq w<bar>BufDel
  cnoreabbrev q BufDel
  cnoreabbrev q! BufDel!
]]

vim.api.nvim_set_keymap('n', 'p', ']p', { noremap = true, silent = true })

-- | Plugin world

-- | ranger.vim
-- | Bring ranger
vim.api.nvim_set_keymap('n', '<leader>v', ':Ranger<cr>', { noremap = true, silent = true })

-- | nerdcommenter
-- | Comment line (selection of lines), comment block
-- | vim.api.nvim_set_keymap("n", "<C-_>", "<cmd>lua require('Comment.api').gcc('V' --[[, cfg]])<cr>", { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap("v", "<C-_>", "<cmd>lua require('Comment.api').gcc('v' --[[, cfg]])<cr>", { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap("n", "?",     "<cmd>lua require('Comment.api').gbc('V' --[[, cfg]])<cr>", { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap("v", "?",     "<cmd>lua require('Comment.api').gbc('v' --[[, cfg]])<cr>", { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap("n", "<C-_>", "<cmd>lua require('Comment.api').toggle()<cr>", { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap("v", "<C-_>", "<cmd>lua require('Comment.api').toggle()<cr>", { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap("n", "?",     "<cmd>lua require('Comment.api').toggle()<cr>", { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap("v", "?",     "<cmd>lua require('Comment.api').toggle()<cr>", { noremap = true, silent = true })

-- | hop.nvim
-- | Display words
vim.api.nvim_set_keymap('n', 'f', '<cmd>lua require"hop".hint_words()<cr>', { noremap = true, silent = true })

-- | gitgutter.vim
-- | Bind goto hunk and hunk preview vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
--vim.api.nvim_set_keymap('n', 'gz', '<Plug>(GitGutterPreviewHunk)', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'g[', '<Plug>(GitGutterPrevHunk)',    { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'g]', '<Plug>(GitGutterNextHunk)',    { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'g]', '<Plug>(GitGutterNextHunk)',    { noremap = true, silent = true })

-- | vim-surround
-- | Surround word
vim.api.nvim_set_keymap('n', 'S', 'ysiw', { noremap = false, silent = true })

-- | telescope.nvim
-- | Find files (Ctrl-P)
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>]],  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>',      '<cmd>lua require"telescope.builtin".find_files({ hidden = true })<cr>',      { noremap = true, silent = true })
-- | The rest junk
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require"telescope.builtin".current_buffer_fuzzy_find()<cr>',          { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require"telescope.builtin".help_tags()<cr>',                          { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>lua require"telescope.builtin".tags()<cr>',                               { noremap = true, silent = true })
-- | vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>lua require"telescope.builtin".grep_string()<cr>',                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fp', '<cmd>lua require"telescope.builtin".live_grep()<cr>',                          { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', '<cmd>lua require"telescope.builtin".tags{ only_current_buffer = true }<cr>',   { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?',  '<cmd>lua require"telescope.builtin".oldfiles()<cr>',                           { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fd',  '<cmd>lua require"telescope.builtin".lsp_document_diagnostics({ initial_mode = "normal" })<cr>',                           { noremap = true, silent = true })

-- | bufferline.nvim
vim.api.nvim_set_keymap('n', '<M-i>',  '<cmd>BufferLineCyclePrev<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-o>',  '<cmd>BufferLineCycleNext<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-ш>',  '<cmd>BufferLineCyclePrev<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-щ>',  '<cmd>BufferLineCycleNext<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '(',      '<cmd>BufferLineMovePrev <cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ')',      '<cmd>BufferLineMoveNext <cr>', { noremap = true, silent = true })

-- | tmux.nvim
vim.api.nvim_set_keymap('n', '<M-h>',  [[<cmd>lua require'tmux'.move_left()<cr>]]   , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-j>',  [[<cmd>lua require'tmux'.move_bottom()<cr>]] , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-k>',  [[<cmd>lua require'tmux'.move_top()<cr>]]    , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-l>',  [[<cmd>lua require'tmux'.move_right()<cr>]]  , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-р>',  [[<cmd>lua require'tmux'.move_left()<cr>]]   , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-о>',  [[<cmd>lua require'tmux'.move_bottom()<cr>]] , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-л>',  [[<cmd>lua require'tmux'.move_top()<cr>]]    , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-д>',  [[<cmd>lua require'tmux'.move_right()<cr>]]  , { noremap = true, silent = true })

--vim.api.nvim_set_keymap('v', '//', 'y/\\/<C-R>=escape(@",'/\\')<CR><CR>', { noremap = true, silent = true })
--vim.cmd [[ vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR> ]]
vim.cmd [[ vnoremap // "hy:%s/<C-r>h//gc<left><left><left> ]]

-- | tmux.nvim
vim.api.nvim_set_keymap('n', '<leader>trr',  [[<cmd>lua require'rest-nvim'.run()<cr>]]      , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>trp',  [[<cmd>lua require'rest-nvim'.preview()<cr>]]  , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>trl',  [[<cmd>lua require'rest-nvim'.run_last()<cr>]] , { noremap = true, silent = true })

-- | rnvimr
vim.api.nvim_set_keymap('n', '<leader>r',  [[<cmd>RnvimrToggle<cr>]] , { noremap = true, silent = true })

