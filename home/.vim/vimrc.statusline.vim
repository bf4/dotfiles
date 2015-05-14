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
