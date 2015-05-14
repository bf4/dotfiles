" let vim edit a crontab successfully, no error
" crontab: temp file must be edited in place
" via comment on  http://drawohara.com/post/6344279/crontab-temp-file-must-be-edited-in-place
au FileType crontab set nobackup nowritebackup

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                      "Show line numbers
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
" blinking off option: http://www.miek.nl/s/49240b66f0/ set
" set gcr=a:blinkwait0,a:block-cursor
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
" allow unsaved background buffers and remember marks/undo for them
set hidden

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Backup ==================
" " Store temporary files in a central spot
" set backup
" if has("win32") || has("win64")
"   set backupdir=$TMP
"   set directory=$TMP
" else
"   " _ backups {{{
"   " set undodir=~/.vim/undodir//     " undo files
"   " set backupdir=~/.vim/tmp/backup// " backups
"   set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"   " ending with the double slash includes the full path in the filename
"   " of the swap files to avoid conflicts
"   " set directory=~/.vim/tmp//
"   " set directory=~/.vim/tmp/swap//   " swap files
"   " set backup
"   " set noswapfile
"   " " _ }}}
"   " Set up persistent undo for versions of vim that support it
"   " if v:version >= 703
"   "   set undodir=~/.vim/undodir
"   "   set undofile
"   "   set undolevels=1000
"   "   set undoreload=1000
"   " endif
"   set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" end

" ================ Completion =======================

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" set wildmode=list:longest
" make tab completion for files/buffers act like bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================


" set scrolloff=8         "Start scrolling when we're 8 lines away from margins
" keep more context when scrolling off the end of a buffer
set scrolloff=3
set sidescrolloff=15
set sidescroll=1

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" ================ Searching ========================
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" ================ Older ========================

" highlight current line
set cursorline
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
