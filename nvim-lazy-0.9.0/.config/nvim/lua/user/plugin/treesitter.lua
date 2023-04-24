local M = {}

M.rainbow_colors = {
  '#e06c75',
  '#e5c07b',
  '#98c379',
  '#56b6c2',
  '#61afef',
  '#c678dd',
}

M.setup = function()

  local configs = {}

  local captures = {}
  -- | ensure_installed = 'all',
  --{
  --  "bash",       "bibtex", "c",      "c_sharp",    "clojure", "cmake",   "comment",
  --  "commonlisp", "cpp",    "css",    "dockerfile", "dot",     "glsl",    "go",         "graphql",
  --  "haskell",    "help",   "hjson",  "html",       "http",    "java",    "javascript", "jsdoc",
  --  "json",       "json5",  "jsonc",  "latex",      "lua",     "make",    "markdown",   "ninja", "nix",
  --  "norg",       "perl",   "php",    "phpdoc",     "prisma",  "pug",     "python",     "ql", "regex",
  --  "ruby",       "rust",   "scheme", "scss",       "svelte",  "todotxt", "toml",       "tsx",
  --  "typescript", "vim",    "vue",    "wgsl",       "yaml",
  --}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  configs.parser_install_dir = require'user.utils'.XDG_DATA_HOME .. '/tree-sitter/parsers'
  configs.sync_install = true -- install languages synchronously (only applied to `ensure_installed`)
  configs.ignore_install = {} -- list of parsers to ignore installing
  configs.highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'sh', 'org', 'latex' }, -- list of language that will be disabled
    -- setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- using this option may slow down your editor, and you may see some duplicate highlights.
    -- instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { 'org' }, -- required since ts highlighter doesn't support all syntax features (conceal)
  }
  configs.indent = {
    enable = true,
  }
  configs.rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 10000, -- do not enable for files with more than n lines, int
    hlgroups = {
      'rainbowcol1',
      'rainbowcol2',
      'rainbowcol3',
      'rainbowcol4',
      'rainbowcol5',
      'rainbowcol6',
    },
  }
  -- Define hlgroups for nvim-ts-rainbow
  for index, color in ipairs(M.rainbow_colors) do -- p00f/rainbow#81
    vim.api.nvim_set_hl(0, ('rainbowcol%d'):format(index), {
      fg = color,
    })
  end


  configs.context_commentstring = {
    enable = true,
  }

  configs.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      node_decremental = '<bs>',
      scope_incremental = 'gss',
      -- scope_decremental = 'gss', -- there's no such thing for some reason
    },
  }

  -- vim.keymap.set('n', '<c-space>', "<cmd>lua require'nvim-treesitter.incremental_selection'.init_selection()<cr>", {
  --   desc = 'init incremental selection',
  -- })
  -- vim.keymap.set('x', '<c-space>', "<cmd>lua require'nvim-treesitter.incremental_selection'.node_incremental()<cr>", {
  --   desc = 'increment selection',
  -- })
  -- vim.keymap.set('x', '<bs>', "<cmd>lua require'nvim-treesitter.incremental_selection'.node_decremental()<cr>", {
  --   desc = 'decrement selection',
  -- })

  configs.playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'i',
      focus_language = 'f',
      unfocus_language = 'f',
      update = 'r',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
  configs.textobjects = {
    select = {
      enable = true,

      -- automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- you can use the capture groups defined in textobjects.scm
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap)
        ['af'] = {
          query = '@function.outer',
          desc = 'select around a function',
        },
        ['if'] = {
          query = '@function.inner',
          desc = 'select inner part of a function',
        },
        ['acc'] = {
          query = '@comment.outer',
          desc = 'select around a line comment',
        },
        ['icc'] = {
          query = '@comment.inner',
          desc = 'select inner part of a line comment',
        },
        ['aca'] = {
          query = '@comment.adjacent',
          desc = 'select around a sequence of line comments',
        },
        -- ['ica'] = {
        --   query = '@comment.adjacent',
        --   desc = 'select inner part of a sequence of line comments',
        -- },
        ['as'] = {
          query = '@class.outer',
          desc = 'select around a class',
        },
        ['is'] = {
          query = '@class.inner',
          desc = 'select inner part of a class',
        },
        ['al'] = {
          query = '@loop.outer',
          desc = 'select around a loop',
        },
        ['il'] = {
          query = '@loop.inner',
          desc = 'select inner part of a loop',
        },
        ['ia'] = {
          query = '@parameter.inner',
          desc = 'select inner part of a parameter',
        },
        ['aa'] = {
          query = '@parameter.outer',
          desc = 'select around a parameter',
        },
      },
      -- you can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'v', -- linewise
        ['@class.outer'] = 'v', -- blockwise
      },
      -- if you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>sa'] = {
          query = '@parameter.inner',
          desc = 'current function argument with next',
        },
        ['<leader>sf'] = {
          query = '@field',
          desc = 'current field with next',
        },
      },
      swap_previous = {
        ['<leader>sa'] = {
          query = '@parameter.inner',
          desc = 'current function argument with previous',
        },
        ['<leader>sf'] = {
          query = '@field',
          desc = 'current field with previous',
        },
      },
    },
  }

  -- Which-Key descriptions
  if pcall(require, 'which-key') then
    require('which-key').register {
      ['<leader>'] = {
        s = { name = 'Swap...' },
      },
    }
  end

  -- Actual treesitter setup executes here - above are just config tablese
  vim.opt.runtimepath:append(configs.parser_install_dir)
  require('nvim-treesitter.configs').setup(configs)
end

return M
