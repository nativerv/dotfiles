local M = {}

M.neogit = function()
  require('neogit').open { kind = 'replace' }
end

M.mappings = {
  open = {
    keys = { '<leader>gg' },
    opts = { desc = 'Open Neogit' },
    { { 'n' }, M.neogit },
  },
}

M.setup = function()
  require('neogit').setup {
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = true,
    -- Value used for `--sort` option for `git branch` command
    -- By default, branches will be sorted by commit date descending
    -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
    -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
    sort_branches = '-committerdate',
    disable_builtin_notifications = true,
    use_magit_keybindings = false,
    -- Change the default way of opening neogit
    kind = 'tab',
    -- The time after which an output console is shown for slow running commands
    console_timeout = 2000,
    -- Automatically show console if a command takes more than console_timeout milliseconds
    auto_show_console = true,
    -- Persist the values of switches/options within and across sessions
    remember_settings = true,
    -- Scope persisted settings on a per-project basis
    use_per_project_settings = true,
    -- Array-like table of settings to never persist. Uses format "Filetype--cli-value"
    --   ie: `{ "NeogitCommitPopup--author", "NeogitCommitPopup--no-verify" }`
    ignored_settings = {},
    -- Change the default way of opening the commit popup
    commit_popup = {
      kind = 'split',
    },
    -- Change the default way of opening the preview buffer
    preview_buffer = {
      kind = 'split',
    },
    -- Change the default way of opening popups
    popup = {
      kind = 'split',
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { '', '' },
      item = { '', '' },
      hunk = { '', '' },
    },
    integrations = {
      -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
      -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
      --
      -- Requires you to have `sindrets/diffview.nvim` installed.
      -- use {
      --   'TimUntersberger/neogit',
      --   requires = {
      --     'nvim-lua/plenary.nvim',
      --     'sindrets/diffview.nvim'
      --   }
      -- }
      --
      diffview = true,
    },
    -- Setting any section to `false` will make the section not render at all
    sections = {
      untracked = {
        folded = false,
      },
      unstaged = {
        folded = false,
      },
      staged = {
        folded = false,
      },
      stashes = {
        folded = true,
      },
      unpulled = {
        folded = true,
      },
      unmerged = {
        folded = false,
      },
      recent = {
        folded = true,
      },
    },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {
        -- Adds a mapping with "B" as key that does the "BranchPopup" command
        -- ['B'] = 'BranchPopup',
        -- Removes the default mapping of "b"
        ['b'] = '',
      },
    },
  }

  -- Command
  vim.api.nvim_create_user_command('Neogit', M.neogit, {
    nargs = '*',
    desc = 'Open Neogit',
    complete = function(arglead)
      local neogit = require 'neogit'
      return neogit.complete(arglead)
    end,
  })

  -- Reverse mapping in Neogit buffer
  -- As of writing this comment produces an error if pressed quickly after
  -- opening (pressing it twice in quick succession)
  -- See https://github.com/TimUntersberger/neogit/issues/489
  -- vim.api.nvim_create_autocmd({ 'FileType' }, {
  --   pattern = { 'NeogitStatus' },
  --   group = vim.api.nvim_create_augroup(
  --     'nrv#neogit_reverse_mapping',
  --     { clear = true }
  --   ),
  --   callback = function(event)
  --     vim.keymap.set(
  --       { 'n' },
  --       M.mappings.open.keys[1],
  --       -- require('neogit').close,
  --       function() vim.api.nvim_buf_delete(event.buf, {}) end,
  --       -- require 'neogit.lib.mappings_manager'.invoke(3, 26),
  --       { buffer = event.buf, desc = 'Close Neogit' }
  --     )
  --   end,
  -- })
end

return M
