local M = {}

M.setup = function ()
  local configs = {};
  local captures = {};
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
  configs.sync_install = true -- install languages synchronously (only applied to `ensure_installed`)
  configs.ignore_install = { } -- List of parsers to ignore installing
  configs.highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { 'sh', 'org', 'latex', },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
  }
  configs.indent = {
    enable = true,
  }
  configs.rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 10000, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
  configs.context_commentstring = {
    enable = true,
  }
  configs.playground = {
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
  configs.textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = false,
    },
  }

  -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
  captures["@strikethrough"] = '@text.strike'

  require'nvim-treesitter.configs'.setup (configs)
  require"nvim-treesitter.highlight".set_custom_captures (captures)
end

return M