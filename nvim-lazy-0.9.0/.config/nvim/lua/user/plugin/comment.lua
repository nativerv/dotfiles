local M = {}

M.mappings = {
  toggle_line = {
    keys = { 'gcc', },
    opts = { desc = 'Comment line' },
    { { 'n' } },
  },
  toggle_block = {
    keys = { 'gCC', },
    opts = { desc = 'Comment line as block comment' },
    { { 'n' } },
  },
  opleader_line = {
    keys = { 'gc', },
    opts = { desc = 'Comment linewise...' },
    { { 'o', 'v', 'n' } },
  },
  opleader_block = {
    keys = { 'gC', },
    opts = { desc = 'Comment blockwise...' },
    { { 'o', 'v', 'n' } },
  },
}

M.setup = function ()
  require'Comment'.setup {
   -- LHS of toggle mappings in NORMAL + VISUAL mode
   -- type table
   toggler = {
       -- line-comment keymap
       line = M.mappings.toggle_line.keys[1],
       -- block-comment keymap
       block = M.mappings.toggle_block.keys[1], 
   },

   -- LHS of operator-pending mappings in NORMAL + VISUAL mode
   -- @type table
   opleader = {
       -- line-comment keymap
       line = M.mappings.opleader_line.keys[1],
       -- block-comment keymap
       block = M.mappings.opleader_block.keys[1],
   },
   -- @param ctx Ctx
   -- pre_hook = function(ctx)
   --   -- Only calculate commentstring for tsx filetypes
   --   if vim.bo.filetype == 'typescriptreact' then
   --     local U = require('Comment.utils')
   --
   --     -- Detemine whether to use linewise or blockwise commentstring
   --     local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
   --
   --     -- Determine the location where to calculate commentstring from
   --     local location = nil
   --     if ctx.ctype == U.ctype.block then
   --       location = require('ts_context_commentstring.utils').get_cursor_location()
   --     elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
   --       location = require('ts_context_commentstring.utils').get_visual_start_location()
   --     end
   --
   --     return require('ts_context_commentstring.internal').calculate_commentstring({
   --       key = type,
   --       location = location,
   --     })
   --   end
   -- end,
  }
  -- Customize comment strings
  require'Comment.ft'
   .set('lua', { '-- %s',      '--[[ %s ]]' })

  -- Which-Key descriptions
  if pcall(require, 'which-key') then
    require('which-key').register {
      g = {
        c = 'Comment linewise...',
        C = 'Comment blockwise...',
      }
    }
  end
end


return M
