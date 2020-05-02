" Enables bold text
let g:gruvbox_bold = 1

" Enables italic text.
" let g:gruvbox_italic = 1

" Enables underlined text.
let g:gruvbox_underline = 1

" Enables undercurled text.
let g:gruvbox_undercurl = 1

" Changes dark mode contrast. Overrides g:gruvbox_contrast option. Possible values are soft, medium and hard.
let g:gruvbox_contrast_dark = 'soft'

" Changes light mode contrast. Overrides g:gruvbox_contrast option. Possible values are soft, medium and hard.
let g:gruvbox_contrast_light = 'medium'

" Changes cursor background while search is highlighted. Possible values are any of gruvbox palette.
let g:gruvbox_hls_cursor = 'orange'

" Changes sign column background color. Possible values are any of gruvbox palette.
let g:gruvbox_sign_column = 'bg1'

" Changes color column background color. Possible values are any of gruvbox palette.
let g:gruvbox_color_column = 'bg1'

" Changes vertical split background color. Possible values are any of gruvbox palette.
let g:gruvbox_vert_split = 'bg0'

" Enables italic for comments.
let g:gruvbox_italicize_comments = 1

" Inverts selected text.
let g:gruvbox_invert_selection = 1

" Inverts GitGutter and Syntastic signs. Useful to rapidly focus on.
let g:gruvbox_invert_signs = 0

" Inverts indent guides. Could be nice paired with set list so it would highlight only tab symbols instead of it's background.
let g:gruvbox_invert_indent_guides = 0

" Inverts tabline highlights, providing distinguishable tabline-fill.
let g:gruvbox_invert_tabline = 0

" Extrahighlighted strings
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 0

function! GruvboxSetTransparent()
  hi Normal guibg=NONE ctermbg=NONE
endfunction

function! GruvboxUnsetTransparent()
    colorscheme gruvbox
endfunction
