vim.cmd [[ colorscheme onedark ]]

-- | TODO: Move this outta here
require'colorizer'.setup()
require'nvim-autopairs'.setup()
require'indent_blankline'.setup {
    char = '|',
    buftype_exclude = { 'terminal' }
}
require'lualine'.setup()
require("bufferline").setup()
