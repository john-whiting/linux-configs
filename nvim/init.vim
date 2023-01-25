syntax on

" Enable mouse controls for Windows Terminal
set mouse=a

" Setup tab and spacing count
set ts=4 sw=4

" Turn on line numbers
set number

source ~/.jwhiting/nvim/plugins.vim

luafile ~/.jwhiting/nvim/lua/telescope_setup.lua

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <space>fb <cmd>Telescope file_browser<cr>
