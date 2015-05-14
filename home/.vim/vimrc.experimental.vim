" Set up persistent undo for versions of vim that support it
if v:version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000
  set undoreload=1000
endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" inoremap <C-U> <C-G>u<C-U>
" Search recursively for the tags file
" set tags=tags;/
" "
" " Spell checking
" if v:version >= 700
"   " Enable spell check for text files
"     autocmd BufNewFile,BufRead *.txt,*.wiki,*.mkd,*.markdown setlocal spell
"     spelllang=en
"     endif
" Set up the yankring history location
" let g:yankring_history_dir = "~/.vim/tmp/yankring"
"" Show the yankring """""""""""""""""""""""""""""""""
" map <leader>yr :YRShow<cr>

" Quickly generate some lorem ipsum text
" map <leader>lorem :Loremipsum<CR>
"
" " Quickly turn wrapping on and off
" map <leader>wr :set wrap!<CR>
"
" " Quickly turn invisibles on and off
" map <leader>li :set list!<CR>
"
" " Encode HTML entities
" map <leader>enc :HTMLSpecialChars<CR>
"
" " Unencode HTML entities
" map <leader>uenc :HTMLSpecialCharsDecode<CR>
"
" " Turn expandtab on and off
" map <silent> <leader>tabon :set expandtab!<CR>
" map <silent> <leader>taboff :set expandtab<CR>
"
" " Create a ConqueTerm buffer shell  
" map <silent> <leader>cts :ConqueTerm bash<CR>
" "
" " Create a horizontal split screen with a ConqueTerm buffer shell
" map <silent> <leader>ctsh :ConqueTermSplit bash<CR>
"
" " Create a vertical split screen with a ConqueTerm buffer shell
" map <silent> <leader>ctsv :ConqueTermVSplit bash<CR>
"
" " Open the command + T browser window
" map <silent> <leader>ct :CommandT<CR>
"
" " Remove trailing whitespace
" map <leader>rmtws :%s/\s\+$//<cr>:let @/=''<CR>
"
" " Maps the combination of w and % to expand the out to the current word
" cmap w% <c-r>=expand("<cword>")<CR>
"
