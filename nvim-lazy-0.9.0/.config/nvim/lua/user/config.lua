local M = {}

M.colors = {}

-- Error = "#db4b4b",
-- Warning = "#e0af68",
-- Information = "#0db9d7",
M.colors.error = '#e86671'
M.colors.warning = '#e5c07b'
M.colors.information = '#61afef'
M.colors.hint = '#56b6c2'
M.colors.rainbow_colors = {
  { 'TSRainbowRed', '#e06c75' },
  { 'TSRainbowYellow', '#e5c07b' },
  { 'TSRainbowBlue', '#98c379' },
  { 'TSRainbowOrange', '#56b6c2' },
  { 'TSRainbowGreen', '#61afef' },
  { 'TSRainbowViolet', '#c678dd' },
  { 'TSRainbowCyan', '#a658ff' },
}

M.colors.git = {}
M.colors.git.added = '#14a573'
M.colors.git.modified = '#deaf6c'
M.colors.git.removed = '#af404a'

return M
