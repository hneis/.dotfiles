setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Declare the general config group for autocommand
augroup vue
    autocmd!
augroup END

noremap <leader>p :EslintFixAll<CR>

" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/js/*.nvimrc"), '\n')
    exe 'source' file
endfor
