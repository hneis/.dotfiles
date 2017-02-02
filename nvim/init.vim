" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Autoinstall vim-plug {{{
if empty(glob('~/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/nvim/autoload/plug.vim  --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"================+
" install plugin | 
"================+

" Make sure you use single quotes
call plug#begin('~/nvim/plugged')

" nerdtree - file explorer
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " file drawer
call plug#end()

"=================+
" general mapping | 
"=================+

let mapleader = "\<Space>"

nmap <leader>n :NERDTreeToggle<CR>

if &compatible
    set nocompatible
endif

" prevent for using arrow keys
inoremap  <Up>     <esc>ggVGd:call NoArrowInput()<cr>
inoremap  <Down>   <esc>ggVGd:call NoArrowInput()<cr>
inoremap  <Left>   <esc>ggVGd:call NoArrowInput()<cr>
inoremap  <Right>  <esc>ggVGd:call NoArrowInput()<cr>
noremap   <Up>     <esc>ggVGd:call NoArrowInput()<cr>
noremap   <Down>   <esc>ggVGd:call NoArrowInput()<cr>
noremap   <Left>   <esc>ggVGd:call NoArrowInput()<cr>
noremap   <Right>  <esc>ggVGd:call NoArrowInput()<cr>

function! NoArrowInput()
        let l:input = ''
        echo "type no arrows to return to vim"
        while l:input !~ 'no arrows'
                let l:input = input("")
        endwhile
        u
endfunction

" set line number
set number

syntax on
set autoindent
" toggle paste mode for passing from clipboard
set pastetoggle=<F11>

" the copy goes to the clipboard
set clipboard+=unnamedplus

" edit vimrc with f5 and source it automatically
nmap <silent> <leader><f5> :e $MYVIMRC<CR>
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" set the directory where the swap file will be saved
set backupdir=~/nvim/backup//
set directory=~/nvim/swap//
set undodir=~/nvim/undo//
