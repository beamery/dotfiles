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

  Glug clang-format plugin[mappings]="\\f"
  Glug piper plugin[mappings]
  Glug relatedfiles plugin[mappings]

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
Plug 'scrooloose/nerdtree'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neomake/neomake'
Plug 'morhetz/gruvbox'
"Plug 'vim-syntastic/syntastic'

call plug#end()

if os == "Linux"
  " Neomake
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
  " /Neomake
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

" set filetype specific indentation
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

syntax on           " enable syntax highlighting
colorscheme gruvbox
set number          " line numbers
set ruler           " ruler in bottom right (row, col, percentage)
"set showcmd        " show commands in the bottom line
set incsearch       " incremental search
"set autochdir       " sync current dir with current file
set hl=l:Visual	    " use Visual Mode's highlighting for ease of reading
set hidden	        " allow switching between buffers without saving
set ignorecase	    " ignores case for search and replace
set smartcase	    " if capital letters in search, turn off ignore case
set smartindent
set nohlsearch
"set wildmenu        " vim command completions show up in the status line
"set wildmode=list:longest,full

" custom key mappings
vmap <Tab> >gv
vmap <S-Tab> <gv

" FZF
" Insert mode completion
imap <c-k> <plug>(fzf-complete-word)
imap <c-f> <plug>(fzf-complete-path)
imap <c-j> <plug>(fzf-complete-file-ag)
imap <c-l> <plug>(fzf-complete-line)
nmap <Leader>f :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>a :Ag<Space>
nmap <Leader>t :NERDTreeToggle<CR>
nmap <Leader>n :NERDTreeFind<CR>

" OS clipboard copy/paste.
vmap <Leader>y "+y
nmap <Leader>v "+p

"nmap <Leader>f :FufFile<CR>
"nmap <Leader>b :FufBuffer<CR>
nmap <Leader>n :FufRenewCache<CR>
"nmap <Leader>n :noh<CR>
"nmap <Leader>t :NERDTreeToggle<CR>
"nmap <Tab> >>
"nmap <S-Tab> <<
nmap ' `
nmap <C-l> zz
nmap j gj
nmap k gk
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
