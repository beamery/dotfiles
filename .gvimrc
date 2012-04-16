let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
	set gfn=Droid\ Sans\ Mono\ 10
	set guioptions-=m " turn off menu bar
	set guioptions-=T " turn off toolbar
	set guioptions-=L " turn off left scrollbar
	set guioptions-=l 
	set guioptions-=r
	set guioptions-=R

elseif os == "Darwin"

endif
