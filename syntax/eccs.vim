" Prevent double-loading
if exists("b:current_syntax")
    finish
endif

" --------------------------------------------------
" Comments
" --------------------------------------------------
" Anything beginning with # until end-of-line

syntax match eccsComment /#.*/

" --------------------------------------------------
" Strings
" --------------------------------------------------
" Double-quoted strings with escaped quotes support

syntax match eccsEscape /\\./ contained
syntax region eccsString start=/"/ skip=/\\"/ end=/"/ contains=eccsEscape

" --------------------------------------------------
" Keywords
" --------------------------------------------------

syntax keyword eccsKeyword emote facing sound speak wait

" --------------------------------------------------
" Statements
" --------------------------------------------------

syntax keyword eccsStatement if elif else

" --------------------------------------------------
" Constants
" --------------------------------------------------

" P = Player
" O = Other (NPC Player is interacting with)
syntax keyword eccsConstant O P down left right up

" --------------------------------------------------
" Numeric Literals
" --------------------------------------------------

syntax match eccsNumber /\v<\d+(\.\d+)?>/

" --------------------------------------------------
" Separators
" --------------------------------------------------
" Semicolons outside comments/strings

syntax match eccsSeparator /;/

" --------------------------------------------------
" Highlight Links
" --------------------------------------------------

highlight default link eccsComment   Comment
highlight default link eccsString    String
highlight default link eccsEscape    Special
highlight default link eccsKeyword   Keyword
highlight default link eccsStatement Statement
highlight default link eccsConstant  Constant
highlight default link eccsNumber    Number
highlight default link eccsSeparator Conceal

let b:current_syntax = "eccs"
