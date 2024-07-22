syntax clear DirbufHash
syntax match DirbufHash /^#\x\{8}\t/ms=s-1 conceal cchar=#
setlocal conceallevel=2
setlocal concealcursor=n
