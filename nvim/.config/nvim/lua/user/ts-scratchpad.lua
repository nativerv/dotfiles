local ts_utils = require 'nvim-treesitter.ts_utils'
local parsers = require 'nvim-treesitter.parsers'

-- local context = ''
-- local current_node = nil
--
-- local function get_ts_context()
--   local winnr = vim.api.nvim_get_current_win()
--   local node = ts_utils.get_node_at_cursor(winnr)
--
--   print(vim.inspect {
--     type = node:type(),
--     text = ts_utils.get_node_text(node),
--     parent = ts_utils.get_node_text(node:parent()),
--   })
--   -- get_ts_context()
-- end

local function toggle_checkbox_under_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = parsers.get_parser(bufnr)
  local root = parser:parse()[1]:root()
  local query = vim.treesitter.query.parse_query(
    'markdown',
    [[
        (
          [ 
            (task_list_marker_unchecked)
            (task_list_marker_checked)
          ] @list_item_checkbox_unchecked

          (paragraph (inline))
        )
      ]]
  )

  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  for _, node, _ in query:iter_captures(root, bufnr, row, row + 1) do
    local new_marker = '[unreachable]'

    if node:type() == 'task_list_marker_unchecked' then
      new_marker = '[x]'
    elseif node:type() == 'task_list_marker_checked' then
      new_marker = '[ ]'
    end

    -- Credit <nvim-treesitter/lua/nvim-treesitter/ts_utils.lua>: M.swap_nodes
    local range = ts_utils.node_to_lsp_range(node)

    local edit = { range = range, newText = new_marker }
    vim.lsp.util.apply_text_edits({ edit }, bufnr, 'utf-8')
  end
end

