local M = {}

M.keys = {
  find_under = { '<C-n>', },
  add_cursor_down = { 'gj', },
  add_cursor_up = { 'gk', },
}

M.init = function ()
  -- Set colors to look like visual mode
  vim.g.VM_Extend_hl = 'Visual'
  vim.g.VM_Cursor_hl = 'Visual'
  vim.g.VM_Insert_hl = 'DiffChange'
  vim.g.VM_Mono_hl   = 'Visual'

  -- Disable default mappings - reenable them below, customized.
  vim.g.VM_default_mappings = 0

  vim.g.VM_maps = {}

  -- Enable undo and redo - disabled by default
  vim.g.VM_maps["Undo"] = 'u'
  vim.g.VM_maps["Redo"] = '<C-r>'

  -- Mappings with \\ are meant prefixed by the VM_leader. These permanent mappings are enabled by default:
  vim.g.VM_maps['Find Under']                  = M.keys.find_under
  vim.g.VM_maps['Find Subword Under']          = M.keys.find_under
  vim.g.VM_maps["Select All"]                  = '\\A' 
  vim.g.VM_maps["Start Regex Search"]          = '\\/'
  vim.g.VM_maps["Add Cursor Down"]             = M.keys.add_cursor_down
  vim.g.VM_maps["Add Cursor Up"]               = M.keys.add_cursor_up
  vim.g.VM_maps["Add Cursor At Pos"]           = '\\\\'

  vim.g.VM_maps["Visual Regex"]                = '\\/'
  vim.g.VM_maps["Visual All"]                  = '\\A' 
  vim.g.VM_maps["Visual Add"]                  = '\\a'
  vim.g.VM_maps["Visual Find"]                 = '\\f'
  vim.g.VM_maps["Visual Cursors"]              = '\\c'

  -- These buffer mappings are enabled by default:
  vim.g.VM_maps["Switch Mode"]                 = '<Tab>'

  vim.g.VM_maps["Find Next"]                   = ']'
  vim.g.VM_maps["Find Prev"]                   = '['
  vim.g.VM_maps["Goto Next"]                   = '}'
  vim.g.VM_maps["Goto Prev"]                   = '{'
  vim.g.VM_maps["Seek Next"]                   = '<C-f>'
  vim.g.VM_maps["Seek Prev"]                   = '<C-b>'
  vim.g.VM_maps["Skip Region"]                 = 'q'
  vim.g.VM_maps["Remove Region"]               = 'Q'
  vim.g.VM_maps["Invert Direction"]            = 'o'
  vim.g.VM_maps["Find Operator"]               = "m"
  vim.g.VM_maps["Surround"]                    = 'S'
  vim.g.VM_maps["Replace Pattern"]             = 'R'

  vim.g.VM_maps["Tools Menu"]                  = '\\`'
  vim.g.VM_maps["Show Registers"]              = '\\"'
  vim.g.VM_maps["Case Setting"]                = '\\c'
  vim.g.VM_maps["Toggle Whole Word"]           = '\\w'
  vim.g.VM_maps["Transpose"]                   = '\\t'
  vim.g.VM_maps["Align"]                       = '\\a'
  vim.g.VM_maps["Duplicate"]                   = '\\d'
  vim.g.VM_maps["Rewrite Last Search"]         = '\\r'
  vim.g.VM_maps["Merge Regions"]               = '\\m'
  vim.g.VM_maps["Split Regions"]               = '\\s'
  vim.g.VM_maps["Remove Last Region"]          = '\\q'
  vim.g.VM_maps["Visual Subtract"]             = '\\s'
  vim.g.VM_maps["Case Conversion Menu"]        = '\\C'
  vim.g.VM_maps["Search Menu"]                 = '\\S'

  vim.g.VM_maps["Run Normal"]                  = '\\z'
  vim.g.VM_maps["Run Last Normal"]             = '\\Z'
  vim.g.VM_maps["Run Visual"]                  = '\\v'
  vim.g.VM_maps["Run Last Visual"]             = '\\V'
  vim.g.VM_maps["Run Ex"]                      = '\\x'
  vim.g.VM_maps["Run Last Ex"]                 = '\\X'
  vim.g.VM_maps["Run Macro"]                   = '\\@'
  vim.g.VM_maps["Align Char"]                  = '\\<'
  vim.g.VM_maps["Align Regex"]                 = '\\>'
  vim.g.VM_maps["Numbers"]                     = '\\n'
  vim.g.VM_maps["Numbers Append"]              = '\\N'
  vim.g.VM_maps["Zero Numbers"]                = '\\0n'
  vim.g.VM_maps["Zero Numbers Append"]         = '\\0N'
  vim.g.VM_maps["Shrink"]                      = "\\-"
  vim.g.VM_maps["Enlarge"]                     = "\\+"

  vim.g.VM_maps["Toggle Block"]                = '\\<BS>'
  vim.g.VM_maps["Toggle Single Region"]        = '\\<CR>'
  vim.g.VM_maps["Toggle Multiline"]            = '\\M'
end

return M
