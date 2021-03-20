" ~/.config/nvim/init.vim

" To figure out what a current mapping is:
" :verbose map {key-combo} where
" key-combo is of the form <c-i> for Control I
"                          <D-r> for Command R
" :map and :map! show existing mappings
"
" RANDOM TIPS
" :set ff=unix
" changes file format (line endings) without any regex business

"auto-source this file on save
augroup reload_vimrc
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" preserve default comma behavior as backslash (reverse of f,t search)
map \ ,
" Make certain to remap leader before other leader mappings
let mapleader = ","
" will want separate localleader if you ever find a workflow to use it with
let maplocalleader = ","

" TODO go thorugh https://neovim.io/doc/user/vim_diff.html and find duplicates
" of default settings

" warning this one might cause problems in some terminals/tmux
" allows 24 bit colors
set termguicolors
set encoding=utf-8
set laststatus=2
set ruler " show line, col info in statusline
set autoread " re-read opened files edited in another program
set title " Set the title of the iterm tab
syntax on
set formatoptions+=r " comment insert formatting tweak

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" turn off search highlighting
nnoremap <silent> <CR> :nohlsearch<CR>

" new nvim feature to incremntally show command effects
" http://evantravers.com/articles/2019/02/13/enhancing-search-and-replace-in-neovim-with-inccomand/
set inccommand=split

" Whitespace stuff
set nowrap
set shiftwidth=2
set softtabstop=2
set expandtab
set cursorline
" these listchars might get in the way, but give them a try
" set listchars=eol:↲,tab:▶▹,nbsp:␣,extends:…,trail:•
set listchars=nbsp:␣,extends:…,trail:•
set list
":set nolist to turn off

set nobackup
set noswapfile
"set bufhidden "delete"
set hidden

