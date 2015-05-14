"setup the mouse for terminal use
set mouse=a
set ttymouse=xterm2
"
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
  if &term != 'cygwin'
    "export TERM=screen-256color
    "# or:
    "export TERM=xterm-256color
    silent !echo "setting 256 color term"
  endif
  set t_Co=256
  colorscheme asmanian_bloodBF
  " " let mycolorscheme = 'benjamin'
  " " colorscheme solarized
  " " colorscheme railscasts
  " " colorscheme grb3
  "
  " " wrap color scheme in gui->term plugins
  " if exists(':ColorSchemeSave')
  "   " :CoolorSchemeBrowse " Browse and preview colorschemes in your &runtimepath by
  "   " :ColorScheme " manually try colorschemes just like ':colorscheme'.
  "   " For faster startups, save 'converted' colorscheme
  "   " you should use ':ColorSchemeSave <new-colorscheme-name>'
  "   " Checking if <mycolorscheme>_term exists
  "   "   (I use a '-' because a '.' makes a weird error in macvim "vim menu-item path is not sub-menu")
  "     silent !echo "using colorsupport.vim with ".mycolorscheme
  "     execute 'ColorScheme '.mycolorscheme
  "     " execute 'ColorSchemeSave '.mycolorscheme.'_term'
  " elseif exists('s:use_guicolorscheme')
  "   silent !echo "using GuiColorScheme"
  "   let s:use_guicolorscheme = 1
  "   runtime! plugin/guicolorscheme.vim
  "   execute 'GuiColorScheme '.mycolorscheme
  " elseif exists('s:use_CSApprox')
  "   silent !echo "using csapprox"
  "   let s:use_CSApprox = 1
  "   "dont load csapprox if there is no gui support - silences an annoying warning
  "   let g:CSApprox_loaded = 1
  "   let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
  "   execute 'colorscheme '.mycolorscheme
  " else
  "   silent !echo "not using any terminal support plugin"
  "   execute 'colorscheme '.mycolorscheme
  " endif
endif