-- Modify the level (count of `#`'s) by `amount` of
-- the heading under cursor.
-- If the line under cursor isn't a heading and `amount` is positive,
-- make it a heading with level `amount`.
-- If the line under cursor is a heading and `amount` is negative,
-- make it plain paragraph.
---@param amount number
local function modify_heading_level_under_cursor(amount)
  return function()
    local bufnr = vim.api.nvim_get_current_buf()
    local parser = parsers.get_parser(bufnr)
    local root = parser:parse()[1]:root()
    local headings_query = vim.treesitter.query.parse_query(
      'markdown',
      [[
        (atx_heading 
        [
          (atx_h1_marker)
          (atx_h2_marker)
          (atx_h3_marker)
          (atx_h4_marker)
          (atx_h5_marker)
          (atx_h6_marker)
        ] @heading_marker
        (inline) @heading_content) @heading
      ]]
    )

    -- Query for top-level paragraphs (not inside lists, only where making it
    -- a heading is possible)
    local paragraphs_query = vim.treesitter.query.parse_query(
      'markdown',
      [[
        (section (paragraph) @paragraph)
      ]]
    )

    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1

    -- Gather all of the captures to construct the new heading
    -- out of them all simultaneously later, instead of having them
    -- in random order in a loop
    local captures = {}
    for id, node, metadata in
      headings_query:iter_captures(root, bufnr, row, row + 1)
    do
      if headings_query.captures[id] == 'heading_content' then
        captures.heading_content = {
          id = id,
          node = node,
          metadata = metadata,
        }
      elseif headings_query.captures[id] == 'heading_marker' then
        captures.heading_marker = {
          id = id,
          node = node,
          metadata = metadata,
        }
      elseif headings_query.captures[id] == 'heading' then
        captures.heading = {
          id = id,
          node = node,
          metadata = metadata,
        }
      end
    end

    -- If we got the heading capture, then modify it:
    if captures.heading then
      local old_marker =
        table.concat(ts_utils.get_node_text(captures.heading_marker.node))
      local old_heading_level = #old_marker
      local new_heading_level =
        math.min(math.max(old_heading_level + amount, 0), 6)

      local new_marker = ('#'):rep(new_heading_level)

      -- Remove the one leading space required in by the parser
      -- at the beginning of the (inline)
      local new_inline = table
        .concat(ts_utils.get_node_text(captures.heading_content.node), '')
        :gsub('^ ', '')
      local spacing = (' '):rep(
        math.min(math.max(old_heading_level + amount, 0), 1)
      )

      -- Construct either:
      -- * a whole new (atx_heading) with updated level
      -- * a (paragraph) in case there's no more levels to subtract,
      --   removing the extra spacing described above.
      local new_heading_text = ('%s%s%s\n'):format(
        new_marker,
        spacing,
        new_inline
      )

      local range = ts_utils.node_to_lsp_range(captures.heading.node)
      local edit = { range = range, newText = new_heading_text }
      vim.lsp.util.apply_text_edits({ edit }, bufnr, 'utf-8')
    end

    -- If we got a suiting (paragraph) instead, promote it to a heading
    for _, node, _ in paragraphs_query:iter_captures(root, bufnr, row, row) do
      local row1, _, row2, _ = node:range()
      -- Somehow the `iter_captures` doesn't seem to care about
      -- `start` and `end` of a row, row to restrict it to the
      -- row under cursor only, and would yield every (paragraph) in a (section).
      -- So there goes a guard to only promote the paragraph under the cursor
      if row >= row1 and row <= row2 then
        local old_heading_level = 0
        local new_heading_level =
          math.min(math.max(old_heading_level + amount, 0), 6)
        local new_marker = ('#'):rep(new_heading_level)
        local spacing = (' '):rep(
          math.min(math.max(old_heading_level + amount, 0), 1)
        )

        -- Credit <nvim-treesitter/lua/nvim-treesitter/ts_utils.lua>: M.swap_nodes
        local range = ts_utils.node_to_lsp_range(node)
        local text = table.concat(ts_utils.get_node_text(node), ' ')
        local new_text = ('%s%s%s\n'):format(new_marker, spacing, text)

        local edit = { range = range, newText = new_text }
        vim.lsp.util.apply_text_edits({ edit }, bufnr, 'utf-8')
      end
    end
  end
end

-- Creates extmarks consisting of spaces at the end
-- of the code block lines, to result in a pretty
-- rectangular code block
local function create_code_block_extmarks()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = parsers.get_parser(bufnr)
  local root = parser:parse()[1]:root()
  local query = vim.treesitter.query.parse_query(
    'markdown',
    [[
      (fenced_code_block) @code_block
    ]]
  )

  for _, node, _ in query:iter_captures(root, bufnr) do
    local lines = ts_utils.get_node_text(node)
    local row_start, _, _, _ = node:range()

    -- For some reason `ts_utils.get_node_text` gives you
    -- an extra `''` (an empty string) line at the end of every match,
    -- seemingly only for `markdown` parser.
    -- Looks like plain `vim.api.nvim_buf_get_lines` from `node:range`
    -- does that as well.
    -- So here goes a hack to avoid having that trailing empty line for
    -- the time being:
    if lines[#lines] == '' then
      table.remove(lines, #lines)
      -- row_start = row_start - 1
    end

    vim.pretty_print(lines)
    vim.pretty_print '###'

    local longest_len = 0
    for _, line in ipairs(lines) do
      longest_len = math.max(longest_len, vim.api.nvim_strwidth(line))
    end

    local padding_left = 0
    local padding_right = 5

    vim.pretty_print '---'
    for i, line in ipairs(lines) do
      local linenr = row_start + (i - 1)
      local line_width = vim.api.nvim_strwidth(line)

      -- -- If our line is valid and it's not too short then apply the dimmed highlight
      -- if line and line:len() >= column_start then
      local extmark_len = math.max(
        (longest_len - line:len()) + padding_left + padding_right,
        -- + (i == 1 or i == #lines) and line:len() or 0
        -- - math.max(padding_left - column_start, 0)
        0
      )

      if i == 1 or i == #lines then
        extmark_len = extmark_len + line:len()
      end

      vim.schedule(function()
        local extmark_text = (' '):rep(extmark_len + 200)
        vim.pretty_print(
          ('Set extmark of len %d at line %d'):format(extmark_len, linenr)
        )
        vim.api.nvim_buf_set_extmark(
          bufnr,
          vim.api.nvim_create_namespace 'markdown-wiki.nvim#code_block_background',
          linenr,
          line_width,
          {
            end_row = linenr - 1,
            hl_mode = 'blend',
            hl_eol = true,
            virt_text_pos = 'overlay',
            virt_text = { { extmark_text, '@text.literal' } },
          }
        )
      end)
      -- end
    end
    vim.pretty_print '---'
  end
end

local function netrw_open_markdown_link()
  vim.pretty_print 'gx'
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = parsers.get_parser(bufnr)
  local root = parser:parse()[1]:root()
  local ok, query = pcall(
    vim.treesitter.query.parse_query,
    'markdown_inline',
    [[
      (inline_link (link_destination)) @inline_link
    ]]
  )
  local query = vim.treesitter.query.parse_query(
    'markdown_inline',
    [[
      (inline_link (link_destination)) @inline_link
    ]]
  )
  if not ok then
    vim.notify('markdown-wiki.nvim: error while parsing query')
  end
  vim.pretty_print 'gx2'

  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  for _, node, _ in query:iter_captures(root, bufnr) do
    vim.pretty_print(vim.treesitter.get_node_text(node))
  end
  vim.pretty_print '==='
end

vim.keymap.set('n', '<c-space>', toggle_checkbox_under_cursor)
vim.keymap.set('n', '=', modify_heading_level_under_cursor(1))
vim.keymap.set('n', '-', modify_heading_level_under_cursor(-1))
-- vim.keymap.set('n', '<leader>t', create_code_block_extmarks)
vim.api.nvim_create_user_command(
  'HighlightCodeBlocks',
  create_code_block_extmarks,
  {}
)
vim.keymap.set('n', '<leader>t', netrw_open_markdown_link)
vim.cmd [[
  echo 'eblan'
]]
