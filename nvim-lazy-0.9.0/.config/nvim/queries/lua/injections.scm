;; extends

; example: 
;   local headings_query = vim.treesitter.query.parse_query(
;     'markdown',
;     [[
;       (atx_heading 
;       [
;         (atx_h1_marker)
;         (atx_h2_marker)
;         (atx_h3_marker)
;         (atx_h4_marker)
;         (atx_h5_marker)
;         (atx_h6_marker)
;       ] @heading_marker
;       (inline) @heading_content) @heading
;     ]]
;   )
((function_call
  name: (_) @_parse_query_call
  arguments: (arguments (string) (string content: _ @query)))
 (#any-of? @_parse_query_call "vim.treesitter.query.parse_query"))

; example:
;  local ok, query = pcall(
;    vim.treesitter.query.parse_query,
;    'markdown_inline',
;    [[
;      (inline_link (link_destination)) @inline_link
;    ]]
;  )
((function_call
   name: (_) @pcall_call
   arguments: (arguments (_) @parse_query_identifier (string) (string content: _ @query)))
 (#any-of? @pcall_call "pcall")
 (#any-of? @parse_query_identifier "vim.treesitter.query.parse_query"))

; example: 
;   vim.cmd (([[ highlight @text.todo ctermbg=NONE guibg=NONE guifg='%s' ]]):format(require'user.config'.colors.hint))
((function_call
  name: (_) @vim_cmd_call
  arguments: (arguments
    (function_call
      name: (method_index_expression
        table: (parenthesized_expression
                 (string 
                   content: _ @vim))))))
 (#any-of? @vim_cmd_call "vim.cmd"))
