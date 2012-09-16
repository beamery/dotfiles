set guioptions-=m " turn off menu bar
set guioptions-=T " turn off toolbar
set guioptions-=L " turn off left scrollbar
set guioptions-=l 
set guioptions-=r
set guioptions-=R

let os = substitute(system('uname'), "\n", "", "")
" domain specific stuff
if os == "Linux"
    set gfn=Liberation\ Mono\ 11
elseif os == "Darwin"
    set gfn=Monaco:h12
endif

