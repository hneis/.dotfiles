" let g:lightline = {
"       \ 'colorscheme': 'hypnos256',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename','gitbranch', 'modified', 'neospinner'] ],
"       \   'right': [ [ 'lineinfo' ], [ 'percent', 'wordcount', 'charcount' ], [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ],
"       \ },
"       \ 'component': {
"       \   'charvaluehex': '0x%B'
"       \ },
"       \ 'component_function': {
"       \   'wordcount': 'general#WordCount',
"       \   'charcount': 'general#CharCount',
"       \   'gitbranch': 'fugitive#head',
"       \   'neospinner': 'SpinnerText',
"       \ },
"       \ }

function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype. ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
        return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
	let g:lightline = {
	      \ 'colorscheme': 'gruvbox',
	      \ 'active': {
	      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
	      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	      \ },
	      \ 'component_function': {
	      \   'fugitive': 'LightlineFugitive',
	      \   'filename': 'LightlineFilename',
	      \   'fileformat': 'LightlineFileformat',
	      \   'filetype': 'LightlineFiletype',
	      \   'fileencoding': 'LightlineFileencoding',
	      \   'mode': 'LightlineMode',
	      \   'ctrlpmark': 'CtrlPMark',
	      \   'lineinfo': 'MyLineinfo',
	      \ },
	      \ 'component_expand': {
	      \   'syntastic': 'SyntasticStatuslineFlag',
	      \ },
	      \ 'component_type': {
	      \   'syntastic': 'error',
	      \ },
	      \ 'subseparator': { 'left': '', 'right': '' },
          \ 'separator':    { 'left': '', 'right':	'' },
		  \ 'component': {
		  \   'lineinfo': ' %3l/'.line('$').'%n:%-2v',
		  \ }
	      \ }

    function! MyLineinfo() abort
        return printf(' %3d/%3d:%-2d', line('.'),  line('$'), col('.'))
    endfunction

	function! LightlineModified()
	  return &ft ==# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	endfunction

	function! LightlineReadonly()
	  return &ft !~? 'help' && &readonly ? '' : ''
	endfunction

	function! LightlineFilename()
	  let fname = expand('%:t')
	  return fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
	        \ fname =~# '^__Tagbar__\|__Gundo\|NERD_tree' ? '' :
	        \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
	        \ &ft ==# 'unite' ? unite#get_status_string() :
	        \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
	        \ (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
	        \ (fname !=# '' ? fname : '[No Name]') .
	        \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
	endfunction

	function! LightlineFugitive()
	  try
	    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
	      let mark = ''  " edit here for cool mark
	      let branch = FugitiveHead()

	      return branch !=# '' ?  ' '.mark.branch : ''
	    endif
	  catch
	  endtry
	  return ''
	endfunction

	function! LightlineFileformat()
	  return winwidth(0) > 70 ? &fileformat : ''
	endfunction

	function! LightlineFiletype()
	  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
	endfunction

	function! LightlineFileencoding()
	  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
	endfunction

	function! LightlineMode()
	  let fname = expand('%:t')
	  return fname =~# '^__Tagbar__' ? 'Tagbar' :
	        \ fname ==# 'ControlP' ? 'CtrlP' :
	        \ fname ==# '__Gundo__' ? 'Gundo' :
	        \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
	        \ fname =~# 'NERD_tree' ? 'NERDTree' :
	        \ &ft ==# 'unite' ? 'Unite' :
	        \ &ft ==# 'vimfiler' ? 'VimFiler' :
	        \ &ft ==# 'vimshell' ? 'VimShell' :
	        \ winwidth(0) > 60 ? lightline#mode() : ''
	endfunction

	function! CtrlPMark()
	  if expand('%:t') ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
	    call lightline#link('iR'[g:lightline.ctrlp_regex])
	    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
	          \ , g:lightline.ctrlp_next], 0)
	  else
	    return ''
	  endif
	endfunction

	let g:ctrlp_status_func = {
	  \ 'main': 'CtrlPStatusFunc_1',
	  \ 'prog': 'CtrlPStatusFunc_2',
	  \ }

	function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
	  let g:lightline.ctrlp_regex = a:regex
	  let g:lightline.ctrlp_prev = a:prev
	  let g:lightline.ctrlp_item = a:item
	  let g:lightline.ctrlp_next = a:next
	  return lightline#statusline(0)
	endfunction

	function! CtrlPStatusFunc_2(str)
	  return lightline#statusline(0)
	endfunction

	let g:tagbar_status_func = 'TagbarStatusFunc'

	function! TagbarStatusFunc(current, sort, fname, ...) abort
	  return lightline#statusline(0)
	endfunction

	" Syntastic can call a post-check hook, let's update lightline there
	" For more information: :help syntastic-loclist-callback
	function! SyntasticCheckHook(errors)
	  call lightline#update()
	endfunction

	let g:unite_force_overwrite_statusline = 0
	let g:vimfiler_force_overwrite_statusline = 0
	let g:vimshell_force_overwrite_statusline = 0
