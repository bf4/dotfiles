if &compatible
  set nocompatible
end
" set nocompatible               " be iMproved
" filetype off                   " required!

" https://github.com/thoughtbot/dotfiles/pull/368
" https://github.com/junegunn/vim-plug
" PlugInstall
" PlugUpgrade
" PlugClean
" PlugStatus
" PlugDiff
" PlugSnapshot
" Shim command and function to allow migration from Vundle to vim-plug.
function! VundleToPlug(vundle_command, arg, ...)
  echom "You are using Vundle's `".a:vundle_command."` command to declare plugins. Dotfiles now uses vim-plug for plugin mangagement. Please rename uses of `".a:vundle_command."` to `Plug`. Plugin was '".a:arg."'."
  let vim_plug_options = {}

  if a:0 > 0
    if has_key(a:1, 'name')
      let name = a:1.name
      let vim_plug_options.dir = "$HOME/.vim/bundle/".a:1.name
    endif

    if has_key(a:1, 'rtp')
      let vim_plug_options.rtp = a:1.rtp
    endif
  endif

  Plug a:arg, vim_plug_options
endfunction

com! -nargs=+  -bar Plugin call VundleToPlug("Plugin", <args>)
com! -nargs=+  -bar Bundle call VundleToPlug("Bundle", <args>)

call plug#begin('~/.vim/bundle')

" set runtimepath+=~/.vim/bundle/vundle/
" call vundle#begin()

" Define bundles via Github repos
Plug 'editorconfig/editorconfig-vim'
" Plug 'christoomey/vim-run-interactive'
" Plug 'pbrisbin/vim-mkdir'
" Plug 'scrooloose/syntastic'
" Plug 'slim-template/vim-slim'
" Plug 'thoughtbot/vim-rspec'
" Plug 'tpope/vim-bundler'
" Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rails'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
" vim-obsession works with tmux-resurrect
" https://github.com/tmux-plugins/tmux-resurrect#restoring-vim-and-neovim-sessions
Plug 'tpope/vim-obsession'
" Plug 'vim-ruby/vim-ruby'
" Plug 'vim-scripts/ctags.vim'
" Plug 'vim-scripts/matchit.zip'
" Plug 'vim-scripts/tComment'
" Plug 'gmarik/vundle'
" " required! let Vundle manage Vundle
" " Brief help
" " :PluginList          - list configured bundles
" " :PluginInstall(!)    - install(update) bundles
" " :PluginSearch(!) foo - search(or refresh cache first) for foo
" " :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
" " see :h vundle for more details or wiki for FAQ
"  " NOTE: comments after Plugin command are not allowed..
"
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
Plug 'fatih/vim-go'
map <Leader>g :w\|:!go run %<cr>
" go get code.google.com/p/go.tools/cmd/goimports
" let g:go_fmt_command = "goimports"

Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
" Standard stuff here. :Eval evaluates a range (:%Eval gets the whole file),
" :Require requires a namespace with :reload (:Require! does :reload-all),
" either the current buffer or a given argument. :RunTests kicks off
" (clojure.test/run-tests) and loads the results into the quickfix list.
"
" There's a cp operator that evaluates a given motion (cpp for the innermost
" form under the cursor). cm and c1m are similar, but they only run
" clojure.walk/macroexpand-all and macroexpand-1 instead of evaluating the
" form entirely.
"
" Any failed evaluation loads the stack trace into the location list, which
" can be easily accessed with :lopen.
Plug 'tpope/vim-salve'
" :Console command to start a REPL or focus an existing instance if already
" running using dispatch.vim.
" Autoconnect fireplace.vim to the REPL, or autostart it with :Console.
" Navigation commands: :Esource, :Emain, :Etest, and :Eresource.
" Alternate between test and implementation with :A.
" Use :make to invoke lein, complete with stacktrace parsing.
" Default dispatch.vim's :Dispatch to running the associated test file.
" 'path' is seeded with the classpath to enable certain static Vim and
" fireplace.vim behaviors.
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
"
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
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/.ctrlp_cache'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\/tmp',
  \ 'file': '\/public/stylesheets/.*css$'
  \ }
" https://github.com/JazzCore/ctrlp-cmatcher
" POSIX
"   Linux
"     apt-get install python-dev
"   OSX
"     export CFLAGS=-Qunused-arguments
"     export CPPFLAGS=-Qunused-arguments
"   Then run the installation script:
"
"   cd ~/.vim/bundle/ctrlp-cmatcher/
"   ./install.sh
" Plug 'JazzCore/ctrlp-cmatcher'
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }


