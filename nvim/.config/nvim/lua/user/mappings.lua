-- VIM world

-- TODO: refactor mappings

-- FIX RUSSIAN ;->$
vim.keymap.set('n', ';', '$'--[[ , { unique = true } ]])

-- Open with xdg-open
-- vim.keymap.set('n', 'gx', '<cmd>silent :execute "!xdg-open " .. shellescape("%:p:h/<cfile>")<cr>', { noremap = true, silent = true, });

-- Toggle 80 color column
vim.keymap.set('n', '<leader>ul', function()
  if vim.opt.colorcolumn == 80 then
    vim.o.colorcolumn = 0
  else
    vim.o.colorcolumn = 80
  end
end, { desc = 'Toggle color column (the 80th line rule)' })

-- Toggle wrap
vim.keymap.set(
  'n',
  '<leader>uw',
  '<cmd>set wrap!<cr>',
  { desc = 'Toggle word wrap' }
)

-- Unmap <space> so it don't interfere with the leader>
vim.keymap.set('n', '<space>', '<nop>')

-- Unmap the fucking stupid annoying ass Ex mode or whatever the
-- q:, Q, gQ, c_CTRL-F, q:, q/, q?
vim.keymap.set({ 'n', 'v' }, 'q:', '<nop>')
vim.keymap.set({ 'n', 'v' }, 'Q', '<nop>')
vim.keymap.set({ 'n', 'v' }, 'gQ', '<nop>')
vim.keymap.set({ 'n', 'v' }, 'q:', '<nop>')
vim.keymap.set({ 'n', 'v' }, 'q?', '<nop>')

-- Make db adequate (include char under cursor)
-- vim.keymap.set('n', 'db', 'dvb')

-- Redirect x/X to void register (so x/X do not overwrite clipboard)
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')

-- Select all: Ctrl-A
vim.keymap.set('', '<C-a>', '<esc>ggVG')

-- Remap Ctrl-A functionality to something else then:
vim.keymap.set('n', '<C-c>', '<C-a>')

-- Reload config
vim.keymap.set('n', '<leader>dr', ':so %<cr>')
--vim.keymap.set('n', '<leader>dr', ':so ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<leader>dp', ':PackerInstall<cr>')

-- Make p in `VISUAL` adequate
vim.keymap.set('v', 'p', '"_dP')
vim.keymap.set('v', 'P', '"_dP') -- sdfsdf asdf as fasd as f

-- Dublicate lines
vim.keymap.set('n', '<M-J>', ':t .<cr>==')
vim.keymap.set('n', '<M-K>', ':t .-1<cr>==')
vim.keymap.set('i', '<M-K>', '<Esc>:t .<cr>==gi')
vim.keymap.set('v', '<M-K>', ":t '><cr>gv=gv")
vim.keymap.set('i', '<M-J>', '<Esc>:t .-1<cr>==gi')
vim.keymap.set('v', '<M-J>', ":t '<-1<cr>gv=gv")

-- Move cursor on wrapped lines with j/k
vim.cmd [[
  noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
]]

-- Close current buffer instead of window
--vim.keymap.set('c', 'wq', 'w<bar>BufDel')
--vim.keymap.set('c', 'q', 'BufDel')
--vim.keymap.set('c', 'q!', 'BufDel!')
vim.cmd [[
  cnoreabbrev wq w<bar>BufDel
  cnoreabbrev q BufDel
  cnoreabbrev q! BufDel!
]]

-- Like "p", but adjust the indent to the current line
vim.keymap.set('n', 'p', ']p')

-- Latex
-- Toggle compile on save
vim.keymap.set('n', '<leader><leader>lc', function()
  vim.g.compile_tex = not vim.g.compile_tex
end, {
  desc = 'Toggle compile on save (latex)',
})
-- Open preview
vim.keymap.set(
  'n',
  '<leader><leader>lp',
  [[<cmd>!zathura $(printf % \| sed 's/tex$/pdf/g') & disown<cr>]],
  {
    desc = 'Open preview (latex)',
  }
)

-- Stay selected when shifting line with < >
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- More undo checkpoints in insert mode - on punctuation marks
vim.keymap.set('i', ',', '<C-g>u,')
vim.keymap.set('i', '.', '<C-g>u.')
vim.keymap.set('i', '!', '<C-g>u!')
vim.keymap.set('i', '?', '<C-g>u?')
vim.keymap.set('i', ';', '<C-g>u;')
vim.keymap.set('i', ':', '<C-g>u:')
vim.keymap.set('i', '/', '<C-g>u/')

-- Cycle open buffers
vim.keymap.set('n', '<m-i>', '<cmd>:bprevious<cr>')
vim.keymap.set('n', '<m-o>', '<cmd>:bnext<cr>')
vim.keymap.set('n', '<m-ш>', '<cmd>:bprev<cr>')
vim.keymap.set('n', '<m-щ>', '<cmd>:bnext<cr>')

-- Search selected text
vim.cmd [[ vnoremap // "hy:%s/\V<C-r>h//gc<left><left><left>]]

-- Center horizontally
vim.keymap.set({ 'n', 'v' }, 'z.', ':<C-u>normal! zszH<CR>', { silent = true })
