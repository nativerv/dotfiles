-- | require'lsp/custom_languages/glslls'

-- | Neovim world

-- | Plugin (normal plugin) world
-- | require'nvim-treesitter.parsers'.get_parser_configs().org = {
-- |   install_info = {
-- |     url = 'https://github.com/milisims/tree-sitter-org',
-- |     revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
-- |     files = { 'src/parser.c', 'src/scanner.cc' },
-- |   },
-- |   filetype = 'org',
-- | }
-- |
--

--require'indent_blankline'.setup {
--    char                           = '┊',
--    -- | char                           = '│',
--    show_trailing_blankline_indent = false,
--    buftype_exclude                = { 'terminal' },
--    show_current_context = true,
--    show_current_context_start = false,
--}



-- | require'orgmode'.setup {
-- |   org_agenda_files = { os.capture('xdg-user-dir ' .. 'DOCUMENTS', false) .. '/notes/org/*' },            -- | Can contain multiple locations
-- |   org_default_notes_file = os.capture('xdg-user-dir ' .. 'DOCUMENTS', false) .. '/notes/org/refile.org',
-- | }


-- require'bufferline'.setup {
--   options = {
--     indicator_icon = ' ',
--   }
-- }
--require'org-bullets'.setup()
--require'stabilize'.setup {
--  ignore = {
--    -- | Removing help from there not working for some reason
--    filetype = { "list", "Trouble" },
--  }
--}

-- | require'lspsaga'.init_lsp_saga {
-- |   use_saga_diagnostic_sign = false,
-- |   code_action_prompt = {
-- |     enable = false,
-- |     -- | sign = false,
-- |   },
-- |   rename_action_keys = {
-- |     quit = "<C-c>",
-- |     exec = "<cr>",
-- |   },
-- |   -- | border_style = 'rounded',
-- | }
--require'rust-tools'.setup {}

-- | local dap = require'dap'
-- | dap.adapters.lldb = {
-- |   type = 'executable',
-- |   command = '/usr/bin/lldb-vscode', -- adjust as needed
-- |   name = "lldb"
-- | }
-- | dap.configurations.rust = {
-- |   {
-- |     name = "Launch file",
-- |     type = "lldb",
-- |     request = "launch",
-- |     program = function()
-- |       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
-- |     end,
-- |     cwd = '${workspaceFolder}',
-- |     stopOnEntry = true,
-- |   },
-- | }

-- | require'lsp-colors'.setup (lsp_colors)
-- | require'onedark'.setup {
-- |   comment_style = 'NONE',
-- | }

-- | require'neogit'.setup {}

-- | Lsp world

-- | nvim-lspconfig
local lspconfig  = require'lspconfig'
-- | local lsp_signature = require'lsp_signature'

-- | More logs
vim.lsp.set_log_level("debug")

local on_attach = function(client, buffer)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- | Attach lsp_signature
-- |   lsp_signature.on_attach({
-- |     use_lspsaga = true,
-- |   }, client)

  -- | Define commands

  -- | Formatting
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- | Define mappings (for lsp buffers only)

  -- Diagnostic and goto mappings
  local map = vim.keymap.set
  local map_opts = { noremap = true, silent = true }
  map('n', 'gD', vim.lsp.buf.declaration, map_opts)
  map('n', 'gh', vim.lsp.buf.hover,                        map_opts)
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
local default_windows_opts = require'lspconfig.ui.windows'.default_opts
require'lspconfig.ui.windows'.default_opts = function(options)
  local opts = default_windows_opts(options)
  opts.border = 'single'
  return opts
end

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
    require'null-ls'.builtins.formatting.shfmt
  },
  debug = true,
  on_attach = on_attach,
  capabilities = capabilities,
  autostart = true,
}

-- | luasnip
local luasnip = require'luasnip'

-- | nvim-cmp
local cmp = require'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 's' }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<cr>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
  },
  formatting = {
    format = require'lspkind'.cmp_format { with_text = true, maxwidth = 50,  }
  },
  sources = {
    { name = 'nvim_lsp', keyword_length = 2, priority = 100, },
    { name = 'nvim_lua', keyword_length = 2, priority = 99,  },
    { name = 'luasnip',  keyword_length = 2, priority = 97,  },
    { name = 'orgmode',  keyword_length = 3, priority = 96,  },
    { name = 'path',     keyword_length = 3, priority = 95,  },
    { name = 'buffer',   keyword_length = 5, priority = 94,  }, -- | keyword_length is for debouncing cmp for text until at least 5 symbols is typed
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}
