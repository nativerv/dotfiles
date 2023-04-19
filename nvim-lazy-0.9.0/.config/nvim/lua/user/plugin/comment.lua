local M = {}

M.keys = {
  toggle_line = { 'gcc', },
  toggle_block = { 'gCC', },

  opleader_line = { 'gc', },
  opleader_block = { 'gC', },
}

M.setup = function ()
  require'Comment'.setup {
   -- | LHS of toggle mappings in NORMAL + VISUAL mode
   -- | type table
   toggler = {
       -- | line-comment keymap
       line = M.keys.toggle_line[1],
       -- | block-comment keymap
       block = M.keys.toggle_block[1], 
   },

   -- | LHS of operator-pending mappings in NORMAL + VISUAL mode
   -- | @type table
   opleader = {
       -- | line-comment keymap
       line = M.keys.opleader_line[1],
       -- | block-comment keymap
       block = M.keys.opleader_block[1],
   },
   -- | @param ctx Ctx
   -- pre_hook = function(ctx)
   --   -- | Only calculate commentstring for tsx filetypes
   --   if vim.bo.filetype == 'typescriptreact' then
   --     local U = require('Comment.utils')
   --
   --     -- | Detemine whether to use linewise or blockwise commentstring
   --     local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
   --
   --     -- | Determine the location where to calculate commentstring from
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
  -- | Customize comment strings
  require'Comment.ft'
  -- |            line comment  block comment
   .set('lua', { '-- %s',    '-- [[ %s ]]' })
end


return M
