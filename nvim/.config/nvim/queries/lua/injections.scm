;; extends

((function_call
  name: (_) @_parse_query_call
  arguments: (arguments (string) (string content: _ @query)))
  (#any-of? @_parse_query_call "vim.treesitter.query.parse_query"))

((function_call
   name: (_) @pcall_call
   arguments: (arguments (_) @parse_query_identifier (string) (string content: _ @query)))
  (#any-of? @pcall_call "pcall")
  (#any-of? @parse_query_identifier "vim.treesitter.query.parse_query"))
