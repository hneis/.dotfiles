
"UPPERCASE and lowercase conversion
nnoremap g^ gUiW
nnoremap gv guiW

"go to first and last char of line
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_

"" Find merge conflict markers
"" TODO find new map
map <leader>FC /\v^[<\|=>]{7}( .*\|$)<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
" Seems to have a problem where Vim sees that the file has changed and tries to
" reload it. When it does it thinks the file is blank (but it's not really).
cmap w!! %!sudo tee > /dev/null %

" Adjust viewports to the same size
map <leader>= <C-w>=

"" Easier horizontal scrolling
map zl zL
map zh zH

"" Easier formatting TODO set map
nnoremap <silent> <leader>Q gwip
"
""TODO change mapping
"" Faster save/quite/close
nmap <silent> <leader>w :update<CR>
nmap <silent> <leader>q :quit<CR>

"" Cd to the current file's directory
"nnoremap <leader>. :cd %:p:h<CR>:pwd<CR>

nnoremap <leader>pp :%!python -m json.tool<cr>

" Deal vim fast
let g:php_html_load = 0
let g:php_html_in_nowdoc = 0
let g:php_html_in_heredoc = 0
let g:php_sql_query = 0
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0
let synmaxcolor = 100

"" a Automatically format paragraphs
set formatoptions=cqrn1


"set termguicolors
set background=dark
colorscheme gruvbox

"set incsearch               " Show search results as we type
"set showmatch               " Show matching brackets
"set hlsearch                " Highlight search results

"" To encourage the use of <C-[np]> instead of the arrow keys in ex mode, remap
"" them to use <Up/Down> instead so that they will filter completions
""cnoremap <C-p> <Up>
""cnoremap <C-n> <Down>
"

"command! Py :!python %
"command! O :!open %
"
"let g:ag_working_path_mode="r"
""End move
"

function! GruvboxSetTransparent()
  hi Normal guibg=NONE ctermbg=NONE
endfunction

function! GruvboxUnsetTransparent()
    colorscheme gruvbox
endfunction


" sass
"------------------------------------
""{{{
  " let g:sass_compile_auto = 1
  " let g:sass_compile_cdloop = 5
  " let g:sass_compile_cssdir = ['css', 'stylesheet']
  " let g:sass_compile_file = ['scss', 'sass']
  " let g:sass_compile_beforecmd = ''
  " let g:sass_compile_aftercmd = ''
  " autocmd FileType less,sass  setlocal sw=2 sts=2 ts=2 et
  " au! BufWritePost * SassCompile
"}}}

" inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
" autocmd FileType python setlocal completeopt-=preview
" autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
" " let g:coc_force_debug = 1
" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" let g:LanguageClient_serverCommands = {
"     \ 'vue': ['vls']
"     \ }

" autocmd FileType javascript.jsx,vue setlocal autoindent expandtab tabstop=2 softtabstop=2 shiftwidth=2

set tags^=.git/tags;~


