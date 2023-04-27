local util = require 'user.utils'

local M = {}

M.separator = ' > '

M.excluded_filetypes = {
  -- 'help',
  'DiffviewFiles',
  'cybu',
  'fugitive',
  'startify',
  'dashboard',
  'packer',
  'neogitstatus',
  'NvimTree',
  'Trouble',
  'alpha',
  'lir',
  'Outline',
  'spectre_panel',
  'toggleterm',
  'qf',
}

-- M.navic_get_location = function()
--   local ok, location = pcall(require('nvim-navic').get_location)
--   if not ok then return '' end
-- end

M.navic_filename = function()
  local filename = vim.fn.expand '%:t'
  local extension = vim.fn.expand '%:e'

  if util.is_empty(filename) then
    filename = '[No Name]'
  end
  local file_icon, file_icon_color =
    require('nvim-web-devicons').get_icon_color(
      filename,
      extension,
      { default = true }
    )

  local hl_group = 'FileIconColor' .. extension

  -- WARNING: this errors if file has invalid extension, like nvim-0.8.1-6
  -- (extension .1-6, which produces FileIconColor1-6, which is invalid 🤦)
  -- FIXME: still errors out in some cases because of above, even with pcall
  pcall(vim.api.nvim_set_hl, 0, hl_group, { fg = file_icon_color })
  if util.is_empty(file_icon) then
    file_icon = ''
    file_icon_color = ''
  end

  local navic_text = vim.api.nvim_get_hl_by_name('NavicText', true)
  vim.api.nvim_set_hl(0, 'Winbar', { fg = navic_text.foreground })

  local separator = ''
  if not util.is_empty(require'nvim-navic'.get_location()) then
    separator = M.separator
  end

  local modified_sign = ''
  if vim.bo.modified then
    modified_sign = ' ●'
  end

  return ' '
      .. '%#'
      .. hl_group
      .. '#'
      .. file_icon
      .. '%*'
      .. ' '
      .. '%#Winbar#'
      .. filename
      .. '%*'
      .. modified_sign
      .. separator
end

M.setup = function()
  -- Link hlgroups to treesitter ones
  -- stylua: ignore start
  vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, link = "@namespace" })
  vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, link = "@namespace" })
  vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, link = "@include" })
  vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, link = "@include" })
  vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, link = "@constructor" })
  vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, link = "@method" })
  vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, link = "@string" })
  vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, link = "@field" })
  vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, link = "@constructor" })
  vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, link = "@constant" })
  vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, link = "@constant" })
  vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, link = "@function" })
  vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, link = "@variable" }) -- or @keyword
  vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, link = "@constant" })
  vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, link = "@string" })
  vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, link = "@number" })
  vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, link = "@boolean" })
  vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, link = "@constant" })
  vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, link = "@constant" })
  vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, link = "@string.escape" })
  vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, link = "@constant" })
  vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, link = "@property" })
  vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, link = "@structure" }) -- or @constant
  vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, link = "@constant" })
  vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, link = "@operator" })
  vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, link = "@type" })
  vim.api.nvim_set_hl(0, "NavicText", { default = true, link = "@text" })
  vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, link = "@text" })
  -- stylua: ignore end

  require('nvim-navic').setup {
    icons = {
      File = ' ',
      Module = ' ',
      Namespace = ' ',
      Package = ' ',
      Class = ' ',
      Method = ' ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = '練',
      Interface = '練',
      Function = ' ',
      Variable = ' ',
      Constant = ' ',
      String = ' ',
      Number = ' ',
      Boolean = '◩ ',
      Array = ' ',
      Object = ' ',
      Key = ' ',
      Null = 'ﳠ ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },
    highlight = true,
    separator = M.separator,
    depth_limit = 0,
    depth_limit_indicator = '..',
  }

  -- Extend `on_attach` with navic
  require('user.plugin.lspconfig').extend_on_attach(
    require 'user.plugin.lspconfig',
    function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
      end
    end
  )

  -- Autocmd to set winbar in buffers locally in normal buffers (not qf, etc)
  -- (you cannot do the reverse)
  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufWinEnter' }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup(
      'nrv#winbar_ignore_list',
      { clear = true }
    ),
    callback = function()
      -- Guard on exclueed filetypes
      -- DANGER: any small window that is not excluded can trigger error loop
      -- (Navic: not enough room)
      if vim.tbl_contains(M.excluded_filetypes, vim.bo.filetype) then return end

      -- Set the winbar to navic
      vim.wo.winbar 
        = "%{%v:lua.require'user.plugin.navic'.navic_filename()%}%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  })
end

return M
