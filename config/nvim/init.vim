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
autocmd! BufWritePost $MYVIMRC source $MYVIMRC
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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
set number " line numbering
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

"visual indicator of end of edit area
set cpoptions+=$
"set virtualedit=onemore "see h 'virtualedit'

"lines above/below cursor
set scrolloff=5
" horizontal scroll per character with offset of 5
set sidescroll=1
set sidescrolloff=5

"intuitive locations of split windows
set splitbelow splitright
"allow virtual editing in visual block mode
set virtualedit=block
set diffopt=vertical "vertical diff splits

" fuzzier find with :find
set path+=**

" python stuff cargo culted from internet
let g:python_host_prog = '/Users/gvaughn/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/gvaughn/.pyenv/versions/neovim3/bin/python'

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

  " cross file regex search
  " FYI Ag is defined by fzf
  " still need to figure out global .agignore
  nnoremap <silent> g/ :Ag<CR>
  " search project for word under cursor
  nnoremap <silent> <leader>* :Ag <C-R><C-W><CR>
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
    execute 'Ag' selection
  endfunction

  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>gl :Commits<CR>
  nnoremap <leader>gh :BCommits<CR>
  nnoremap <leader>m :Maps<CR>

" try new ultimate searcher plugin
"   can't figure out how to use .agignore
" Plug 'mhinz/vim-grepper'
" nnoremap g/ :Grepper! -tool ag -open -switch -cword<cr>
" "xmap g/ <plug>(GrepperOperator)
" xnoremap g/ y:Grepper! -tool ag -open -switch -cword<cr>

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  " use tab for completion
  inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
  inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

" Polyglot loads language support on demand!
Plug 'sheerun/vim-polyglot'

" Execute code checks, find mistakes, in the background
Plug 'neomake/neomake'
  " Run Neomake when I save any buffer
  augroup localneomake
    autocmd! BufWritePost * Neomake
  augroup END
  " Don't tell me to use smartquotes in markdown ok?
  let g:neomake_markdown_enabled_makers = []

  " Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
  " seems to break phoenix autloading though -- using elixirc directly instead
  " of mix is rumored to work
  " let g:neomake_elixir_enabled_makers = ['mix', 'mycredo']
  " function! NeomakeCredoErrorType(entry)
  "   if a:entry.type ==# 'F'      " Refactoring opportunities
  "     let l:type = 'W'
  "   elseif a:entry.type ==# 'D'  " Software design suggestions
  "     let l:type = 'I'
  "   elseif a:entry.type ==# 'W'  " Warnings
  "     let l:type = 'W'
  "   elseif a:entry.type ==# 'R'  " Readability suggestions
  "     let l:type = 'I'
  "   elseif a:entry.type ==# 'C'  " Convention violation
  "     let l:type = 'W'
  "   else
  "     let l:type = 'M'           " Everything else is a message
  "   endif
  "   let a:entry.type = l:type
  " endfunction

  " let g:neomake_elixir_mycredo_maker = {
  "       \ 'exe': 'mix',
  "       \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
  "       \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
  "       \ 'postprocess': function('NeomakeCredoErrorType')
  "       \ }
  let g:neomake_elixir_enabled_makers = ['elixir']
  let g:neomake_elixir_elixir_maker = {
        \ 'exe': 'elixirc',
        \ 'args': [
          \ '--ignore-module-conflict', '--warnings-as-errors',
          \ '--app', 'mix', '--app', 'ex_unit',
          \ '-o', $TMPDIR, '%:p'
        \ ],
        \ 'errorformat':
            \ '%E** %s %f:%l: %m,' .
            \ '%W%f:%l'
        \ }

Plug 'ngmy/vim-rubocop'
let g:neomake_ruby_enabled_makers = ['rubocop', 'mri']

" Easily manage tags files
Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_cache_dir = '~/.tags_cache'

Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features
  augroup elixir
    au!
    au FileType elixir nn <buffer> <localleader>a :A<CR>
    au FileType elixir nn <buffer> <localleader>d :ExDoc<Space>
    au FileType elixir nn <buffer> <localleader>gc :Econtroller<Space>
    au FileType elixir nn <buffer> <localleader>gf :Econfig<Space>
    au FileType elixir nn <buffer> <localleader>gm :Emodel<Space>
    au FileType elixir nn <buffer> <localleader>gt :Etest<Space>
    au FileType elixir nn <buffer> <localleader>gr :Erouter<Space>
    au FileType elixir nn <buffer> <localleader>gv :Eview<Space>
    au FileType elixir nn <buffer> <localleader>gx :Echannel<Space>
    au FileType elixir nn <buffer> <localleader>i :IEx<CR>
    au FileType elixir nn <buffer> <localleader>pg :Pgenerate<Space>
    au FileType elixir nn <buffer> <localleader>pp :Ppreview<Space>
    au FileType elixir nn <buffer> <localleader>ps :Pgenerate<Space>
    au FileType elixir nn <buffer> <localleader>x :Mix<Space>
  augroup END

