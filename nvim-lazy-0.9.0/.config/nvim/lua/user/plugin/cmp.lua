local M = {}

M.setup = function()
  local config = {}

  config.mapping = {
    ['<c-k>'] = require('cmp').mapping.select_prev_item(),
    ['<c-j>'] = require('cmp').mapping.select_next_item(),
    ['<c-d>'] = require('cmp').mapping.scroll_docs(4),
    ['<c-u>'] = require('cmp').mapping.scroll_docs(-4),
    ['<c-space>'] = require('cmp').mapping(
      require('cmp').mapping.complete(),
      { 'i', 's' }
    ),
    ['<c-e>'] = require('cmp').mapping.close(),
    ['<cr>'] = require('cmp').mapping.confirm {
      behavior = require('cmp').ConfirmBehavior.Replace,
      select = false,
    },
    ['<tab>'] = require('cmp').mapping(
      require('cmp').mapping.select_next_item(),
      { 'i', 's' }
    ),
    ['<s-tab>'] = require('cmp').mapping(
      require('cmp').mapping.select_prev_item(),
      { 'i', 's' }
    ),
  }
  -- config.formatting = {
  --   format = require('lspkind').cmp_format {
  --     with_text = true,
  --     maxwidth = 50,
  --   },
  -- }
  config.sources = {
    -- `keyword_length` is for debouncing cmp for text until at least 5 symbols is typed
    { name = 'nvim_lsp', keyword_length = 2, priority = 100 },
    { name = 'nvim_lua', keyword_length = 2, priority = 99 },
    { name = 'path', keyword_length = 3, priority = 95 },
    { name = 'buffer', keyword_length = 5, priority = 94 },
  }
  config.experimental = {
    native_menu = false,
    ghost_text = true,
  }
  -- Add luasnip only if it's installed
  local has_luasnip, luasnip = pcall(require, 'luasnip')
  if has_luasnip then
    config.snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    }
    table.insert(
      config.sources,
      { name = 'luasnip', keyword_length = 2, priority = 97 }
    )
  end

  require('cmp').setup(config)
end

return M