""" Undo #undo
" undofile - This allows you to use undos after exiting and restarting
" :help undo-persistence
" This is only present in 7.3+
if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undodir=~/.config/nvim/undo
set undofile

" Use mac system cliboard by default
set clipboard=unnamedplus

" OLD WAY
" toggle relative numbering
" nnoremap <silent> <F5> :set relativenumber!<CR>
" fancier version that also toggles number -- I'm not sure I like it
" nnoremap <silent> <F5> :exec &number == &relativenumber ? "set number!" : "set relativenumber!"<CR>

" number management
set number relativenumber
" Use hybrid numbers for normal mode active window, but absolute number for
" inactive window or active window in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"visual indicator of end of edit area
set cpoptions+=$
"set virtualedit=onemore "see h 'virtualedit'

"lines above/below cursor
set scrolloff=5
" horizontal scroll per character with offset of 5
set sidescroll=1
set sidescrolloff=5
set mouse=a

"intuitive locations of split windows
set splitbelow splitright
"allow virtual editing in visual block mode
set virtualedit=block
set diffopt=vertical "vertical diff splits

" fuzzier find with :find
set path+=**

" python stuff cargo culted from internet
" NOTE using pyenv, so I need to `pyenv local neovim2` or `pyenv local neovim3`
" before executing what :CheckHealth suggests
" let g:python_host_prog = '/Users/gvaughn/.pyenv/versions/neovim2/bin/python'
" let g:python3_host_prog = '/Users/gvaughn/.pyenv/versions/neovim3/bin/python'
" NOTE both versions can be on path via asdf https://github.com/danhper/asdf-python#using-multiple-versions-of-python

" enable omni syntax completion
augroup omnifuncs
  autocmd!
  autocmd FileType elixir setlocal omnifunc=elixircomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup end

set wildignore+=*.o,*.obj,.git,*.rbc,**/vendor/**,**/public/**,node_modules,**/*.js.map,*.png,*.jpg,*.svg,*.wof,*.zip,*.exe,*.beam,*deps/*,*_build/*

if empty(glob(('~/.config/nvim/autoload/plug.vim')))
    " we're on a new machine, so start from scratch"
    echo "Installing Plug and defined plugins .."
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')

" camel and snake case word delimiters (replaces CamelCaseMotion)
" the prefix makes it act like CamelCaseMotion which I like better
" than the default of always doing inner-Word "words"
" I mostly use it for <option>-w to jump to inner part of snake cased words
Plug 'chaoren/vim-wordmotion'
  " let g:wordmotion_prefix = ','
  " Instead of taking over the leader key, this uses the option key (with
  " Terminal.app settings to use option as meta key)
  let g:wordmotion_mappings = {
  \ 'w' : '<M-w>',
  \ 'b' : '<M-b>',
  \ 'e' : '<M-e>',
  \ 'ge' : 'g<M-e>',
  \ 'aw' : 'a<M-w>',
  \ 'iw' : 'i<M-w>',
  \ '<C-R><C-W>' : '<C-R><M-w>'
  \ }

" fzf fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting
  " Ctrl-N and Ctrl-P navigate history of searches instead of list
  let g:fzf_history_dir = '~/.config/nvim/fzf-history'
  " basic fuzzy find (can multi-select with TAB)
  nnoremap <silent> <C-P> :Files<CR>
  augroup localfzf
    " I'm not sure what this does
    autocmd!
    autocmd FileType fzf :tnoremap <buffer> <C-J> <C-J>
    autocmd FileType fzf :tnoremap <buffer> <C-K> <C-K>
  augroup END

  " Better command history
  nnoremap <leader>: :call fzf#vim#command_history({'right': '40'})<CR>

  " Better search history
  nnoremap <leader>/ :call fzf#vim#search_history({'right': '40'})<CR>

  command! -bang -nargs=* MyBTags call fzf#vim#buffer_tags(<q-args>, {'right': '40'})
  " outline of buffer
  nnoremap <leader>o :MyBTags<CR>

  command! -bang -nargs=* MyTags call fzf#vim#tags(<q-args>, {'right': '40'})
  " outline/tags of project
  " TODO sizing is not right, but I don't use it much either, yet
  nnoremap <silent> <leader>O :MyTags<CR>

  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>gl :Commits<CR>
  nnoremap <leader>gh :BCommits<CR>
  nnoremap <leader>m :Maps<CR>

" Stolen from https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" command! -bang -nargs=* Fzgrep call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"
" another version from fzf README with preview window
" the '?' shows a very cool preview! Doing Fzgrep! does a fullscreen preview/search
command! -bang -nargs=* Fzgrep
  \ call fzf#vim#grep(
  \  'rg --column --line-number --no-heading --color "always" '.shellescape(<q-args>), 1,
  \  <bang>0 ? fzf#vim#with_preview('up:60%')
  \          : fzf#vim#with_preview('right:50%:hidden', '?'),
  \  <bang>0)

  " cross file regex search
  nnoremap <silent> g/ :Fzgrep!<CR>
  " search project for word under cursor
  nnoremap <silent> <leader>* :Fzgrep <C-R><C-W><CR>
  vnoremap <leader>* :call SearchVisualSelectionWithAg()<CR>
  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Fzgrep' selection
  endfunction

" I really want to use vim-grepper but Fzgrep above gets me 90% of what I want
" What I like better about vim-grepper is that I can supply extra flags to rg (like -telixir)
" This is very cool, but it uses quickfix window
" I need to figure out how to config quickfix to act
" more like the fzf window: esc to dismiss, ctrl-x/ctrl-v for splits, etc.
" plus inverting it with best match on bottom would be nice
" for now I'm fitting ripgrep into fzf paradigm
" Plug 'mhinz/vim-grepper'
" let g:grepper.tools = ['rg', 'git', 'grep']
" let g:grepper.next_tool = '<leader>g'
" nnoremap g/ :Grepper -tool rg<cr>
" nmap gs <plug>(GrepperOperator)
" xmap gs <plug>(GrepperOperator)
" nnoremap <leader>* :Grepper -cword -noprompt<cr>

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#custom#var')
    let g:deoplete#custom#var = {}
  endif
  " use tab for completion
  " inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
  " inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

" cargo cult from LanguageClient_neovim wiki
"  this ends up inserting literal "(pumvisible ..." junk
" Plug 'roxma/nvim-completion-manager'
" imap <expr> <CR> (pumvisible() ? "\<C-Y>\<Plug>(expand_or_cr)" : "\<CR>")
" imap <expr> <Plug>(expand_or_cr) (cm#completed_is_snippet() ? "\<C-U>" : "\<CR>")
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
" inoremap <silent> <C-U> <C-R>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<CR>
" let g:UltiSnipsJumpForwardTrigger = "<C-J>"
" let g:UltiSnipsJumpBackwardTrigger = "<C-K>"

" Polyglot loads language support on demand!
Plug 'sheerun/vim-polyglot'

" Execute code checks, find mistakes, in the background
Plug 'neomake/neomake'
  " Run Neomake when I save any buffer
  augroup localneomake
    autocmd! BufWritePost * Neomake
  augroup END
  " line below errors on vim startup
  " call neomake#configure#automake('nw', 1000)
  " Don't tell me to use smartquotes in markdown ok?
  let g:neomake_markdown_enabled_makers = []
  " elixir maker has problems finding structs, mix seems to be better
  " let g:neomake_elixir_enabled_makers = ['mix', 'credo']
  let g:neomake_elixir_enabled_makers = ['mix']
  " workaround so dev-mode autoload still works
  let $MIX_ENV = 'test'

  let g:neomake_ruby_enabled_makers = ['rubocop', 'mri']

  " let g:neomake_open_list = 2
  " let g:neomake_logfile = '/tmp/neomake.log'

Plug 'ngmy/vim-rubocop'

" Easily manage tags files
Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_cache_dir = '~/.tags_cache'

" I really don't use projectionist
" Plug 'tpope/vim-projectionist' " required for some navigation features
  augroup elixir
    " I can disable on a particular buffer with
    " :autocmd! elixir BufWritePost *.exs,*.ex
    au!
    autocmd BufWritePost *.exs,*.ex silent :!mix format %
  augroup END

Plug 'slashmili/alchemist.vim' " elixir goodies
  " function signatures in preview
  let g:alchemist#extended_autocomplete = 1

  "optional if you want to close the preview window automatically
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Plug 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins'}
" let $ELIXIRLS = '/Users/gvaughn/dotfiles/config/nvim/elixir-ls-release'
" let g:LanguageClient_serverCommands = {
"     \ 'elixir': ['$ELIXIRLS/language_server.sh']
"     \ }
" " Automatically start language servers.
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_hasSnippetSupport = 0

"  " cribbed from https://github.com/JakeBecker/elixir-ls/issues/76
"  let g:languageClient_rootMarkers = {
"    \ 'elixir': ['mix.exs'],
"    \ }

  " TODO use custom LS event to only do this stuff when a LanguageServer is active
  " need an augroup but also need "autcmd User LanguageClientStarted"
  " and I gotta look up the syntax and can't be bothered right now
"augroup LanguageClient_config
"  autocmd!
"  " set up gq to use language server's formatting
"  set formatexpr=LanguageClient#textDocument_rangeFormatting()

"  " none of these did much for debugging, but vim-lsp below showed
"  " me everything ElixirLS was doing
"  " let g:LanguageClient_trace = 'verbose'
"  " let g:LanguageClient_windowLogMessageLevel = 'Log'
"  " let g:LanguageClient_loggingLevel = 'DEBUG'
"  " let g:LanguageClient_rootMarkers = {
"  "    \ 'elixir': ['mix.exs']
"  "    \ }

"  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"  " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

"  "optional if you want to close the preview window automatically
"  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" augroup END

" only doing this because LanguageClient_neovim sends completions as snippets
" Doesn't look like it parses the format LC sends them in
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
" inoremap <silent> <C-U> <C-R>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<CR>
" let g:UltiSnipsJumpForwardTrigger = "<C-J>"
" let g:UltiSnipsJumpBackwardTrigger = "<C-K>"

" I'm going to try this along with pre-built snippets for a while
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" elixir snippets are listed here: https://github.com/honza/vim-snippets/blob/master/snippets/elixir.snippets
" not sure if I like ctrl-j/k navigation and I may also want to have final
" cursor on following line in all cases

" TODO this one below has good logging and helped me debug ElixirLS
" but it's a very bare-bones plugin. I like that it's only vimscript though
" instead of the python that LanguageClient_neovim requires

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'

" let g:lsp_log_verbose = 1
" " let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:lsp_log_file = expand('/tmp/vim-lsp.log')
" " let g:lsp_signs_error = {'text': '!'}
" " let g:lsp_signs_warning = {'text': '?'}
" " let g:lsp_signs_hint = {'text': ';'}
" let g:lsp_signs_enabled = 1

" augroup elixir_lsp
"   au!
"   au User lsp_setup call lsp#register_server({
"     \ 'name': 'elixirls',
"     \ 'cmd': {server_info->['/Users/gvaughn/dotfiles/config/nvim/elixir-ls-release/language_server.sh']},
"     \ 'whitelist': ['elixir', 'eelixir']
"     \ })
" augroup END

" heard about this, but saw bug report, so try later
" Plug 'andyl/vim-textobj-elixir'

Plug 'powerman/vim-plugin-AnsiEsc' "better ANSI sequence handling

Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'trevordmiller/nova-vim'
" Plug 'artcticicestudio/nord-vim'

" new motions
Plug 'tpope/vim-unimpaired'
" unimpaired Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv

" I'm going to try vim-sandwich, but keeping this here as a reminder if I want to go back
" Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'tpope/vim-rbenv', { 'for': 'ruby' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
  let g:vim_markdown_folding_disabled=1
  let g:markdown_fenced_languages=['ruby', 'erb=eruby', 'javascript', 'html', 'sh', 'elixir']

Plug 'machakann/vim-sandwich'
" core commands are `sa` surround-add, `sd` surround-delete, `sr` surround-replace
" commentary: http://evantravers.com/articles/2019/01/07/vim-sandwich-vs-vim-surround/
" an Elixir keyword list (like [a: 1, b:2]) can be converted to a map via:
" srbi%{<CR>}<CR> (mnemonic: surround-replace any _b_racket _i_nteractively
" with start of '%{}' and end of '}')

" per advice from vim-sandwich docs:
" `s` can be replaced by `cl` but I don't commonly use it, so :shrug:
nmap s <Nop>
xmap s <Nop>
" I'm not sure I need these training wheels, but not sure yet
" runtime macros/sandwich/keymap/surround.vim
" these customizations let me do things like `saiwm`
"       to surround an inner word with a 'm'ap syntax: %{...}
"       a capital `M` will prompt for a struct name
"       or to visually select a line and `sa3"`
"       to surround a line with """..."""
augroup elixir_sandwich
  au!
autocmd FileType elixir call sandwich#util#addlocal([
\   {'buns': ['"""', '"""'], 'nesting': 0, 'input': ['3"']},
\   {'buns': ['%{', '}'], 'nesting': 1, 'input': ['m']},
\   {'buns': 'StructInput()', 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['M'], 'listexpr': 1, 'nesting': 1},
\   {'buns': ['%\w\+{', '}'], 'input': ['M'], 'nesting': 1, 'regex': 1},
\ ])
augroup END

function! StructInput() abort
  let s:StructLast = input('Struct: ')
  if s:StructLast !=# ''
    let struct = printf('%%%s{', s:StructLast)
  else
    throw 'OperatorSandwichCancel'
  endif
  return [struct, '}']
endfunction

" many options, but simple to visual select, enter, type char to align on, and bam
Plug 'junegunn/vim-easy-align'
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>

Plug 'chrisbra/csv.vim', { 'for': 'csv' }

"Plug 'Raimondi/delimitMate' " insert mode mgmt of closing quotes/parens/etc.
Plug 'jiangmiao/auto-pairs' " duplicates above?

Plug 'kana/vim-textobj-user' "prerequisite for other text object plugins
" ae, ie (around-elixir, inner-elixir) text objects
Plug 'andyl/vim-textobj-elixir'

" ar, ir (around-ruby, inner-ruby) text objects
Plug 'nelstrom/vim-textobj-rubyblock'
"required config
runtime macros/matchit.vim

" enhanced text objects
" Improves/expands targets of `i` in and `a` around textobjects
" some enhancements:
" `daa` "d around argument" will remove only one comma between args
" can use `n` next and `l` last prefix on textobject
" `b` is any block type
" `q` is any quote type
" my customization below defines
" `s` is any separator type
Plug 'wellle/targets.vim'
autocmd User targets#mappings#user call targets#mappings#extend({
    \ 's': { 'separator': [{'d':','}, {'d':'.'}, {'d':';'}, {'d':':'}, {'d':'+'}, {'d':'-'},
    \                      {'d':'='}, {'d':'~'}, {'d':'_'}, {'d':'*'}, {'d':'#'}, {'d':'/'},
    \                      {'d':'\'}, {'d':'|'}, {'d':'&'}, {'d':'$'}] }
    \ })
" customization to help with snake case words.
" Normally you'd need to `ca_` to change one portion of a snake cased word
" This lets you use `cas` (mnemonic s = separator) to change snake and other separators

" adds gS and gJ for syntax-aware splitting and joining
Plug 'AndrewRadev/splitjoin.vim'

Plug 'davidoc/taskpaper.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme= 'distinguished'
  " let g:airline_theme= 'solarized'
  " let g:airline_theme= 'luna'
  let g:bufferline_echo          = 0
  let g:airline_powerline_fonts  = 1
  let g:airline_enable_branch    = 1
  let g:airline_enable_syntastic = 1
  let g:airline_branch_prefix    = '⎇ '
  let g:airline_paste_symbol     = '∥'
  let g:airline#extensions#tabline#enabled = 0

" NOTE requires neovim compiled with ruby support
" Plug 'henrik/vim-yaml-flattener'
" shift-command-R (I think it is) that invokes it

" git/hg/mercurial/darcs/etc. diff indicators
" author says if you only use git, then gitgutter is better
" keeping this around just in case I use something other than git soon
" Plug 'mhinz/vim-signify'

" git-gutter only works with git, but allows hunk navigation and staging/unstaging
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_map_keys = 0
  let g:gitgutter_realtime = 1
  let g:gitgutter_eager = 1
  nmap <silent> ]h :GitGutterNextHunk<CR>
  nmap <silent> [h :GitGutterPrevHunk<CR>
  " I'm not using these and they interfere with ,h for tabprev
  " nmap <silent> <leader>hs <Plug>GitGutterStageHunk
  " nmap <silent> <leader>hu <Plug>GitGutterUndoHunk
  " nmap <silent> <leader>hp <Plug>GitGutterPreviewHunk

" fix bar/block cursor in tmux also FocusGained, FocusLost
" Plug 'sjl/vitality.vim'
" seems the above is obsolete in favor of
Plug 'tmux-plugins/vim-tmux-focus-events'

"no more need to do :set paste (or so it claims)
Plug 'ConradIrwin/vim-bracketed-paste'

" sequence diagrams rendered in browser
Plug 'xavierchow/vim-sequence-diagram'
  " generate sequence diagram
  nmap <leader>sq <Plug>GenerateDiagram
" let g:generate_diagram_theme_hand = 1

" Run tests with varying granularity
Plug 'janko-m/vim-test'
  nmap <silent> <leader>t :TestLast<CR>
  nmap <silent> <leader>tt :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  " there's a :TestVisit too, but doesn't seem useful now
  let g:test#strategy = 'neovim'

Plug 'Yggdroot/indentLine'
" we get a vertical pipe with setColors 0
" let g:indentLine_setColors = 0
" we get a very faint color with 239
" let g:indentLine_color_term = 239
let g:indentLine_color_term = 255
" TODO not sure how to get this configured yet
" saw it working once, kinda

" creates :Bclose to delete buffer without closing window
" I've mapped it to <leader>q to see if I like the workflow
Plug 'rbgrouleff/bclose.vim'
  " don't delete if we have the same buffer open in multiple windows
  let bclose_multiple = 0
  " don't use default mapping of <leader>bd
  let g:bclose_no_plugin_maps = 1
  nmap <silent> <leader>q :Bclose<CR>

call plug#end()

" Default color scheme
syntax enable
set background=dark
" set background=light
" colorscheme solarized
" colorscheme seoul256
colorscheme nova

let $MYTODO = '~/Dropbox/todo.taskpaper'

" if executable('ag')
"   set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
"   " if I include --hidden, I'll get back dot-files and rely on ~/.agignore
"   " instead of wildignore
"   set grepformat=%f:%l:%c:%m,%f:%l:%m
" endif

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" enable very magic regexes by default
nnoremap / /\v
vnoremap / /\v

" Navigation
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
nnoremap <Space> <PageDown>

" Navigate terminal with C-h,j,k,l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Use arrow keys to resize windows
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" emacs style ctrl-a and ctrl-e in insert mode for begin/end of line
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" buffer-specifics for QuickFix buffers
autocmd! FileType qf nnoremap <buffer><silent> q :cclose<CR>
autocmd! FileType qf nnoremap <buffer><silent> O <CR>:cclose<CR>
" TODO figure out general mapping for c-x, c-v, c-t
" or perhaps https://github.com/yssl/QFEnter
" autocmd! FileType qf nnoremap <buffer> <C-v> <C-w><Enter><C-w>L
" autocmd! FileType qf nnoremap <buffer> <C-x> <C-w><Enter>
" autocmd FileType qf nnoremap <buffer> <C-t> <C-W><Enter><C-W>T

" Map <Leader>e to glob path matching (**/)
" CamelCaseMotion interferes with <leader>e
" edit with glob match
nmap <Leader>e :e **/
cmap <Leader>e **/
" edit in vertical split with glob match
nmap <Leader>v :vsp **/
" edit in horizontal split with glob match
nmap <Leader>s :sp **/
" reloads all open windows
nnoremap <Leader>r :windo :e<CR>

" this one always opens in the window it was first launched from
" quick netrw browser
" nmap <Leader>b :20Lexplore<CR>
" this one opens in its own small window
" quick netrw browser
" nmap <Leader>b :20Vexplore<CR>

" <cr> in netrw will open file in previous window (except LExplore)
" let g:netrw_browse_split=4

" leave netrw buffers out of jumplist
let g:netrw_altfile = 1
" default to netrw tree view ('i' to cycle)
" P opens file in perviously focused window
" o opens file in new horizontal split
" v opens file in new vertical split
" t opens file in new tab
let g:netrw_liststyle=3
" use this percent size for 'o' or 'v' splits
let g:netrw_winsize = 75
" let g:netrw_alto = 1
" let g:netrw_altv = 1
" let g:netrw_browse_split = 4

" poor man's ZoomWin (doesn't restore)
" zoom to only this window
nmap <Leader><Leader> :only<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines above)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" re-select visually what was just pasted
nnoremap <leader>V V`]

" preserve cursor postion when yanking
" note the simple version (myy`y`) doesn't allow targeting buffer. The fancy one does
vnoremap <expr>y "my\"" . v:register . "y`y"

" xml pretty print
nmap <Leader>px :%!xmllint --format --recover -<CR>

" json pretty print
" nmap <Leader>pj :%!python -m json.tool<CR>
nnoremap <Leader>pj :%!jq '.'<CR>
vnoremap <Leader>pj !jq '.'<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Command mode: Ctrl+P inserts dir of current file
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Use modeline overrides
set nomodeline
" set modelines=10

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

" to save after opening a readonly file
cmap w!! w !sudo tee % >/dev/null

" pulse cursorline when FocusGained
" function! s:Pulse()
"   setlocal nocursorline
"   redraw
"   sleep 100m

"   setlocal cursorline
"   redraw
"   sleep 100m

"   setlocal nocursorline
"   redraw
"   sleep 100m

"   setlocal cursorline
"   redraw
" endfunction
"autocmd FocusGained * call s:Pulse()

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
" trim whitespace in file
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

" tab navigation maybe I'll use
nnoremap <leader>n :tabnew .<CR><C-P>
nnoremap <leader>h :tabprev<CR>
nnoremap <leader>l :tabnext<CR>
" interesting alternate idea, but not sure I'm ready to change
" nnoremap ]w gt
" nnoremap [w gT

" Delete all hidden buffers
nnoremap <silent> <Leader><BS>b :call DeleteHiddenBuffers()<CR>
function! DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction

" from: https://gist.github.com/aroben/d54d002269d9c39f0d5c89d910f7307e
" Put this in your .vimrc and whenever you `git commit` you'll see the diff of your commit next to your commit message.
" For the most accurate diffs, use `git config --global commit.verbose true`

" BufRead seems more appropriate here but for some reason the final `wincmd p` doesn't work if we do that.
" autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
" function! OpenCommitMessageDiff()
"   " Save the contents of the z register
"   let old_z = getreg("z")
"   let old_z_type = getregtype("z")

"   try
"     call cursor(1, 0)
"     let diff_start = search("^diff --git")
"     if diff_start == 0
"       " There's no diff in the commit message; generate our own.
"       let @z = system("git diff --cached -M -C")
"     else
"       " Yank diff from the bottom of the commit message into the z register
"       :.,$yank z
"       call cursor(1, 0)
"     endif

"     " Paste into a new buffer
"     vnew
"     normal! V"zP
"   finally
"     " Restore the z register
"     call setreg("z", old_z, old_z_type)
"   endtry

"   " Configure the buffer
"   set filetype=diff noswapfile nomodified readonly
"   silent file [Changes\ to\ be\ committed]

"   " Get back to the commit message
"   wincmd p
" endfunction

" debug syntax highlighting
" originally sourced from https://github.com/elixir-lang/vim-elixir/issues/229#issuecomment-265768856
map <leader>syn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
