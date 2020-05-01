" colorscheme
Plug 'morhetz/gruvbox'

" status bar
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" fzf - poweful fuzzy finder
Plug 'pbogut/fzf-mru.vim'

"" Begin move My plugins
"Plug 'jiangmiao/auto-pairs'
"Plug 'vim-scripts/sessionman.vim'
"Plug 'vim-scripts/restore_view.vim'

""   General Programming

" Other plugins require curl
" Webapi: Dependency of Gist-vim
"Plug 'mattn/webapi-vim'

Plug 'godlygeek/tabular'

"   Javascript
"Plug 'elzr/vim-json'
"Plug 'groenewege/vim-less'
"Plug 'briancollins/vim-jst'
"Plug 'kchmck/vim-coffee-script'

" Completion
"Plug 'mattn/emmet-vim', { 'for': 'html' }

"   Html
"Plug 'vim-scripts/HTML-AutoCloseTag'
"Plug 'hail2u/vim-css3-syntax'
"Plug 'gorodinskiy/vim-coloresque'
"Plug 'tpope/vim-haml'

" C++
" Plug 'rhysd/vim-clang-format'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'Shougo/neoinclude.vim'
" Plug 'terryma/vim-multiple-cursors'
"" PHP
"
"" Plug 'autozimu/LanguageClient-neovim', {
""     \ 'branch': 'next',
""     \ 'do': 'bash install.sh',
""     \ }
"
"" Plug 'roxma/LanguageServer-php-neovim',  {
""             \ 'do': 'composer install && composer run-script parse-stubs',
""             \ 'for': 'php'}
"
" Syntax
"Plug 'tpope/vim-git', { 'for': 'git' }

"" Make tab handle all completions
""Plug 'ervandew/supertab'

" Pairs of handy bracket mappings
"Plug 'tpope/vim-unimpaired'
"
" Search files using Silver Searcher
"Plug 'rking/ag.vim'


" Argument object
"Plug 'vim-scripts/argtextobj.vim'

" Show git status in the gutter
"Plug 'airblade/vim-gitgutter'


" Wrap and upwrap argument lists
"Plug 'FooSoft/vim-argwrap'

" Take notes and keep todo lists in vim
"Plug 'vimwiki/vimwiki'

"" taskwarrior plugin to vim
"Plug 'blindFS/vim-taskwarrior'

"Plug 'davidhalter/jedi-vim'

Plug 'Chiel92/vim-autoformat'
Plug 'tell-k/vim-autopep8'

Plug 'ryanoasis/vim-devicons'

" post install (yarn install | npm install)
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" let g:fromatterpath= ['/home/hneis/.node_modules/bin/']



" ncm debugging
" let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
" let $NVIM_NCM_LOG_LEVEL="DEBUG"
" let $NVIM_NCM_MULTI_THREAD=0
" No clue what it is :D
" autocmd VimResized * wincmd =

" hu?

"Bootstrap
Plug 'jvanja/vim-bootstrap4-snippets'

" generate uuid
Plug 'kburdett/vim-nuuid'

" twig
Plug 'lumiliet/vim-twig', {'for': 'twig'}

map <leader>' ysiw'<cr>
map <leader>" ysiw"<cr>
autocmd vimrc FileType python,ruby,rspec,javascript,go,html,php,eruby,coffee,haml nmap <buffer> <leader>D :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>
autocmd vimrc BufWrite *.jsx,*.vue,*.twig,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc :call general#DeleteTrailingWS()


augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if &filetype !=# "tagbar" | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter   * setlocal norelativenumber
augroup END
