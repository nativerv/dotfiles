-- | Lsp world

-- | nvim-lspconfig
local lspconfig  = require'lspconfig'
-- | local lsp_signature = require'lsp_signature'

-- | More logs
vim.lsp.set_log_level("debug")

local on_attach = function(client, buffer)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- | Define commands
  -- Formatting
  vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting, {})

  -- | Define mappings (for lsp buffers only)

  -- Diagnostic and goto mappings
  local map = vim.keymap.set
  local map_opts = { noremap = true, silent = true }
  map('n', 'gD', vim.lsp.buf.declaration, map_opts)
  map('n', 'gh', vim.lsp.buf.hover, map_opts)
  map('n', 'gH', vim.lsp.buf.signature_help, map_opts)
  map('n', 'gt', vim.lsp.buf.type_definition, map_opts)
  map('n', '<F2>', vim.lsp.buf.rename, map_opts)
  map('n', 'gn', vim.lsp.buf.rename, map_opts)
  map('n', 'gd', function() require"telescope.builtin".lsp_definitions({ initial_mode = "normal"}) end, map_opts)
  map('n', 'gi', function() require"telescope.builtin".lsp_implementations({ initial_mode = "normal"}) end, map_opts)
  map('n', 'gr', function() require"telescope.builtin".lsp_references({ initial_mode = "normal"}) end, map_opts)
  map('n', 'gy', vim.lsp.buf.code_action, map_opts)
  map('v', 'gy', vim.lsp.buf.range_code_action, map_opts)
  map('n', 'gl', function() vim.diagnostic.open_float({ border = 'rounded', }) end, map_opts)
  map('n', '[', vim.diagnostic.goto_prev, map_opts)
  map('n', ']', vim.diagnostic.goto_next, map_opts)

  -- | Configure diagnostics appearance
  vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }

  -- | Format on save
  --vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Format ]]

  -- | Customize diagnostic signs
  -- | "       ﴫ כֿ   ﯦ         ⏼  𥉉    ﱥ ﯂         ﯇    﫝           ﯦ ﯧ     窱
  local hl_error = 'DiagnosticSignError'
  local hl_warn = 'DiagnosticSignWarn'
  local hl_hint = 'DiagnosticSignHint'
  local hl_info = 'DiagnosticSignInfo'
  vim.fn.sign_define(hl_error, { text = " ", texthl = hl_error, numhl = hl_error, })
  vim.fn.sign_define(hl_warn, { text = " ", texthl = hl_warn, numhl = hl_warn, })
  vim.fn.sign_define(hl_hint, { text = " ", texthl = hl_hint, numhl = hl_hint, })
  vim.fn.sign_define(hl_info, { text = " ", texthl = hl_info, numhl = hl_info, })
end

-- | Include capabilities from plugins
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

-- | Enable the following language servers
local lsps = {
  clangd = {},
  rust_analyzer = {},
  pyright = {},
  tsserver = {
    cmd = { "typescript-language-server", "--stdio", "--tsserver-log-file", vim.loop.os_homedir() .. "/.cache/nvim/tsserver.log" }
    --cmd = { "tsserver" }
  },
  hls = {
    settings = {
      haskell = {
        formattingProvider = 'ormolu',
        plugin = {
          ["hls-haddock-comments-plugin"] = {
            globalOn = true,
          },
        },
      },
    },
  },
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
        root_dir = vim.loop.cwd(),
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
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      }
    }
  },
  -- | glslls = {},
  -- | phpactor = {},
  dockerls = {},
  texlab = {},
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})


-- | Set dafault window border (added because :LspInfo doesn't have borders by default)
require'lspconfig.ui.windows'.default_options.border = 'single'

-- | local handlers =  {
-- |   ["textDocument/hover"]         =  vim.lsp.with(vim.lsp.handlers.hover,          {border = border}),
-- |   ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
-- | }

-- | Execute all configs and inject common capabilities to them
for lsp, lsp_config in pairs(lsps) do
  -- | Merge configs with custom function
  local default_config = {
    on_attach    = on_attach,
    capabilities = capabilities,
    -- | handlers = handlers,
  }

  local config = vim.tbl_extend('force', default_config, lsp_config)

  lspconfig[lsp].setup (config)
end

-- | Null-ls
require'null-ls'.setup {
  sources = {
    require'null-ls'.builtins.diagnostics.shellcheck.with {
      diagnostics_format = '[#{c}] #{m} (#{s})',
      filetypes = { 'sh' },
      extra_args = { '-o', 'all' },
    },
    require'null-ls'.builtins.formatting.shfmt,
    require'null-ls'.builtins.formatting.stylua,
  },
  debug = true,
  on_attach = on_attach,
  capabilities = capabilities,
  autostart = true,
}

-- | luasnip
local luasnip = require'luasnip'

-- nvim-cmp
require'cmp'.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<c-k>'] = require'cmp'.mapping.select_prev_item(),
    ['<c-j>'] = require'cmp'.mapping.select_next_item(),
    ['<c-d>'] = require'cmp'.mapping.scroll_docs(4),
    ['<c-u>'] = require'cmp'.mapping.scroll_docs(-4),
    ['<c-space>'] = require'cmp'.mapping(require'cmp'.mapping.complete(), { 'i', 's' }),
    ['<c-e>'] = require'cmp'.mapping.close(),
    ['<cr>'] = require'cmp'.mapping.confirm {
      behavior = require'cmp'.ConfirmBehavior.Replace,
      select = false,
    },
    ['<tab>'] = require'cmp'.mapping(require'cmp'.mapping.select_next_item(), { 'i', 's' }),
    ['<s-tab>'] = require'cmp'.mapping(require'cmp'.mapping.select_prev_item(), { 'i', 's' }),
  },
  formatting = {
    format = require'lspkind'.cmp_format { with_text = true, maxwidth = 50,  }
  },
  sources = {
    -- `keyword_length` is for debouncing cmp for text until at least 5 symbols is typed
    { name = 'nvim_lsp', keyword_length = 2, priority = 100, },
    { name = 'nvim_lua', keyword_length = 2, priority = 99,  },
    { name = 'luasnip',  keyword_length = 2, priority = 97,  },
    { name = 'orgmode',  keyword_length = 3, priority = 96,  },
    { name = 'path',     keyword_length = 3, priority = 95,  },
    { name = 'buffer',   keyword_length = 5, priority = 94,  },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}
