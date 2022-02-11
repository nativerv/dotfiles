-- | require'lsp/custom_languages/glslls'
local util = require'utils'

-- | Neovim world

-- | Plugin (normal plugin) world
require'nvim-treesitter.parsers'.get_parser_configs().org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { 'sh', 'org' },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 10000, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

require'indent_blankline'.setup {
    char                           = '┊',
    -- | char                           = '│',
    show_trailing_blankline_indent = false,
    buftype_exclude                = { 'terminal' },
    show_current_context = true,
    show_current_context_start = false,
}
local gitsigns_bar = '│'
require'gitsigns'.setup {
  signs = {
    add          = { hl = 'GitGutterAdd',    text = gitsigns_bar },
    change       = { hl = 'GitGutterChange', text = gitsigns_bar },
    changedelete = { hl = 'GitGutterChange', text = gitsigns_bar },
    delete       = { hl = 'GitGutterDelete', text = '' },
    topdelete    = { hl = 'GitGutterDelete', text = '' },
  },
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n g['] = { expr = true, "&diff ? 'g[' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'"},
    ['n g]'] = { expr = true, "&diff ? 'g]' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'"},

    ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<cr>',
    ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
    --['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<cr>',
    --['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
    --['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<cr>',
    ['n gz'] = '<cmd>lua require"gitsigns".preview_hunk()<cr>',
    --['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<cr>',
    --['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<cr>',
    --['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<cr>',

    --['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<cr>',
    --['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<cr>'
  },
}
require'lualine'.setup {
  options = {
    -- | theme = 'pywal'
    theme = 'wal'
  },
  sections = {
    lualine_c = {
      "os.data('%a')",
      'data',
      -- | TODO: figure out what to do with this unused plugin, delete it or properly integrate
      -- | Search for lsp-status and lsp_status
      --require'lsp-status'.status,
    }
  }
}
require'telescope'.setup {
  pickers = {
    find_files = {
      hidden = true,
      --no_ignore = true,
    },
    live_grep = {
      hidden = true,
      --no_ignore = true,
    },
  }
}
require'orgmode'.setup {
  org_agenda_files = { os.capture('xdg-user-dir ' .. 'DOCUMENTS', false) .. '/notes/org/*' },            -- | Can contain multiple locations
  org_default_notes_file = os.capture('xdg-user-dir ' .. 'DOCUMENTS', false) .. '/notes/org/refile.org',
}

require'colorizer'.setup ()
require'nvim-autopairs'.setup ()
require'bufferline'.setup {
  options = {
    indicator_icon = ' ',
  }
}
-- | TODO: figure out what to do with this unused plugin, delete it or properly integrate
-- | require'lsp-status'.register_progress()
--require'org-bullets'.setup()
require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
require'stabilize'.setup {
  ignore = {
    -- | Removing help from there not working for some reason
    filetype = { "list", "Trouble" },
  }
}
require'tmux'.setup {
  navigation = {
    -- | Cycles to opposite pane while navigating into the border
    cycle_navigation = false,
  },
}
require'which-key'.setup {}
require'rest-nvim'.setup {
  -- Open request results in a horizontal split
  result_split_horizontal = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Highlight request on run
  highlight = {
    enabled = true,
    timeout = 150,
  },
  result = {
    -- toggle showing URL, HTTP info, headers at top the of result window
    show_url = true,
    show_http_info = true,
    show_headers = true,
  },
  -- Jump to request line on run
  jump_to_request = false,
  env_file = '.env',
  custom_dynamic_variables = {},
}
require'lspsaga'.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  code_action_prompt = {
    --enable = false,
    sign = false,
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<cr>",
  },
  -- | border_style = 'rounded',
}
--require'rust-tools'.setup {}
require'Comment'.setup {
  -- | LHS of toggle mappings in NORMAL + VISUAL mode
  -- | type table
  toggler = {
      -- | line-comment keymap
      line = 'gcc',
      -- | block-comment keymap
      block = 'gCC',
  },

  -- | LHS of operator-pending mappings in NORMAL + VISUAL mode
  -- | @type table
  opleader = {
      -- | line-comment keymap
      line = 'gc',
      -- | block-comment keymap
      block = 'gC',
  },
  -- | @param ctx Ctx
  pre_hook = function(ctx)
    -- | Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == 'typescriptreact' then
      local U = require('Comment.utils')

      -- | Detemine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

      -- | Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
        key = type,
        location = location,
      })
    end
  end,
}
-- | Customize comment strings
require'Comment.ft'
-- |            line comment  block comment
  .set('lua', { '-- | %s',    '-- [[ %s ]]' })

local dap = require'dap'
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}
require'lsp-colors'.setup {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
}
require'onedark'.setup {
  comment_style = 'NONE',
}
require'neogit'.setup {}

-- | Lsp world

-- | nvim-lspconfig
local lspconfig  = require'lspconfig'
-- | local lsp_status = require'lsp-status'
local lsp_signature = require'lsp_signature'
local null_ls = require'null-ls'

null_ls.setup {
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
  -- | TODO: figure out what to do with this unused plugin, delete it or properly integrate
  -- | lsp_status.on_attach(client)

  -- | Attach lsp_signature
  lsp_signature.on_attach({
    use_lspsaga = true,
  }, client)

  -- | Define commands

  -- | Formatting
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- | Define mappings (for lsp buffers only)

  -- | Diagnostic and goto mappings
  local mapping_options = { noremap = true, silent = true }
  local map = vim.api.nvim_buf_set_keymap
  map(buffer, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',                   mapping_options)
  map(buffer, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',                  mapping_options)
  map(buffer, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>',                        mapping_options)
  map(buffer, 'n', 'gi', '<cmd>lua require"telescope.builtin".lsp_implementations({ initial_mode = "normal"})<cr>',               mapping_options)
  map(buffer, 'n', 'gH', '<cmd>lua vim.lsp.buf.signature_help()<cr>',               mapping_options)
  --map(buffer, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', mapping_options)
  --map(buffer, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', mapping_options)
  --map(buffer, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', mapping_options)
  map(buffer, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>',              mapping_options)

  --map(buffer, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>',                     mapping_options)
  map(buffer, 'n', '<F2>', '<cmd>lua require("lspsaga.rename").rename()<cr>',       mapping_options)

  map(buffer, 'n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references({ initial_mode = "normal"})<cr>',                   mapping_options)

  --map(buffer, 'n', 'gy', '<cmd>lua vim.lsp.buf.code_action()<cr>',                  mapping_options)
  --map(buffer, 'v', 'gy', '<cmd>lua vim.lsp.buf.range_code_action()<cr>',            mapping_options)
  --map(buffer, 'n', 'gy', '<cmd>lua require"lspsaga.codeaction".code_action()<cr>',                  mapping_options)
  --map(buffer, 'v', 'gy', '<cmd>lua require"lspsaga.codeaction".range_code_action()<cr>',            mapping_options)
  map(buffer, 'n', 'gy', '<cmd>lua require"telescope.builtin".lsp_code_actions(require"telescope.themes".get_cursor({ initial_mode = "normal"}))<cr>',                                 mapping_options)
  map(buffer, 'v', 'gy', '<cmd>lua require"telescope.builtin".lsp_code_actions(require"telescope.themes".get_cursor({ initial_mode = "normal"}))<cr>',                                 mapping_options)

  map(buffer, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<cr>',            mapping_options)
  map(buffer, 'n', '[', '<cmd>lua vim.diagnostic.goto_prev()<cr>',              mapping_options)
  map(buffer, 'n', ']', '<cmd>lua vim.diagnostic.goto_next()<cr>',              mapping_options)
  --map(buffer, 'n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<cr>', mapping_options)
  --map(buffer, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], mapping_options)

  -- | Formatting mapping

  -- | Format on save
  --vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Format ]]

  -- | Configure diagnostics appearance
  vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }

  -- | Customize diagnostic signs
  -- | "       ﴫ כֿ   ﯦ         ⏼  𥉉    ﱥ ﯂         ﯇    﫝           ﯦ ﯧ     窱
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end


  -- | Open diagnostic float automatically
  vim.o.updatetime = 250
  -- | TODO: fix this to manual toggling:
  -- | vim.cmd [[ autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false, source = 'always' }) ]]
end

-- | Create a command to get `lsp-status.nvim` output
-- | TODO: figure out what to do with this unused plugin, delete it or properly integrate
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
-- | capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

-- | Enable the following language servers
local lsps = {
  clangd = {},
  rust_analyzer = {},
  pyright = {},
  tsserver = {
    cmd = { "typescript-language-server", "--stdio", "--tsserver-log-file", vim.loop.os_homedir() .. "/.cache/nvim/tsserver.log" }
    --cmd = { "tsserver" }
  },
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
  ['null-ls'] = {
    autostart = true,
  },
  -- | glslls = {},
  -- | phpactor = {},
  dockerls = {},
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
      select = true,
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
