" Brian's .vimrc

set nocompatible  " don't want vi compatibility mode

let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
    " Google-specific stuff
    source /usr/share/vim/google/default.vim
    source /usr/share/vim/google/gtags.vim

    " GTags keymapping
    nnoremap <C-]> :exe 'let searchtag= "' . expand('<cword>') . '"' \| :exe 'let @/= "' . searchtag . '"'<CR> \| :exe 'Gtlist ' . searchtag <CR>
    nnoremap <C-]> :exe 'Gtlist ' . expand('<cword>')<CR>
    nnoremap ,cs :execute ":!google-chrome --new-window https://cs.corp.google.com\\#%:p:s?.*./google3/?google3/?\\&l=" . line('.')<CR> <CR>
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

call plug#end()

let mapleader=","

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
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=81
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd Filetype java setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=101
autocmd Filetype markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType text setlocal textwidth=80 shiftwidth=2 tabstop=2 softtabstop=2

syntax on           " enable syntax highlighting
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
vmap <Leader>c "+y
nmap <Leader>v "+p

"nmap <Leader>f :FufFile<CR>
"nmap <Leader>b :FufBuffer<CR>
"nmap <Leader>r :FufRenewCache<CR>
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
