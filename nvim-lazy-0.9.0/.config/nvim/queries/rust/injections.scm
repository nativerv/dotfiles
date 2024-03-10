; extends

(
  (line_comment) @injection.language
  (_) @injection.content
  (line_comment) @_last 

  (#gsub! @injection.language "^/// ```(%w+)%s*$" "%1") ; match opening - extract language tag
  (#gsub! @injection.language "^/// ```$" "rust") ; match opening - no language tag, default to rust
  (#match? @_last "^/// ```$") ; match closing
  (#offset! @injection.content 0 4 0 4) ; skip '/// ' on both start and end line i think

  ; tell nvim to use extracted (substituted) tag as if it was name of the
  ; capture which will then tell it what to inject 
  ; more on how that works: `:h treesitter-language-injections`
  (#set! injection.combined) 
)
