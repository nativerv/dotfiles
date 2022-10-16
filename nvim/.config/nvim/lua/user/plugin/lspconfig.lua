local M = {}

M.setup = function()
  -- More logs
  vim.lsp.set_log_level 'debug'

  ---@diagnostic disable-next-line: unused-local
  M.on_attach = function(client, buffer)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Define commands
    vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting, {})

    -- Define mappings (for lsp buffers only)
    local map = vim.keymap.set
    local map_opts = { noremap = true, silent = true }
    -- stylua: ignore start
    map('n', 'gD', vim.lsp.buf.declaration, map_opts)
    map('n', 'gh', vim.lsp.buf.hover, map_opts)
    map('n', 'gH', vim.lsp.buf.signature_help, map_opts)
    map('n', 'gt', vim.lsp.buf.type_definition, map_opts)
    map('n', 'gn', vim.lsp.buf.rename, map_opts)
    map('n', 'gd', function() require'telescope.builtin'.lsp_definitions({ initial_mode = "normal"}) end, map_opts)
    map('n', 'gi', function() require'telescope.builtin'.lsp_implementations({ initial_mode = "normal"}) end, map_opts)
    map('n', 'gr', function() require'telescope.builtin'.lsp_references({ initial_mode = "normal"}) end, map_opts)
    map('n', 'gy', vim.lsp.buf.code_action, map_opts)
    map('v', 'gy', vim.lsp.buf.range_code_action, map_opts)
    map('n', 'gl', function() vim.diagnostic.open_float({ border = 'rounded', }) end, map_opts)
    map('n', 'gE',  vim.diagnostic.goto_prev, map_opts)
    map('n', 'ge',  vim.diagnostic.goto_next, map_opts)
    -- stylua: ignore end

    -- Configure diagnostics appearance
    vim.diagnostic.config {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    -- Customize diagnostic signs
    -- "       ﴫ כֿ   ﯦ         ⏼  𥉉    ﱥ ﯂         ﯇    﫝           ﯦ ﯧ     窱
    local hl_error = 'DiagnosticSignError'
    local hl_warn = 'DiagnosticSignWarn'
    local hl_hint = 'DiagnosticSignHint'
    local hl_info = 'DiagnosticSignInfo'
    -- stylua: ignore start
    vim.fn.sign_define(hl_error, { text = " ", texthl = hl_error, numhl = hl_error, })
    vim.fn.sign_define(hl_warn,  { text = " ", texthl = hl_warn,  numhl = hl_warn,  })
    vim.fn.sign_define(hl_hint,  { text = " ", texthl = hl_hint,  numhl = hl_hint,  })
    vim.fn.sign_define(hl_info,  { text = " ", texthl = hl_info,  numhl = hl_info,  })
    -- stylua: ignore end
  end

  -- Include capabilities from plugins
  M.capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Enable the following language servers
  local lsps = {
    clangd = {},
    rust_analyzer = {},
    pyright = {},
    tsserver = {
      cmd = {
        'typescript-language-server',
        '--stdio',
        '--tsserver-log-file',
        vim.fn.stdpath 'cache' .. '/tsserver.log',
      },
    },
    hls = {
      settings = {
        haskell = {
          formattingProvider = 'ormolu',
          plugin = {
            ['hls-haddock-comments-plugin'] = {
              globalOn = true,
            },
          },
        },
      },
    },
    bashls = {
      cmd = { 'bash-language-server', 'start' },
      filetypes = { 'sh', 'zsh' },
    },
    sumneko_lua = {
      cmd = {
        'lua-language-server',
        '-E',
        '/usr/lib/lua-language-server/main.lua',
      },
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
          },
          --root_dir = lspconfig.util.root_pattern(".git") or bufdir,
          --root_dir = bufdir,
          root_dir = vim.loop.cwd(),
          --root_dir = function(fname)
          --local root_pattern = lspconfig.util.root_pattern('.git', '*.rockspec')(fname)

          -- Prevent indexing $HOME
          --if fname == vim.loop.os_homedir() then return nil end

          --return root_pattern or fname
          --end,
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand '$VIMRUNTIME/lua'] = true,
              [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
            },
            maxPreload = 2000,
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    -- glslls = {},
    -- phpactor = {},
    dockerls = {},
    texlab = {},
  }

  vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })

  -- Set dafault window border (added because :LspInfo doesn't have borders by default)
  require('lspconfig.ui.windows').default_options.border = 'rounded'

  -- Execute all configs and inject common capabilities to them
  for lsp, lsp_config in pairs(lsps) do
    -- Merge configs with custom function
    local default_config = {
      on_attach = M.on_attach,
      capabilities = M.capabilities,
    }

    local config = vim.tbl_extend('force', default_config, lsp_config)
    require('lspconfig')[lsp].setup(config)
  end
end

return M