Plug 'slashmili/alchemist.vim' " elixir goodies
" heard about this, but saw bug report, so try later
" Plug 'andyl/vim-textobj-elixir'

Plug 'powerman/vim-plugin-AnsiEsc' "better ANSI sequence handling

Plug 'christoomey/vim-tmux-navigator'

" improve tmux integration with focus events
"Plug 'vim-scripts/Terminus'

Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'

" new motions
Plug 'tpope/vim-unimpaired'
" unimpaired Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv

Plug 'tpope/vim-surround'
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

" many options, but simple to visual select, enter, type char to align on, and bam
Plug 'junegunn/vim-easy-align'
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>

Plug 'chrisbra/csv.vim', { 'for': 'csv' }

"Plug 'Raimondi/delimitMate' " insert mode mgmt of closing quotes/parens/etc.
Plug 'jiangmiao/auto-pairs' " duplicates above?

Plug 'kana/vim-textobj-user' "prerequisite for other text object plugins

" ar, ir (around-ruby, inner-ruby) text objects
Plug 'nelstrom/vim-textobj-rubyblock'
"required config
runtime macros/matchit.vim

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

Plug 'henrik/vim-yaml-flattener'
" shift-command-R (I think it is) that invokes it

" CamelCaseMotion plugin offers text objects for camel or snake cased words
" use motions ,w ,b ,e (the comma is part of the object)
" Plug 'bkad/CamelCaseMotion' "doesn't appear to be working in neovim

" git/hg/mercurial/darcs/etc. diff indicators
" author says if you only use git, then gitgutter is better
" keeping this around just in case I use something other than git soon
" Plug 'mhinz/vim-signify'

" git-gutter only works with git, but allows hunk navigation and staging/unstaging
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_map_keys = 0
  " let g:gitgutter_max_signs = 200 "default 500
  let g:gitgutter_realtime = 1
  let g:gitgutter_eager = 1
  " let g:gitgutter_sign_removed = '–'
  " let g:gitgutter_diff_args = '--ignore-space-at-eol'
  nmap <silent> ]h :GitGutterNextHunk<CR>
  nmap <silent> [h :GitGutterPrevHunk<CR>
  nmap <silent> <leader>hs <Plug>GitGutterStageHunk
  nmap <silent> <leader>hu <Plug>GitGutterUndoHunk
  nmap <silent> <leader>hp <Plug>GitGutterPreviewHunk
  " force update is probably unnecessary
  " nnoremap <Leader>gt :GitGutterAll<CR>

" fix bar/block cursor in tmux also FocusGained, FocusLost
Plug 'sjl/vitality.vim'

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

call plug#end()

" Default color scheme
syntax enable
set background=dark
" colorscheme solarized
colorscheme seoul256

let $MYTODO = '~/Dropbox/todo.taskpaper'

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  " if I include --hidden, I'll get back dot-files and rely on ~/.agignore
  " instead of wildignore
  set grepformat=%f:%l:%c:%m,%f:%l:%m
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
set modeline
set modelines=10

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

" toggle relative numbering
nnoremap <silent> <F5> :set relativenumber!<CR>
" fancier version that also toggles number -- I'm not sure I like it
" nnoremap <silent> <F5> :exec &number == &relativenumber ? "set number!" : "set relativenumber!"<CR>

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
autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
function! OpenCommitMessageDiff()
  " Save the contents of the z register
  let old_z = getreg("z")
  let old_z_type = getregtype("z")

  try
    call cursor(1, 0)
    let diff_start = search("^diff --git")
    if diff_start == 0
      " There's no diff in the commit message; generate our own.
      let @z = system("git diff --cached -M -C")
    else
      " Yank diff from the bottom of the commit message into the z register
      :.,$yank z
      call cursor(1, 0)
    endif

    " Paste into a new buffer
    vnew
    normal! V"zP
  finally
    " Restore the z register
    call setreg("z", old_z, old_z_type)
  endtry

  " Configure the buffer
  set filetype=diff noswapfile nomodified readonly
  silent file [Changes\ to\ be\ committed]

  " Get back to the commit message
  wincmd p
endfunction

" debug syntax highlighting
" originally sourced from https://github.com/elixir-lang/vim-elixir/issues/229#issuecomment-265768856
map <leader>syn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
