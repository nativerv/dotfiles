local M = {}

M.setup = function()
  vim.g.vimwiki_list = {
    {
      path = '~/dox/notes',
      syntax = 'markdown',
      ext = '.md',
    },
  }
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_markdown_link_ext = 1

  vim.g.vimwiki_folding = 'list'

  vim.g.vimwiki_key_mappings = {
    all_maps = 1,
    global = 0,
    headers = 1,
    text_objs = 1,
    table_format = 0,
    table_mappings = 0,
    lists = 0,
    links = 0,
    html = 0,
    mouse = 0,
  }

  -- Mappings -- override disabled
  -- Checkbox toggling
  vim.keymap.set('n', '<c-space>', function () vim.cmd [[ VimwikiToggleListItem ]] end)

  -- Fix highlights
  vim.api.nvim_set_hl(0, 'VimwikiDelText', { strikethrough = true })
  vim.api.nvim_set_hl(0, 'VimwikiDelTextT', { strikethrough = true })
  vim.api.nvim_set_hl(0, 'VimwikiSuperScript', {})
  vim.api.nvim_set_hl(0, 'VimwikiSubScript', {})
end

return M
