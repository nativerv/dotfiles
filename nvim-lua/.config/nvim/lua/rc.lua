-- | Neovim world

-- | Customize diagnostic signs
vim.cmd [[
  "       ﴫ כֿ   ﯦ         ⏼  𥉉    ﱥ ﯂         ﯇    﫝           ﯦ ﯧ     窱

  " Same as in lualine.nvim
  sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
  sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
  sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
]]

-- | Plugin (normal plugin) world

require'indent_blankline'.setup {
    --char                           = '┊',
    char                           = '│',
    show_trailing_blankline_indent = false,
    buftype_exclude                = { 'terminal' }
}
require'gitsigns'.setup {
  signs = {
    add          = { hl = 'GitGutterAdd',    text = '│' },
    change       = { hl = 'GitGutterChange', text = '│' },
    changedelete = { hl = 'GitGutterChange', text = '│' },
    delete       = { hl = 'GitGutterDelete', text = '' },
    topdelete    = { hl = 'GitGutterDelete', text = '' },
  },
}
require'lualine'.setup {
  sections = {
    lualine_c = {
      "os.data('%a')",
      'data',
      require'lsp-status'.status,
      'pidorass'
    }
  }
}

require'colorizer'.setup()
require'nvim-autopairs'.setup()
require'bufferline'.setup()
require'lsp-status'.register_progress()

-- | Lsp world

-- | nvim-lspconfig
local lspconfig  = require'lspconfig'
local lsp_status = require'lsp-status'
local null_ls = require'null-ls'

null_ls.config {
  sources = {
    null_ls.builtins.diagnostics.shellcheck.with {
      diagnostics_format = '[#{c}] #{m} (#{s})',
      filetypes = { 'sh' },
    },
    null_ls.builtins.formatting.shfmt
  },
  debug = true
}

local on_attach = function(client, buffer)
  -- | Some bullshit
  vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- | Attach lsp-status
  lsp_status.on_attach(client)

  -- | Define commands

  -- | Formatting
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- | Define mappings (for this buffer only)

  -- | Diagnostic and goto mappings
  local mapping_options = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',                   mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>',                  mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>',                        mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',               mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gH', '<cmd>lua vim.lsp.buf.signature_help()<CR>',               mapping_options)
  --vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', mapping_options)
  --vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', mapping_options)
  --vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>',              mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>',                     mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>',                   mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gy', '<cmd>lua vim.lsp.buf.code_action()<CR>',                  mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'v', 'gy', '<cmd>lua vim.lsp.buf.range_code_action()<CR>',            mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gK', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', '[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',              mapping_options)
  vim.api.nvim_buf_set_keymap(buffer, 'n', ']', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',              mapping_options)
  --vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', mapping_options)
  --vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], mapping_options)

  -- | Formatting mapping

  -- | Format on save
  vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Format ]]
end

-- | Create a command to get `lsp-status.nvim` output
vim.cmd [[
  function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      return luaeval("require'lsp-status'.status()")
    endif

    return ''
  endfunction

  command! LspStatus call LspStatus()
]]

-- | Include capabilities from plugins
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

-- | Enable the following language servers
local lsps = {
  clangd = {},
  rust_analyzer = {},
  pyright = {},
  tsserver = {},
  hls = {},
  bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'zsh' }
  },
  sumneko_lua = {
    cmd = { 'lua-language-server', '-E', '/usr/lib/lua-language-server/main.lua' },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';')
        },
        --root_dir = lspconfig.util.root_pattern(".git") or bufdir,
        --root_dir = bufdir,
        --root_dir = vim.loop.cwd(),
        --root_dir = function(fname)
          --local root_pattern = lspconfig.util.root_pattern('.git', '*.rockspec')(fname)

          ---- | Prevent indexing $HOME
          --if fname == vim.loop.os_homedir() then return nil end

          --return root_pattern or fname
        --end,
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' }
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
          },
          maxPreload = 2000,
        },
        telemetry = {
          enable = false,
        },
      }
    }
  },
  ['null-ls'] = {
    autostart = true,
  },
}

-- | Execute all configs and inject common capabilities to them
for lsp, lsp_config in pairs(lsps) do
  -- | Merge configs with custom function
  local default_config = {
    on_attach    = on_attach,
    capabilities = capabilities,
  }
  local config = merge(default_config, lsp_config)

  lspconfig[lsp].setup (config)
end

-- | luasnip
local luasnip = require'luasnip'

-- | nvim-cmp
local cmp = require'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- | null-ls
--local null_ls = require'null-ls'
