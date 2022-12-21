local M = {}

M.server_configs = {}

M.on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Define commands
  vim.api.nvim_create_user_command('Format', function()
    vim.cmd.write()
    vim.lsp.buf.format { async = true }
    vim.cmd.write()
  end, {})

  -- Define mappings (for lsp buffers only)
  local default_map_opts = { noremap = true, silent = true }
  local map = function(mode, mapping, action, opts)
    vim.keymap.set(mode, mapping, action, opts or default_map_opts)
  end
  -- stylua: ignore start
  local float_opts = { border = 'rounded', }
  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gh', vim.lsp.buf.hover)
  map('n', 'gH', vim.lsp.buf.signature_help)
  map('n', 'gt', vim.lsp.buf.type_definition)
  map('n', 'gn', vim.lsp.buf.rename)
  map('n', 'gd', function() require 'telescope.builtin'.lsp_definitions({ initial_mode = "insert" }) end)
  map('n', 'gi', function() require 'telescope.builtin'.lsp_implementations({ initial_mode = "insert" }) end)
  map('n', 'gr', function() require 'telescope.builtin'.lsp_references({ initial_mode = "insert" }) end)
  map('n', 'gy', vim.lsp.buf.code_action)
  map('v', 'gy', vim.lsp.buf.range_code_action)
  map('n', 'gl', function() vim.diagnostic.open_float(float_opts) end)
  map('n', 'gE', function() vim.diagnostic.goto_prev({ float = float_opts }) end)
  map('n', 'ge', function() vim.diagnostic.goto_next({ float = float_opts }) end)
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
  vim.fn.sign_define(hl_warn, { text = " ", texthl = hl_warn, numhl = hl_warn, })
  vim.fn.sign_define(hl_hint, { text = " ", texthl = hl_hint, numhl = hl_hint, })
  vim.fn.sign_define(hl_info, { text = " ", texthl = hl_info, numhl = hl_info, })
  -- stylua: ignore end

  -- require('nvim-navic').attach(client, bufnr)
end

-- ---@diagnostic disable-next-line: unused-local
-- M.on_attach = function (client, bufnr) end

--- @param additional_on_attach function
M.extend_on_attach = function(lspconfig_config, additional_on_attach)
  local old_on_attach = lspconfig_config.on_attach
  lspconfig_config.on_attach = function(client, bufnr)
    old_on_attach(client, bufnr)
    additional_on_attach(client, bufnr)
  end

  -- Update `on_attach` in server configs
  lspconfig_config.configure_servers()
end

---@param server_configs table?
M.configure_servers = function(server_configs)
  local server_configs2 = server_configs
      or require('user.plugin.lspconfig').server_configs
  -- Execute all configs and inject common capabilities to them
  for lsp, lsp_config in pairs(server_configs2) do
    -- Merge configs with custom function
    local default_config = {
      on_attach = require('user.plugin.lspconfig').on_attach,
      capabilities = require('user.plugin.lspconfig').capabilities,
    }

    local config = vim.tbl_extend('force', default_config, lsp_config)
    require('lspconfig')[lsp].setup(config)
  end
end

M.setup = function()
  -- More logs
  -- vim.lsp.set_log_level 'debug'
  vim.lsp.set_log_level 'trace'
  if vim.fn.has 'nvim-0.5.1' == 1 then
    require('vim.lsp.log').set_format_func(vim.inspect)
  end

  ---@diagnostic disable-next-line: unused-local

  -- Include capabilities from plugins
  M.capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Enable the following language servers
  M.server_configs = {
    clangd = {},
    rust_analyzer = {},
    pyright = {},
    -- tsserver = {
    --   cmd = {
    --     'typescript-language-server',
    --     '--stdio',
    --     '--tsserver-log-file',
    --     vim.fn.stdpath 'cache' .. '/tsserver.log',
    --   },
    -- },
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
    -- sumneko_lua = {
    --   filetypes = { 'lua' },
    --   -- before_init = function(params)
    --   --   params.processId = vim.NIL
    --   -- end,
    --   cmd = require('lspcontainers').command('sumneko_lua', {
    --     container_runtime = 'podman',
    --     root_dir = require('lspconfig/util').find_git_ancestor(),
    --   }),
    --   root_dir = require('lspconfig/util').find_git_ancestor,
    --   settings = {
    --     Lua = {
    --       -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    --       telemetry = { enable = false },
    --       runtime = { version = 'LuaJIT' },
    --       -- Get the language server to recognize the `vim` global
    --       diagnostics = { globals = { 'vim' } },
    --       workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    --     },
    --   },
    -- },
    -- glslls = {},
    -- phpactor = {},
    dockerls = {},
    texlab = {},
    marksman = {},
  }

  -- Rounded borders
  vim.lsp.handlers['textDocument/hover'] =
  vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  -- Set dafault window border (added because :LspInfo doesn't have borders by default)
  require('lspconfig.ui.windows').default_options.border = 'rounded'

  M.configure_servers(M.server_configs)
end

return M
