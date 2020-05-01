" vim-airline {

" enable/disable enhanced tabline. (c)
let g:airline#extensions#tabline#enabled = 1

" enable/disable displaying open splits per tab (only when tabs are opened).
let g:airline#extensions#tabline#show_splits = 1

" switch position of buffers and tabs on splited tabline (c)
" (only supported for ctrlspace plugin).
let g:airline#extensions#tabline#switch_buffers_and_tabs = 0

" enable/disable displaying buffers with a single tab. (c) 
let g:airline#extensions#tabline#show_buffers = 1

let g:airline#extensions#tabline#formatter = 'unique_tail'

" if you want to show the current active buffer like this:
"----------------------
"buffer <buffer> buffer `
let g:airline#extensions#tabline#alt_sep = 1

let g:airline#extensions#keymap#enabled = 0

"let g:airline_symbols#space = "\ua0"
"let g:airline_theme='dark'

" Set configuration options for the statusline plugin vim-airline.
" Use the powerline theme and optionally enable powerline symbols.
" To use the symbols , , , , , , and .in the statusline
" segments add the following to your .vimrc.before.local file:
let g:airline_powerline_fonts=1
" powerline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"airline symbol
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

"airline#tabline symobls
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
" }


let g:airline_highlighting_cache=1
let g:airline#extensions#tagbar#enabled = 0
