" Brian's .vimrc

set nocompatible  " don't want vi compatibility mode

let mapleader=","

let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
  " Google-specific stuff
  source /usr/share/vim/google/google.vim
  source /usr/share/vim/google/gtags.vim

  Glug codefmt
  Glug codefmt-google

  Glug piper plugin[mappings]
  Glug relatedfiles plugin[mappings]
  Glug blaze plugin[mappings]='<leader>z'

  command Jade sp | term /google/data/ro/teams/jade/jade %

"  Glug glug sources+=/google/src/head/depot/google3/experimental/users/jkolb/vim
"  Glug simplegutter
"  " Add n or p to the map prefix to go the next or previous signgroup, or add l to view logs.
"  " Diff and lint autorun on save and load.
"  Glug sg_diff plugin[mappings]='cd'
"  Glug sg_lint plugin[mappings]='cx'
"
"  " Add b or t to the map prefix to build or test the current buffer.
"  " Note that auto_query=1 will blaze query every buffer ahead of time. I like this, but you might want to remove it.
"  Glug sg_blaze plugin[mappings]='z' auto_query=1

  " /Google
endif


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
Plug 'vim-scripts/FuzzyFinder'
Plug 'osyo-manga/vim-over'
cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'neomake/neomake'
Plug 'morhetz/gruvbox'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
au User lsp_setup call lsp#register_server({
    \ 'name': 'Kythe Language Server',
    \ 'cmd': {server_info->['/google/data/ro/teams/grok/tools/kythe_languageserver', '--google3']},
    \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto'],
    \})
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>

Plug 'mhinz/vim-signify'
let g:signify_sign_change = '~'
let g:signify_vcs_list = [ 'git', 'hg', 'perforce']
let g:signify_vcs_cmds = {
    \ 'git': 'git diff --no-color --no-ext-diff -U0 -- %f',
    \ 'hg': 'hg diff --config extensions.color=! --config defaults.diff= --nodates -U0 -r p4head -- %f',
    \ 'perforce': 'DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]'
    \ }

nnoremap <leader>st :SignifyToggle<CR>
nnoremap <leader>sf :SignifyFold!<CR>
nnoremap <leader>sh :SignifyToggleHighlight<CR>
nnoremap <leader>sr :SignifyRefresh<CR>
nnoremap <leader>sd :SignifyDebug<CR>

call plug#end()

if os == "Linux"
  " -------------------- Neomake --------------------
  autocmd! BufWritePost,BufEnter * Neomake

  "let g:neomake_remove_invalid_entries = 1
  let g:neomake_highlight_columns = 0

  let g:neomake_javascript_glint_maker = {
      \ 'append_file': 0,
      \ 'args': ['%'],
      \ 'exe': '/google/data/ro/teams/devtools/glint/linters/live/Linter_deploy.jar',
      \ 'errorformat': '%f:%l:%c: %tRROR - %m,%f:%l: %tRROR - %m,%f:%l:%c: %tARNING - %m,%f:%l: %tARNING - %m',
      \ }
  let g:neomake_javascript_enabled_makers = ['glint']

  let g:neomake_python_gpylint_maker = {
      \ 'args': ['--msg-template="{path}:{line}: ({symbol}): {msg}"'],
      \ 'errorformat': '%f:%l: %m,',
      \ }
  let g:neomake_python_enabled_makers = ['gpylint']

  let g:neomake_java_gcheckstyle_maker = {
      \ 'exe': '/home/build/google3/tools/java/checkstyle/gcheckstyle.sh',
      \ 'errorformat': '[%tARN] %f:%l:%m,Caused by: %f:%l:%m,%f:%l:%m',
      \ }
  let g:neomake_java_enabled_makers = ['gcheckstyle']

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
  if a:file == 'enter' || a:file == 'tab'
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
  \ 'options': ['--prompt', pathshorten(getcwd()).'/', '--expect=enter,tab,ctrl-h'],
  \ 'down': '50%'
  \ })

" //////////////////// FZF ////////////////////
endif


" set vim options
set softtabstop=4
set shiftwidth=4
set tabstop=4
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
autocmd BufWritePre * %s/\s\+$//e
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType c setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType python setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=81
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd Filetype java setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=101
autocmd Filetype markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType text setlocal textwidth=80 shiftwidth=2 tabstop=2 softtabstop=2
autocmd Filetype bzl AutoFormatBuffer buildifier

colorscheme gruvbox
set background=dark

syntax on           " enable syntax highlighting
set number          " line numbers
set ruler           " ruler in bottom right (row, col, percentage)
"set showcmd        " show commands in the bottom line
set incsearch       " incremental search
set autochdir       " sync current dir with current file
set hl=l:Visual	    " use Visual Mode's highlighting for ease of reading
set hidden          " allow switching between buffers without saving
set ignorecase	    " ignores case for search and replace
set smartcase       " if capital letters in search, turn off ignore case
set smartindent
set nohlsearch
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
nmap <Leader>t :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>a :Ag<Space>
nmap <Leader>j :Jade<CR>
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>nf :NERDTreeFind<CR>

vmap <Bslash>f :FormatLines<CR>

" OS clipboard copy/paste.
vmap <Leader>y "+y
nmap <Leader>v "+p

"nmap <Leader>f :FufFile<CR>
"nmap <Leader>b :FufBuffer<CR>
"nmap <Leader>n :FufRenewCache<CR>
"nmap <Leader>n :noh<CR>
"nmap <Tab> >>
"nmap <S-Tab> <<
nmap ' `
nmap j gj
nmap k gk
nmap H ^
nmap L $
nmap ]l :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>ll<bar>endtry<cr>
nmap [l :try<bar>lprev<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>ll<bar>endtry<cr>

function! VertDiffSplit(base)
    let l:path = system('path=' . expand('%:p') . ';echo ' . a:base . '${path#*/google3}')
    :exec 'vert diffsplit ' . l:path
endfunction

" Open file path under the cursor in a new tab
nmap gf :tabnew <cfile><cr>
" Diff current file with #head version
nmap gh :call VertDiffSplit('/google/src/head/depot/google3')<cr>
" Diff current file with version at sync point
nmap gs :call VertDiffSplit('/google/src/files/`srcfs get_readonly`/depot/google3')<cr>

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