" syntax
Plug 'vim-coffee-script'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-haml'
" Plug 'kien/rainbow_parentheses.vim'
" hbs https://github.com/toranb/dotfiles/commit/ddb44736ab3400932649f9ee0e76302c73efffb1
" Plug 'mustache/vim-mustache-handlebars'
Plug 'joukevandermaas/vim-ember-hbs'
" Plug 'mmalecki/vim-node.js'
" Plug 'heartsentwined/vim-emblem'
" Plug 'pangloss/vim-javascript'

Plug 'isRuslan/vim-es6'

Plug 'elzr/vim-json'
"  If you just don't care for concealing you can easily disable it adding let
"  g:vim_json_syntax_conceal = 0
"  All warnings can be turned off with a let g:vim_json_warnings=0
"  g:vim_json_syntax_concealcursor
" Plug 'tpope/vim-markdown'
Plug 'plasticboy/vim-markdown'
" The following work on normal and visual modes:
" ]]: go to next header.
" [[: go to previous header. Contrast with ]c.
" ][: go to next sibling header if any.
" []: go to previous sibling header if any.
" ]c: go to Current header.
" ]u: go to parent header (Up).
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby','javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']
" let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=100

" sometimes
Plug 'zerowidth/vim-copy-as-rtf'
" OSX only. :CopyRTF

" colorschemes
" Plug 'vim-scripts/colorsupport.vim'
" used to make gui colorschemes work in the terminal
" see http://vim.wikia.com/wiki/Using_GUI_color_settings_in_a_terminal
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'bf4/vim-wombat256i'
Plug 'molokai'
Plug 'railscasts'
Plug 'zeis/vim-kolor'
" see https://github.com/chriskempson/base16-builder/blob/master/base16
"     https://github.com/chriskempson/base16-builder/blob/master/base16
" Plug 'chriskempson/base16-vim'
"
"
" All of your Plugins must be added before the following line
" call vundle#end()            " required
" filetype plugin indent on    " required
if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

call plug#end()

" [ ember-cli projection ] typing `:Ecomponent tab` will open a component tab
" https://gist.github.com/chantastic/9947601
" https://github.com/pjg/dotfiles/blob/1c7d343ff0ef8a68465efcd94c3fa5de963cc182/.vimrc#L419-L598
let g:ember_cli_projections = {
      \   "app/adapters/*.js": {
      \     "command": "adapter",
      \     "template": [
      \       "// export default DS.{capitalize}Adapter.extend();"
      \     ]
      \   },
      \
      \   "app/components/*.js": {
      \     "command": "component",
      \     "template": [
      \       "export default Ember.Component.extend({",
      \       "",
      \       "});"
      \     ]
      \   },
      \
      \   "app/controllers/*.js": {
      \     "command": "controller",
      \     "template": [
      \       "export default Ember.Controller.extend({",
      \       "",
      \       "});"
      \     ]
      \   },
      \
      \   "app/helpers/*.js": {
      \     "command": "helper",
      \     "template": [
      \       "// Please note that Handlebars helpers will only be found automatically by the",
      \       "// resolver if their name contains a dash (reverse-word, translate-text, etc.)",
      \       "// For more details: http://stefanpenner.github.io/ember-app-kit/guides/using-modules.html",
      \       "",
      \       "export default Ember.Handlebars.makeBoundHelper(function() {",
      \       "",
      \       "});"
      \     ]
      \   },
      \
      \   "app/models/*.js": {
      \     "command": "model",
      \     "template": [
      \       "export default DS.Model.extend({",
      \       "",
      \       "});"
      \     ]
      \   },
      \
      \   "app/router.js": {
      \     "command": "router"
      \   },
      \
      \   "app/routes/*.js": {
      \     "command": "route",
      \     "template": [
      \       "export default Ember.Route.extend({",
      \       "",
      \       "});"
      \     ]
      \
      \   },
      \
      \   "app/styles/*.css": {
      \     "command": "style",
      \     "template": [
      \       "/* {}.css */",
      \       ""
      \     ]
      \   },
      \
      \   "app/templates/*.hbs": {
      \     "command": "template"
      \   },
      \
      \   "app/utils/*.js": {
      \     "command": "util"
      \   },
      \
      \   "app/views/*.js": {
      \     "command": "view",
      \     "template": [
      \       "export default Ember.View.extend({",
      \       "",
      \       "});"
      \     ]
      \   }
      \ }
