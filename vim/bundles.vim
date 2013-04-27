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
let g:ctrlp_cmd = 'CtrlPMixed'

" another navigator. I really should limit to CtrlP or Lusty
Bundle 'sjbach/lusty'
" LustyExplorer finesse
map <Leader>f :LustyFilesystemExplorer<CR>
map <Leader>r :LustyFilesystemExplorerFromHere<CR>
map <Leader>b :LustyBufferExplorer<CR>
map <Leader>g :LustyBufferGrep<CR>
map <Leader>j :LustyJuggler<CR>

let g:LustyJugglerShowKeys = 'a'
let g:LustyJugglerAltTabMode = 1
noremap <silent> <A-TAB> :LustyJuggler<CR> "not working in terminal vim?
let g:LustyJugglerSuppressRubyWarning = 1

Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-rake'

" new motions
Bundle 'tpope/vim-unimpaired'
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
"Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-characterize'
"Bundle 'tpope/vim-pastie'
Bundle 'tpope/vim-ragtag'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'taq/vim-rspec'
Bundle 'Raimondi/delimitMate'
"Bundle 'msanders/snipmate.vim'
Bundle 'kana/vim-textobj-user'

" ar, ir (around-ruby, inner-ruby) text objects
Bundle 'nelstrom/vim-textobj-rubyblock'
runtime macros/matchit.vim "required config

Bundle 'vim-scripts/AutoComplPop'
" TODO replace AutoComplPop with this?
"Bundle 'Shougo/neocomplcache'

Bundle 'davidoc/taskpaper.vim'

" pretty status line
Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'

Bundle 'henrik/vim-yaml-flattener'
" shift-command-R (I think it is) that invokes it

" CamelCaseMotion plugin offers text objects for camel or snake cased words
" use motions ,w ,b ,e (the comma is part of the object)
Bundle 'bkad/CamelCaseMotion'

Bundle 'othree/html5.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'zaiste/tmux.vim'

" speedy searches
Bundle 'rking/ag.vim'
"nnoremap <leader>a :Ag 
map <leader>a :tabnew<CR>:Ag<space>
vmap <leader>a "hy:tabnew<CR>:Ag "<C-r>=escape(@h,'./"*()[]')<CR>"

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

