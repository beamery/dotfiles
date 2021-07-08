" Brian's .vimrc

set nocompatible  " don't want vi compatibility mode

let mapleader=","

let os = substitute(system('uname'), "\n", "", "")


" OS-specific stuff
"let os = substitute(system('uname'), "\n", "", "")
"if os == "Linux"
"
"elseif os == "Darwin"
"
"endif
"
call pathogen#infect()

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

Plug 'garbas/vim-snipmate'
let g:snipMate = { 'snippet_version' : 1 }

Plug 'vim-scripts/FuzzyFinder'
Plug 'leafgarland/typescript-vim'
Plug 'osyo-manga/vim-over'
cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Plug 'Shougo/unite.vim'
"Plug 'Shougo/vimproc.vim', { 'do': 'make'}

Plug 'neomake/neomake'
Plug 'morhetz/gruvbox'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" TODO: Set this back up.
"au User lsp_setup call lsp#register_server({
"    \ 'name': 'XXXXX Language Server',
"    \ 'cmd': {server_info->['']},
"    \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto'],
"    \})
"nnoremap gd :LspDefinition<CR>
"nnoremap gr :LspReferences<CR>

Plug 'mhinz/vim-signify'
let g:signify_sign_change = '~'
let g:signify_vcs_list = [ 'git', 'hg', 'perforce']
let g:signify_vcs_cmds = {
    \ 'git': 'git diff --no-color --no-ext-diff -U0 -- %f',
    \ 'hg': 'hg diff --config extensions.color=! --config defaults.diff= --nodates -U0 -r p4head -- %f',
    \ 'perforce': 'DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]'
    \ }

Plug 'tpope/vim-abolish'

nnoremap <leader>st :SignifyToggle<CR>
nnoremap <leader>sf :SignifyFold!<CR>
nnoremap <leader>sh :SignifyToggleHighlight<CR>
nnoremap <leader>sr :SignifyRefresh<CR>
nnoremap <leader>sd :SignifyDebug<CR>

call plug#end()

" -------------------- Neomake --------------------
autocmd! BufWritePost *.js,*.py,*.java Neomake

"let g:neomake_remove_invalid_entries = 1
let g:neomake_highlight_columns = 0

"let g:neomake_javascript_glint_maker = {
"    \ 'append_file': 0,
"    \ 'args': ['%'],
"    \ 'exe': 'TODO: JS linter',
"    \ 'errorformat': '%f:%l:%c: %tRROR - %m,%f:%l: %tRROR - %m,%f:%l:%c: %tARNING - %m,%f:%l: %tARNING - %m',
"    \ }
"let g:neomake_javascript_enabled_makers = ['TODO: JS linter']
"
"let g:neomake_python_gpylint_maker = {
"    \ 'args': ['--msg-template="{path}:{line}: ({symbol}): {msg}"'],
"    \ 'errorformat': '%f:%l: %m,',
"    \ }
"let g:neomake_python_enabled_makers = ['TODO: Python linter']
"
"let g:neomake_java_gcheckstyle_maker = {
"    \ 'exe': 'TODO: Java linter',
"    \ 'errorformat': '[%tARN] %f:%l:%m,Caused by: %f:%l:%m,%f:%l:%m',
"    \ }
"let g:neomake_java_enabled_makers = ['TODO: Java linter']

highlight NeomakeWarningMsg ctermfg=227 ctermbg=237
highlight NeomakeErrorMsg ctermfg=9 ctermbg=237
let g:neomake_warning_sign = {
  \ 'text': '●',
  \ 'texthl': 'NeomakeWarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '●',
  \ 'texthl': 'NeomakeErrorMsg',
  \ }
" //////////////////// Neomake ////////////////////

" -------------------- FZF --------------------

function! s:rec_handler(file)
  if a:file == 'enter' || a:file == 'tab' || a:file == '/'
    return
  elseif isdirectory(a:file) || a:file == 'ctrl-h'
    if a:file == 'ctrl-h'
      execute 'cd ..'
      execute 'FZFCustomFiles'
      call feedkeys('i')
    elseif a:file != './'
      execute 'cd '.a:file
      execute 'FZFCustomFiles'
      call feedkeys('i')
    endif
  else
    execute 'e '.a:file
  endif
endfunction

command! FZFCustomFiles call fzf#run({
  \ 'source': "ls -a1p",
  \ 'sink': function('<sid>rec_handler'),
  \ 'options': ['--prompt', pathshorten(getcwd()).'/', '--expect=enter,tab,ctrl-h,/'],
  \ 'down': '50%'
  \ })

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Pipe FZF results to quickfix.
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

" //////////////////// FZF ////////////////////


" set vim options
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
"set foldmethod=manual
"set textwidth=80
"set wrap linebreak textwidth=0
"set foldlevelstart=20 " start folds unfolded
set scrolloff=5 " keep at least 5 lines around the cursor
"set backspace=indent,eol,start

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Change directory on enter
autocmd! BufEnter * cd .

" set filetype specific indentation
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType c setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType python setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd Filetype java setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=101
autocmd Filetype markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType text setlocal textwidth=80 shiftwidth=2 tabstop=2 softtabstop=2

colorscheme gruvbox
set background=dark

syntax on           " enable syntax highlighting
set number          " line numbers
set ruler           " ruler in bottom right (row, col, percentage)
"set showcmd        " show commands in the bottom line
set incsearch       " incremental search
set autochdir       " sync current dir with current file
"set hl=l:Visual	    " use Visual Mode's highlighting for ease of reading
set hidden          " allow switching between buffers without saving
set ignorecase	    " ignores case for search and replace
set smartcase       " if capital letters in search, turn off ignore case
set smartindent
set hlsearch
set wildmenu
set wildmode=longest:full,full

" custom key mappings
vmap <Tab> >gv
vmap <S-Tab> <gv

" FZF
" Insert mode completion
imap <c-k> <plug>(fzf-complete-word)
imap <c-f> <plug>(fzf-complete-path)
imap <c-j> <plug>(fzf-complete-file-ag)
imap <c-l> <plug>(fzf-complete-line)
imap kj <Esc>
imap jk <Esc>
nmap <Leader>f :FZFCustomFiles<CR>
nmap <Leader>p :FZFPiperOpenFiles<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>a :Ag<Space>
nmap <Leader>j :Jade<CR>

vmap <Bslash>f :FormatLines<CR>

" OS clipboard copy/paste.
vmap <Leader>y "+y
nmap <Leader>v "+p

"nmap <Leader>n :FufRenewCache<CR>
"nmap <Leader>n :noh<CR>
nmap ' `
nmap j gj
nmap k gk
vmap j gj
vmap k gk
nmap H ^
nmap L $
nmap ]l :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>ll<bar>endtry<cr>
nmap [l :try<bar>lprev<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>ll<bar>endtry<cr>

let g:airline_powerline_fonts = 1

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Allow mouse scrolling
set mouse=a

filetype plugin indent on " Should be the last line in .vimrc
