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

Bundle 'gmarik/vundle'

" File Navigator
Bundle 'kien/ctrlp.vim'
"let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" map <tab> :CtrlPBuffer<CR>

" another navigator. I really should limit to CtrlP or Lusty
" Bundle 'sjbach/lusty'
" map <Leader>f :LustyFilesystemExplorer<CR>
" map <Leader>r :LustyFilesystemExplorerFromHere<CR>
" map <Leader>b :LustyBufferExplorer<CR>
" map <Leader>g :LustyBufferGrep<CR>
" map <Leader>j :LustyJuggler<CR>

" let g:LustyJugglerShowKeys = 'a'
" let g:LustyJugglerAltTabMode = 1
" noremap <silent> <A-TAB> :LustyJuggler<CR>
"  "not working in terminal vim?
" let g:LustyJugglerSuppressRubyWarning = 1

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
Bundle 'rking/ag.vim'
"vmap <leader>a "hy:tabnew<CR>:Ag "<C-r>=escape(@h,'./"*()[]')<CR>"
nnoremap <leader>a :Ag!<space>
" mnemonic for this is global search
nnoremap g/ :Ag!<space>
" this isn't working to search for the highlighted text TODO
vnoremap <leader>a :Ag "<C-r>=escape(@h, './"*()[]')<CR>"

" elixir
Bundle 'elixir-lang/vim-elixir'
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

" consistent split window opening from quickfix
Bundle 'yssl/QFEnter'
let g:qfenter_open_map = ['<CR>']
let g:qfenter_vopen_map = ['<C-v>']
let g:qfenter_hopen_map = ['<C-x>']
let g:qfenter_topen_map = ['<C-t>']

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

