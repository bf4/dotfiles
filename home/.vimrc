" ~/.vimrc
" see ../notes.txt for resources
" vim:set ts=2 sts=2 sw=2 expandtab:

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","
"
" https://github.com/thoughtbot/dotfiles/pull/382
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
" setup {
" let vim edit a crontab successfully, no error
" crontab: temp file must be edited in place
" via comment on  http://drawohara.com/post/6344279/crontab-temp-file-must-be-edited-in-place
au FileType crontab set nobackup nowritebackup

" Section: Options {{{1
" " ---------------------
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
if &compatible
  set nocompatible               " be iMproved
end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                      "Show line numbers
set numberwidth=5
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
" blinking off option: http://www.miek.nl/s/49240b66f0/ set
" set gcr=a:blinkwait0,a:block-cursor
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set autowrite                   "Automatically :write before running commands

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
" allow unsaved background buffers and remember marks/undo for them
set hidden

if exists('+colorcolumn')
    set colorcolumn=100 " color the 80th column differently as a wrapping guide
    set textwidth=0     " no automatic text wrapping
endif

" This makes RVM work inside Vim. I have no idea why.
set shell=bash

" ================ Turn Off Swap Files ==============

set noswapfile " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set nobackup
set nowb
"
" ================ Completion =======================

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" set wildmode=list:longest
" make tab completion for files/buffers act like bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/undodir*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"turn on syntax highlighting
syntax on

set encoding=utf-8

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

" ================ Scrolling ========================
"
" ================ Searching ========================
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set softtabstop=2
set expandtab                   " use spaces, not tabs (optional)

" Enable file type detection.
filetype plugin on
" Use the default filetype settings, so that mail gets 'tw' set to 72, 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================


" ================ Copying, and Pasting  ============================

" ================ Moving around ============================

" switch between the currently open buffer and the previous one
nnoremap <leader><leader> <c-^>

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Load tags from current or any parent path
set tags=tags;/
" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags<CR>
map <Leader>rt :!ctags --tag-relative --extra=+f -Rf.git/tags --exclude=.git,pkg --languages=-sql,javascript<CR><CR>
set tags+=.git/tags

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

" ================ Languages ============================
" check syntax of current ruby file
" nnoremap <leader>w :!ruby -wc %<CR>
nnoremap <silent> <leader>w :echo system("ruby -wc " . bufname("%"))<CR>

" ================ Plugins ============================
" filetype off                   " required!

" https://github.com/thoughtbot/dotfiles/pull/368
" https://github.com/junegunn/vim-plug
" PlugInstall
" PlugUpgrade
" PlugClean
" PlugStatus
" PlugDiff
" PlugSnapshot
call plug#begin('~/.vim/bundle')

Plug 'endwise.vim'
" https://github.com/tpope/vim-endwise
" wisely
"  add "end" in ruby,
"  endfunction/endif/more in vim script,
"  etc
Plug 'vim-scripts/tComment'
" https://github.com/vim-scripts/tComment
" As operator (the prefix can be customized via g:tcommentMapLeaderOp1
" and g:tcommentMapLeaderOp2):
"
"     gc{motion}   :: Toggle comments (for small comments within one line
"                     the &filetype_inline style will be used, if
"                     defined)
"     gcc          :: Toggle comment for the current line
"     gC{motion}   :: Comment region
"     gCc          :: Comment the current line


Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'ap/vim-css-color'
" CSS color highlighter
" recommended by http://statico.github.io/vim2.html

Plug 'thoughtbot/vim-rspec'
" Rspec.vim mappings
 map <Leader>t :call RunCurrentSpecFile()<CR>
"  map <Leader>s :call RunNearestSpec()<CR>
 map <Leader>l :call RunLastSpec()<CR>
" Overwrite g:rspec_command variable to execute a custom command.
" let g:rspec_command = "!rspec --drb {spec}"
" let g:rspec_command = "Dispatch zeus rspec {spec}"

" [ctrlp.vim]
Plug 'ctrlpvim/ctrlp.vim'
" see https://github.com/kien/ctrlp.vim
" see http://kien.github.io/ctrlp.vim/
" Create a file called root.dir in the root of your project - to make CtrlP work really nicely
" https://twitter.com/artemave/status/469204521219293185
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/.ctrlp_cache'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\/tmp',
  \ 'file': '\/public/stylesheets/.*css$'
  \ }

" syntax

Plug 'elzr/vim-json'
"  If you just don't care for concealing you can easily disable it adding let
"  g:vim_json_syntax_conceal = 0
"  All warnings can be turned off with a let g:vim_json_warnings=0
"  g:vim_json_syntax_concealcursor

" colorschemes
Plug 'railscasts'


" All of your Plugins must be added before the following line
if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

call plug#end()

" colorschemes see
"   http://vim.wikia.com/wiki/Using_GUI_color_settings_in_a_terminal
"   http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"   https://code.google.com/p/vimcolorschemetest/
"   http://bytefluent.com/vivify/
"   http://vimdoc.sourceforge.net/htmldoc/syntax.html
"   http://robotsrule.us/vim/256colors.txt
if has("gui_running")

  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h14
    " colorscheme Dark2BF
    colorscheme benjamin
    " Tell MacVim not to pop up a dialog on changed file vs. swp
    set go+=c
  else
    set guifont=Monospace\ Bold\ 12
    colorscheme railscasts
  endif
else
  set t_Co=256
  colorscheme asmanian_bloodBF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2  " Always show the status line
set statusline=%!SetStatusLine()

let g:showFullPathInStatusLine = 0

function! SetStatusLine()
  set statusline=\ ●\                     " Show an indicator for the current window
  set statusline+=%#Warning#%m            " Show if the file has been modified

  if g:showFullPathInStatusLine
    set statusline+=%#StatusLineFile#[%f]   " Show the full path to the file
  else
    set statusline+=%#StatusLineFile#[%t]   " Just show the file name
  endif

  set statusline+=%#StatusLineFileType#%y " Then show the file type

  " Fugitive
  set statusline+=%#StatusLineGit#
  set statusline+=%{fugitive#statusline()}
  set statusline+=%#StatusLine#

  " Right aligned items
  set statusline+=%=
  set statusline+=%<
  set statusline+=%#Comment#
  set statusline+=[%l,%c]     " Show the current line and column
  set statusline+=[%p%%]      " Show the current % through the file
  set statusline+=[%L\ lines] " Show the number of lines

  set statusline+=%#*#
endfunction!

function! ToggleFullPathInStatusLine()
  let g:showFullPathInStatusLine = !g:showFullPathInStatusLine
  call SetStatusLine()
endfunction

" Toggle the full path showing in the status line
noremap <silent> <leader>fp :call ToggleFullPathInStatusLine()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et

  " Expand tabs in Go. Was gofmt raised in a barn?!
  " via https://github.com/garybernhardt/dotfiles/commit/aedbfe39293886721722993398f5e625591ebfc4
  autocmd! FileType go set sw=4 sts=4 expandtab | retab
augroup END

" BF ADDED from http://dominique.pelle.free.fr/.vimrc.html

if has('autocmd')
  " also
  " :so $MYVIMRC
  " Source .vimrc when I write it.  The nested keyword allows
  " autocommand ColorScheme to fire when sourcing ~/.vimrc.
  au! BufWritePost .vimrc nested source %

endif

  if filereadable(expand("~/.vim/vimrc.local.vim"))
      source ~/.vim/vimrc.local.vim
  endif
  " load last
  if has("autocmd")
    " autocmd BufReadPost fugitive://* set bufhidden=delete
  endif
" }

