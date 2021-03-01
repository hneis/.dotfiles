" source every hneis plugin configs
for file in split(glob('~/.config/nvim/pluggedconf/hneisconf/*.nvimrc'), '\n')
    execute 'source' file
endfor

"UPPERCASE and lowercase conversion
nnoremap g^ gUiW
" nnoremap gv guiW

" go to first and last char of line
" nnoremap H ^
" nnoremap L g_
" vnoremap H ^
" vnoremap L g_

" Find merge conflict markers
map <leader>FC /\v^[<\|=>]{7}( .*\|$)<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Easier formatting TODO set map
" nnoremap <silent> <leader>Q gwip

" Faster save/quite/close
" nmap <silent> <leader>ww :update<CR>
nmap <silent> <leader>wq :quit<CR>

nnoremap <leader>pp :%!python -m json.tool<cr>

" Deal vim fast
let g:php_html_load = 0
let g:php_html_in_nowdoc = 0
let g:php_html_in_heredoc = 0
let g:php_sql_query = 0
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0
let synmaxcolor = 100

" a Automatically format paragraphs
" set formatoptions=cqrn1


"set termguicolors
set background=dark
colorscheme gruvbox

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

" autocmd FileType javascript.jsx,vue setlocal autoindent expandtab tabstop=2 softtabstop=2 shiftwidth=2

set tags^=.git/tags;~

" map <leader>' ysiw'<cr>
" map <leader>" ysiw"<cr>
autocmd vimrc FileType python,ruby,rspec,javascript,go,html,php,eruby,coffee,haml nmap <buffer> <leader>D :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>
autocmd vimrc BufWrite *.jsx,*.vue,*.twig,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc :call general#DeleteTrailingWS()

let $GIT_ASKPASS = 'no'

let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }
