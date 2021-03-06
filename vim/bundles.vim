" Setting up Vundle - the vim plugin bundler
set nocompatible
filetype on "makes stock Mac vim happy
filetype off

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    " we're on a new machine, so start from scratch"
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" improve tmux integration with focus events
Bundle "vim-scripts/Terminus"

Bundle 'gmarik/vundle'

" File Navigator
Bundle 'ctrlpvim/ctrlp.vim'
"let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" speed up from http://blog.patspam.com/2014/super-fast-ctrlp
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/Zenburn'
Bundle 'junegunn/seoul256.vim'

" new motions
Bundle 'tpope/vim-unimpaired'
" unimpaired Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-rbenv'
Bundle 'tpope/vim-endwise'
"Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-characterize'
"Bundle 'tpope/vim-pastie'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-vinegar'
" JSON text-object 'j'
Bundle 'tpope/vim-jdaddy'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'pangloss/vim-javascript'
" Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'thoughtbot/vim-rspec'
Bundle 'Raimondi/delimitMate'
"Bundle 'msanders/snipmate.vim'
Bundle 'kana/vim-textobj-user'

" ar, ir (around-ruby, inner-ruby) text objects
Bundle 'nelstrom/vim-textobj-rubyblock'
"required config
runtime macros/matchit.viM

Bundle 'vim-scripts/AutoComplPop'
" TODO replace AutoComplPop with this?
"bundle 'shougo/neocomplcache'
" or ajh17/VimCompletesMe

Bundle 'davidoc/taskpaper.vim'

" pretty status line
Bundle 'bling/vim-airline'
" let g:airline_powerline_fonts = 1

Bundle 'henrik/vim-yaml-flattener'
" shift-command-R (I think it is) that invokes it

" CamelCaseMotion plugin offers text objects for camel or snake cased words
" use motions ,w ,b ,e (the comma is part of the object)
Bundle 'bkad/CamelCaseMotion'

Bundle 'othree/html5.vim'
Bundle 'tpope/vim-markdown'
let g:vim_markdown_folding_disabled=1
let g:markdown_fenced_languages=['ruby', 'erb=eruby', 'javascript', 'html', 'sh']
Bundle 'zaiste/tmux.vim'

" speedy searches
Bundle 'mileszs/ack.vim'
if executable('ag')
  " use silver searcher whenever we can
  let g:ackprg = 'ag --vimgrep'
endif
" mnemonic for this is global search
nnoremap g/ :Ack!<space>
xnoremap g/ y:Ack <C-r>=fnameescape(@")<CR><CR>
nnoremap gr/ :Ack! --ruby<space>
xnoremap gr/ y:Ack --ruby <C-r>=fnameescape(@")<CR><CR>

" try new ultimate searcher plugin
"   can't figure out how to use .agignore
" Bundle 'mhinz/vim-grepper'
" nnoremap g/ :Grepper! -tool ag -open -switch -cword<cr>
" "xmap g/ <plug>(GrepperOperator)
" xnoremap g/ y:Grepper! -tool ag -open -switch -cword<cr>

" elixir
Bundle 'elixir-lang/vim-elixir'
Bundle 'slashmili/alchemist.vim'
" git/hg diff indicators
Bundle 'mhinz/vim-signify'
" fix bar/block cursor in tmux also FocusGained, FocusLost
Bundle 'sjl/vitality.vim'
" async test and build dispatcher for tmux (et.al.)
Bundle 'tpope/vim-dispatch'
" works with vim-dispatch for ,t test and ,T focused test
Bundle 'jgdavey/vim-turbux'
" consistent ctrl-hjkl between tmux panes and vim splits
Bundle 'christoomey/vim-tmux-navigator'
" self-evident
Bundle 'maba/vim-markdown-preview'
" heard about but also saw bug report, so try later
" andyl/vim-textobj-elixir

" clojure stuff
" Bundle 'tpope/vim-fireplace'
" Bundle 'guns/vim-clojure-static'
" Bundle 'tpope/vim-classpath'
" Bundle 'tpope/vim-leiningen'
" Bundle 'guns/vim-sexp'
" Bundle 'guns/vim-clojure-highlight'
" Bundle 'tpope/vim-sexp-mappings-for-regular-people'
" Bundle 'venantius/vim-eastwood'
" this is too strict for me yet
"Bundle 'vim-scripts/paredit.vim'

" coffeescript *sigh*
Bundle 'kchmck/vim-coffee-script'

Bundle 'jiangmiao/auto-pairs'
Bundle 'vim-scripts/taglist.vim'

" consistent split window opening from quickfix
Bundle 'yssl/QFEnter'
let g:qfenter_open_map = ['<CR>']
let g:qfenter_vopen_map = ['<C-v>']
let g:qfenter_hopen_map = ['<C-x>']
let g:qfenter_topen_map = ['<C-t>']

" <leader>fml shows all leader mappings
Bundle 'ktonga/vim-follow-my-lead'
let g:fml_all_sources = 1

"no more need to do :set paste (or so it claims)
Bundle 'ConradIrwin/vim-bracketed-paste'

" sequence diagrams rendered in browser
Bundle 'xavierchow/vim-sequence-diagram'
nmap <unique> <leader>sq <Plug>GenerateDiagram
" let g:generate_diagram_theme_hand = 1

" on first launch, run vundle
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
" load the plugin and indent settings for the detected filetype
filetype plugin indent on
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed.." vundle requirements done
" Setting up Vundle - the vim plugin bundler end

