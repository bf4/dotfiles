" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" ================ Copying, and Pasting  ============================

" from http://www.drbunsen.org/text-triumvirate.html
" Yank text to the OS X clipboard
if has("gui_running")

  if has("gui_mac") || has("gui_macvim")
    " Mac OSX specific copy / paste
    "Yank content in OS's clipboard
    noremap <leader>y "*y
    " vmap <leader>y "*y
    noremap <leader>yy "*Y
    " Preserve indentation while pasting text from the OS X clipboard
    noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
    " nmap <leader>p "*p
  endif
endif

" ================ Colors and Highlighting ============================
" http://yanpritzker.com/2012/04/17/how-to-change-vim-syntax-colors-that-are-annoying-you/
" With your cursor over the thing that’s highlighted in a bad color, hit the <leader>hi
" Note the info displayed in the status line, it will look something like:
"   hi<rspecGroupMethods> trans<rspecGroupMethods> lo<Todo> FG:#d33682
" The leftmost one is the one with highest precedence, and the one we want to override.
" Look at the list of available colors using :hi.
" Find the one you like and link it to the group you're modifying
"  hi! link rspecGroupMethods Type
map <Leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" ================ Moving around ============================

" switch between the currently open buffer and the previous one
nnoremap <leader><leader> <c-^>
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
"key mapping for window navigation
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Load tags from current or any parent path
set tags=tags;/

" ================ Cleaning up ============================
" see http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
" Show trailing whitespace:
au BufEnter * match ExtraWhitespace /\s\+$/
" match trailing whitespace, except when typing at the end of a line.
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" Show trailing whitespace:
au InsertLeave * match ExtraWhiteSpace /\s\+$/
" " Switch off :match highlighting.
" :match
" limit match memory leaks
" ruby syntax
	:let ruby_space_errors = 1
	:let ruby_no_expensive = 1
if version >= 702
      autocmd BufWinLeave * call clearmatches()
endif
" from http://www.bestofvim.com/tip/trailing-whitespace/
" trailing whitespace will be highlighted automatically
" match ErrorMsg '\s\+$'
"<Leader>rtw will remove trailing whitespace.
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
" function for autocmd to remove trailing whitespace
" automatically kills trailing whitespace when Vim writes
" Removes trailing spaces
" function TrimWhiteSpace()
"     %s/\s\+$//e
" :endfunction

" autocmd FileWritePre    * :call TrimWhiteSpace()
" autocmd FileAppendPre   * :call TrimWhiteSpace()
" autocmd FilterWritePre  * :call TrimWhiteSpace()
" autocmd BufWritePre     * :call TrimWhiteSpace()
" autocmd FileType ruby,haml,erb autocmd FileWritePre    * :call TrimWhiteSpace()
" autocmd FileType ruby,haml,erb autocmd FileAppendPre   * :call TrimWhiteSpace()
" autocmd FileType ruby,haml,erb autocmd FilterWritePre  * :call TrimWhiteSpace()
" autocmd FileType ruby,haml,erb autocmd BufWritePre     * :call TrimWhiteSpace()




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File operations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save with <C-s>
silent! nmap <silent> <C-s> :w<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" check syntax of current ruby file
" nnoremap <leader>w :!ruby -wc %<CR>
nnoremap <silent> <leader>w :echo system("ruby -wc " . bufname("%"))<CR>
