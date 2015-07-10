" ~/.vimrc
" see notes.txt for resources
" vim:set ts=2 sts=2 sw=2 expandtab:
"
" https://github.com/thoughtbot/dotfiles/pull/382
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
" Use local vimrcs if available {
    source ~/.vim/vimrc.setup.vim
    source ~/.vim/vimrc.syntax.vim
    source ~/.vim/vimrc.mappings.vim
    source ~/.vim/vimrc.plugins.vim
    " guis must be after plugins so that Bundled colors are available
    " colorscheme, see guis.local
    source ~/.vim/vimrc.guis.vim
    source ~/.vim/vimrc.statusline.vim
    source ~/.vim/vimrc.commands.vim
    if filereadable(expand("~/.vim/vimrc.experimental.vim"))
        source ~/.vim/vimrc.experimental.vim
    endif
    if filereadable(expand("~/.vim/vimrc.local.vim"))
        source ~/.vim/vimrc.local.vim
    endif
    source ~/.vim/vimrc.loadlast.vim
" }

