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

syntax region eccsString start=/"/ skip=/\\"/ end=/"/ contains=NONE

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
syntax keyword eccsConstant P up down left right

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
highlight default link eccsKeyword   Keyword
highlight default link eccsStatement Statement
highlight default link eccsConstant  Constant
highlight default link eccsNumber    Number
highlight default link eccsSeparator Conceal

let b:current_syntax = "eccs"
