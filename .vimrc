" OS specific stuff
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"

elseif os == "Darwin"

endif

silent! call pathogen#runtime_append_all_bundles()

filetype plugin indent on
let g:SuperTabDefaultCompletionType = "context"
let mapleader=","

set number
set tabstop=4
set shiftwidth=4
set foldmethod=syntax
set foldlevelstart=20
set incsearch

" custom key mappings
vmap <Tab> >gv
vmap <S-Tab> <gv
nmap <Leader>w <C-w>
nmap <Leader>t :NERDTreeToggle<Enter>
nmap <Leader>f :FufFile<Enter>
nmap <Leader>b :FufBuffer<Enter>
nmap <Tab> >>
nmap <S-Tab> <<
nmap ' `
nmap <Leader>n :noh<Enter>

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

if has('gui_running')
	colorscheme wombat
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

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

