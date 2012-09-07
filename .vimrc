" Brian's .vimrc

" OS specific stuff
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"

elseif os == "Darwin"

endif

silent! call pathogen#runtime_append_all_bundles()

filetype plugin indent on
let g:SuperTabDefaultCompletionType = "context"
let mapleader=","

" set vim options
set softtabstop=2
set shiftwidth=2
set foldmethod=syntax
" set textwidth=80
set foldlevelstart=20 " start folds unfolded
set scrolloff=5 " keep at least 5 lines around the cursor

" set filetype specific indentation
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType css setlocal shiftwidth=4 softtabstop=4

syntax on	  " enable syntax highlighting
set number	  " line numbers
set ruler	  " ruler in bottom right (row, col, percentage)
set nocompatible  " don't want vi compatibility mode
set showcmd       " show commands in the bottom line
set incsearch     " incremental search
set autochdir     " sync current dir with current file
set hl=l:Visual	  " use Visual Mode's highlighting for ease of reading
set hidden	  " allow switching between buffers without saving
set ignorecase	  " ignores case for search and replace
set smartcase	  " if capital letters in search, turn off ignore case
set wildmenu      " vim command completions show up in the status line
set wildmode=list:longest,full

" setup viminfo for saving sessions
set viminfo=%,'50,\"100,:100,n~/.viminfo

" custom key mappings
vmap <Tab> >gv
vmap <S-Tab> <gv
nmap <Leader>t :NERDTreeToggle<CR>
nmap <Leader>l :TlistToggle<CR>
nmap <Leader>f :FufFile<CR>
nmap <Leader>b :FufBuffer<CR>
nmap <Leader>n :noh<CR>
nmap <Tab> >>
nmap <S-Tab> <<
nmap ' `
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap j gj
nmap k gk
autocmd FileType python imap . .<Tab>

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
au BufWritePost *.cpp,*.h silent !ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .

" autobuild tags on writing .c, .h, .cpp
au BufWrite *.c,*.cpp,*.h silent! !ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

if has('gui_running')
	colorscheme molokai
	set cursorline " show line of cursor only in gvim
endif

" setup omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

set tags+=~/.vim/tags/cpp


" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" let OmniCpp_SelectFirstItem = 2

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Conque Shell custom settings
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CWInsert = 1

" Setup VimOrganizer
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org call org#SetOrgFileType()
