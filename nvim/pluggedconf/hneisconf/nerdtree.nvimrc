" nerdtree configuration

function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction

" nmap <leader>n :call NERDTreeToggleInCurDir()<CR>
nmap <leader>N :call NERDTreeToggleInCurDir()<CR>
nmap <leader>e :call NERDTreeToggleInCurDir()<CR>

" don't display informations (type ? for help and so on)
let g:NERDTreeMinimalUI = 1
" don't replace the native vim file explorer let g:NERDTreeHijackNetrw = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeCascadeOpenSingleChildDir = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeQuitOnOpen = 1

" change the arrows
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '

" remapping - see nerdtree.txt and search for "NERDTreeMappings"
let NERDTreeMapOpenSplit = 'b'
let NERDTreeMapPreviewSplit='gb'

let NERDTreeMapOpenVSplit = 'v'
let NERDTreeMapPreviewVSplit='gv'
let g:NERDTreeMouseMode=3

let g:NERDTreeLimitedSyntax = 1
let NERDTreeHighlightCursorline = 0
let g:NERDTreeDisableFileExtensionHighlight = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'cpp', 'php', 'rb', 'js', 'css', 'html'] " enabled extensions with default colors
let g:NERDTreeSyntaxEnabledExactMatches = ['node_modules', 'favicon.ico'] " enabled exact matches with default colors
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
autocmd BufWinEnter NERD_tree_*  setlocal signcolumn=no
autocmd FileType * if &filetype ==# "tagbar" | setlocal signcolumn=no | endif
