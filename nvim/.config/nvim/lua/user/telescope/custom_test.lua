local pickers = require'telescope.pickers'
local finders = require'telescope.finders'
local sorters = require'telescope.sorters'
local actions = require'telescope.actions'
local action_state = require "telescope.actions.state"

local function my_custom_picker(opts)
  opts = opts or {}

  local picked = pickers.new(opts, {
    prompt_title = 'Custom Picker',
    finder = finders.new_table {
      results = {
        -- | "red",
        -- | "green",
        -- | "blue",
      },
    },
    sorter = sorters.fuzzy_with_index_bias(),
    attach_mappings = function(prompt_bufnr, map)
      -- Map "<cr>" in insert mode to the function, actions.set_command_line
      map('i', '<cr>', actions.set_command_line)

      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        print(vim.inspect(selection))
        --vim.api.nvim_put({ selection[1] }, "", false, true)
      end)

      -- If the return value of `attach_mappings` is true, then the other
      -- default mappings are still applies.
      --
      -- Return false if you don't want any other mappings applied.
      --
      -- A return value _must_ be returned. It is an error to not return anything.
      return true
    end,

  }):find()

  print(vim.inspect(picked))
end

my_custom_picker {
}
