" vim: foldmethod=marker

setlocal nuw=5

" vim-latex i.e. LaTeX-Suite {{{
if match(&rtp, 'vim-latex') 
	" TIP: if you write your \label's as \label{fig:something}, then if you
	" type in \ref{fig: and press <C-n> you will automatically cycle through
	" all the figure labels. Very useful!
	set iskeyword+=:
	"
	" If you wish to suspend the imaps functionality, set this to 1
	let g:Imap_FreezeImap=1

	" set pdf as compile format
	" PUT THIS IN AFTER/FTPLUGIN/TEX.VIM, NEED PLUGIN TO LOAD FIRST
	"TTarget pdf
	"TCTarget pdf
	"TVTarget pdf

	" the command to run when compiling to pdf
	let g:Tex_CompileRule_pdf='pdflatex --interaction=nonstopmode --synctex=1 $*'

	let g:Tex_MultipleCompileFormats="pdf"

	if filereadable(expand("$cvim/vimfiles/bundle/vim-latex/compiler/tex.vim"))
		source $cvim/vimfiles/bundle/vim-latex/compiler/tex.vim
	endif

	"from .../documentation/latex-suite/latex-completion.html
	set grepprg=\"C:/Program\ Files\ (x86)/GnuWin32/bin/grep\"\ -nH\ $*
endif

" }}}

" Latex-Box {{{
if match(&rtp, 'LaTeX-Box')
	let g:vim_program='C:/Program\ Files\ (x86)/vim/vim73/gvim.exe'
	let g:LatexBox_Folding=0
	setlocal foldmethod=marker
	setlocal foldtext=foldtext()
	setlocal foldmarker=<<<,>>>
	let g:LatexBox_show_warnings=0
endif
" }}}

" prefer neocomplcache to autocomplpop in tex files {{{
"if match(&rtp, 'autocomplpop')
	"AcpDisable
"endif
"if match(&rtp, 'neocomplcache')
	"NeoComplCacheEnable
	"if exists("g:defined_SetUp_neocomplcache_shortcuts")
		"call SetUp_neocomplcache_shortcuts()
	"endif
	"if exists("g:defined_SetUp_neosnippet_shortcuts")
		"call SetUp_neosnippet_shortcuts()
	"endif
"endif
"}}}

" old testing stuff {{{
""setlocal makeprg=start\ cmd\ /c\ \"latexmk\ -pvc\ -pdf\ 
			""\--interaction=nonstopmode\ --output-directory=$LATEXOUTPUT\ $*\"
""setlocal errorfile=$BACKUPDIR."/%<" 

"" use directory of tex file when ready to store on cloud
"command! LatexmkFinal execute '!start cmd /c "latexmk -pvc -pdf '
			"\.'--interaction=batchmode -synctex=1 '
			"\.'--aux-directory=\"'.$LATEXOUTPUT.'\" '
			"\.'--output-directory=\"'.expand("%:p:h").'\" \"%\" "'
"" use local directory when working on files
"let s:latexmk_command = '!cd \"'.expand("%:p:h").'\" && '
			"\.'latexmk -pvc -pdf '
			"\.'--interaction=batchmode -synctex=1 '
			"\.'--include-directory=\"'.expand("%:p:h").'\" '
			"\.'--aux-directory=\"'.$LATEXOUTPUT.'/tmp\" '
			"\.'--output-directory=\"'.$LATEXOUTPUT.'\" \"'.expand("%").'\" &'
"let s:latexmk_command_cmd = '!start cmd /k "cd \"%:p:h\" & ls & '
			"\.'latexmk -pvc -pdf '
			"\.'-interaction=nonstopmode -synctex=1 '
			"\.'\"%:p:t\" "'
"" in bash shell, 2 is stderr, 1 is stdout, 2>&1 redirects stderr to stdout
"" >&/dev/null sends output to black hole
"nnoremap <buffer> <Leader>ts :e!<bar>LatexTshoot<CR>
"let s:latexmk_command_bash = '!echo \"poop\" && sleep 25 && cd \"%:p:h\" '
			"\.'&& ls '
			"\.'> /cygdrive/c/Users/jthoma20/tmp/output.txt 2>&1 &&'
			"\.'latexmk -pvc -pdf '
			"\.'-interaction=nonstopmode -synctex=1 '
			"\.'\"%:p:t\" >&/dev/null && read -p \"aa\" && sleep 1m &"'
"let s:output_file = '/cygdrive/c/Users/jthoma20/tmp/output.txt'
"let s:latexmk_command_bash = '!echo \"now try it\" > /cygdrive/c/Users/jthoma20/tmp/output.txt'
"let s:latexmk_command_bash = '!echo \"what the heck? is it working?\" > '.s:output_file
""let s:latexmk_command_bash = '! pwd > '.s:output_file
			""\.' && echo \"pwd ran correctly\" >> '.s:output_file
			""\.' && echo \"%:p:h\" >> '.s:output_file
			""\.' && cd \"%:p:h\"'
			""\.' && pwd >> '.s:output_file
			""\.' && latexmk -pvc -pdf \"%:p:t\" &>> '.s:output_file
			""\.' &'
"let s:latexmk_command_bash = '! cd \"%:p:h\"'
			"\.' && latexmk -pvc -pdf '
			"\.'--interaction=batchmode -synctex=1 '
			"\.'--include-directory='.shellescape(expand("%:p:h")).' '
			"\.'--aux-directory=\"'.$LATEXOUTPUT.'/tmp\" '
			"\.'--output-directory=\"'.$LATEXOUTPUT.'\" \"'.expand("%").'\" '
			"\.'\"%:p:t\" &>'.s:output_file
""C:\Program Files (x86)\Git\bin\sh.exe" --login -i"
" }}} end old testing stuff

" LatexmkFinal and LatexmkWorking {{{
command! LatexmkFinal call Latexmk_compile(1)
command! LatexmkWorking call Latexmk_compile(0)
function! Latexmk_compile(final)
	execute 'cd %:p:h'
	"echom "running Latexmk command"
	"echomsg s:latexmk_command_bash
	let s:save_shellslash=&shellslash
	let s:save_shell=&shell
	let s:save_shellcmdflag=&shellcmdflag
	let s:save_shellxquote=&shellxquote
	set shellslash
	"set shell=\"/c/Program\\\ Files\\\ (x86)/Git/bin/sh.exe\"
	"set shell=\"C:/Program^\ Files^\ \(x86\)/Git/bin/sh.exe"
	"set shell=C:/cygwin/bin/bash
	set shell=cmd.exe
	"set shellcmdflag=--login\ -i
	"set shellxquote=\"
	"set shellcmdflag=--login\ -c
	set shellxquote=(
	set shellcmdflag=/c
	let s:latexmk_command_cmd='latexmk -pvc -pdf'
				\.' -synctex=1'
				\.' --interaction=batchmode'
	" insert option ' -diagnostics' when latexmk not working correctly
	if(a:final)
		let s:latexmk_command_cmd.=' --aux-directory='.$LATEXOUTPUT.'/ '
		let s:working=0
	else
		let s:latexmk_command_cmd.=' --output-directory='.$LATEXOUTPUT.'/ '
		let s:working=1
	endif
	let s:latexmk_command_cmd.='%'
	silent execute 'cd %:p:h'
	silent execute '! start '.s:latexmk_command_cmd
	"echom s:latexmk_command_cmd
	let &shellslash=s:save_shellslash
	let &shell=s:save_shell
	let &shellcmdflag=s:save_shellcmdflag
	let &shellxquote=s:save_shellxquote
	unlet s:save_shellslash
	unlet s:save_shell
	unlet s:save_shellcmdflag
	unlet s:save_shellxquote
endfunction

command! Lerr execute 'cfile '.$LATEXOUTPUT.'/'.expand("%:p:t:r").'.log'

" }}} end LatexmkFinal and LatexmkWorking

" tuning neocomplcache {{{
"let g:neocomplcache_omni_functions.tex = 'Complete_equation_reference'
"let g:neocomplcache_omni_patterns.tex = 'ref'
let g:neocomplcache_omni_function_list = {}
let g:neocomplcache_omni_function_list.tex = 'Complete_equation_reference'

function! Complete_equation_reference(findstart, base)
	"echom "called my completion function"
	"if a:findstart
		"return(col('.'))
	"endif
	"return ['blue', 'green']
endfunction
"}}}

" old: partial latex-box features {{{
"stolen from latex-box, i like the interface with latexmk, but I don't like
"that Latexbox seems to make vim hang every now and then
"if exists('*fnameescape')
	"function! s:FNameEscape(s)
		"return fnameescape(a:s)
	"endfunction
"else
	"function! s:FNameEscape(s)
		"return a:s
	"endfunction
"endif

"let prefix = expand('<sfile>:p:h') . '/latex-box/'
""latexmk.vim needs common.com
"execute 'source ' . s:FNameEscape(prefix . 'common.vim')
"execute 'source ' . s:FNameEscape(prefix . 'latexmk.vim')
"}}}

" format options foldexpr, etc {{{
"automatic formatting
setlocal formatoptions+=a
"w option means the end of a paragraph is signalled by lack of whitespace
"at the end of a line.  This way, if you do not leave whitespace at the end
"of the line, then auto formating with gq will not join the two lines
setlocal formatoptions+=w
" folding markers
setlocal foldmarker=<<<,>>>
setlocal foldmethod=marker
let b:delimitMate_matchpairs = "(:),[:],{:},<:>,\\langle:\\rangle,$:$"

let maplocalleader=","
"uncomment line below to disable
"uncomment line below to enable
"setlocal formatexpr=TeX_fmt()

"below, we set formatexpr=TeX_fmt(), the function just below.
"By default, formatexpr="", and when gq is called or any paragraph is
"edited when formatoptions includes the 'a' flag,
"vim runs its standard formatting procedure.  This does not work so 
"well with the way I Like TeX to be formatted.  For example, vim will 
"put \[ on the end of the previous line, but I always like to see 
"these on their own lines
"This function is a wrapper for gq:
"If you run gq while you have a selection in visual mode, then
"gq only formats that selection.  This function highlights what we 
"want vim to edit, then runs gq. The result is that vim only edits
"what we tell it to.  
"However, gq only uses the standard vim formatting procedure if
"formatexpr="".  this is fine if we only do manual formatting, but 
"if we want to do automatic formatting (i.e. fo has 'a' flag) then
"we need to set formatexpr.  The fancy way to do it is to parse and
"format everything using some nice vimscript, but we are not doing 
"it that way here.  Of course, to avoid an infinite loop, we need to
"put formatexpr="" before we call gq in the function, or else the 
"function is calling itself with no way to end it.
"to prevent infinite loops while testing:
let g:jtn=1
fun! TeX_fmt()
	let g:jtn = g:jtn + 1
	if (g:jtn > 10)
		if (g:jtn == 11)
			echom "g:jtn=". g:jtn . " is over limit, ran too many times, exiting"
		endif
		let abc = confirm("texfmt no longer running")
		return
	endif
	echom "-------top----of----TeX_fmt()------"
	setlocal formatexpr=""
	"echom "now formatexpr is empty"
   	if (getline(".") != "")
		"echom "starting formatting"
		let save_cursor = getpos(".")
		"echom "got cursor position"
		let op_wrapscan = &wrapscan
		"echom "stored wrapscan option"
		set nowrapscan
		"echom "turned off wrapscan
		let par_begin = '^\(%D\)\=\s*\($\|\\begin\|\\end\|'
					\.'\\\[\|\\\]\|\\\(sub\)*section\>\|'
					\.'\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
		echom "defined start of paragraph search
		let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|'
					\.'\\\[\|\\\]\|\\place\|\\\(sub\)*section\>\|'
					\.'\\item\>\|\\NC\>\|\\blank\>\)'
		echom "defined end of paragraph search
		try
			" search for the first line of the paragraph
			exe '?'.par_begin.'?+'
			"echom "searching for beginning of paragraph"
		catch /E384/
			1
			"echom "could not find beginning of paragraph"
		endtry
		" go into visual mode to highlight a group of lines
		norm V
		"echom "now in visual mode"
		try
			" find the last line of the paragraph, this will also
			" visually select everything from first line to here
			exe '/'.par_end.'/-'
			"echom "trying to find paragraph end"
		catch /E385/
			" go to end of current line if paragraph end expression was not 
			" found
			$
			"echom "could not find paragraph end"
		endtry
		norm! gq
		let &wrapscan = op_wrapscan
		call setpos('.', save_cursor)
	endif
	setlocal formatexpr=TeX_fmt()
	let l:line = getline('.')
	let l:column = col('.')
	echom "nearby text is: " . l:line[l:column - 2 : l:column+2]
	echom "------bottom---of--TeX_fmt()------"
endfun

"nmap gq :call TeX_fmt()<CR>
"" }
"}}}

" common misspellings {{{
iabbr ldtos ldots
iabbr cdtos cdots
iabbr gamm gamma
"}}}

" WinEdt styl environment closing {{{
fun! Auto_close_env()
	"echom "---top of autocloseenv()---"
	let save_cursor = getpos(".")
	let begin_env_search_exp = 'begin'
	execute '?'.begin_env_search_exp
	let begin_env = getline(".")
	let left = match(begin_env, '{')
	"echom left
	let right = match(begin_env, '}')
	"echom right
	let begin_env = begin_env[left : right]
	call setpos('.', l:save_cursor)
	execute "normal! a".begin_env
	"call append(line('.'), [begin_env])
	"echom "----bottom of autoclosenve()---"
endf
inoremap <buffer> <C-[><C-[> <Esc>:call Auto_close_env()<CR>a
"}}}

" swiss cheese special options {{{
" only set swiss cheese auto commands for this buffer if it has 
" 'swiss cheese' somewhere in the first three lines
for i in range(3)
	"echom 'searching line '.i+1.' for \"swiss cheese\" '
	if getline(i+1) =~ 'swiss cheese'
		augroup swiss_cheese
			autocmd!
			autocmd BufWritePre <buffer>
						\ call Swiss_cheese_replacements()
		augroup END
		" no need to check more lines
		break
	endif
endfor

"the list of search and replace commands I want
let s:search_and_repl_commands = [
			\'%s/en-1p/E_{n-1}\plus/g',
			\'%s/en-1/E_{n-1}/g',
			\'%s/scn/\\swcheese{n}/g',
			\'%s/en/E_{n}/g']
let s:search_and_repl_lists = [
			\['en-1p','E_{n-1}\\plus'],
			\['en-1','E_{n-1}'],
			\['scn','\\swcheese{n}'],
			\['en','E_n']
			\]

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let s:troubleshooting=0+0
" the function to iterate through the list of search and replace commands
function! Swiss_cheese_replacements()
	
	" store the cursor position so we can put it back where we found it
	let save_cursor = getpos(".")
	" iterate over the commands in the list defined above
	for l:search_and_repl in s:search_and_repl_lists
		" start at the beginning of the file. see help setpos for explanation of
		" the arguments
		call setpos('.', [0,1,1,0])
		"echomsg "searching for ".l:search_and_repl[0]
		while 1
			" cursor moves, but does not wrap around because flags has 
			" no 'n' but does have 'W', this means this while loop will
			" eventually terminate, since it is set to break when the 
			" search fails
			" 'e' flag moves cursor to the end of the match, will use this
			" cursor position below to see if an alphabetic character is 
			" on the right side of the match
			" 'c' flag means accept a match at cursor position.
			" The first search finds the left side of the search term, the
			" second search finds the right side.  It is necessary to let the
			" second search find a match under the cursor so that we are
			" matchin the left and right sides of the same result
			let [llnum, lcol] = searchpos(l:search_and_repl[0], 'W')
			let [rlnum, rcol] = searchpos(l:search_and_repl[0], 'ceW')
			" use block when working to prevent infinite loops
			if(s:troubleshooting)
				if(exists("s:count_loops") == 0)
					let s:count_loops = 0
				endif
				let s:count_loops += 1
				if(s:count_loops%500 == 0)
					if confirm("continue", "yes\nno\nno way") > 1+0
						break
					endif
					let s:count_loops = 0
				endif
			endif
			" end of troubleshooting block
			" this is the 'halfway' mark of the loop-and-a-half,
			" the sentinel at which we stop.  lnum=0 means the search term was
			" not found
			if (rlnum == 0+0) || (llnum==0)
				break
			endif
			let lline = getline(llnum)
			let rline = getline(rlnum)
			"echomsg "line = \"".line."\""
			"echomsg "[lnum, col] = [".lnum.", ".col."]"
			" let lcol be 2 at minimum
			if (lcol<=1)
				let lcol=2
			endif
			" let rcol be last position in rline at maximum
			if (rcol >= len(rline))
				let rcol = len(rline)-1
			endif
			" see if we have alphabetic characters to the right or to the left
			" of the search term.  If so, skip this search result
			if (lline[lcol-2] =~ '[a-zA-Z]') || (rline[rcol] =~ '[a-zA-Z]')
				continue
			endif
			" The reason for ensuring that lcol >= 2 and rcol <= len(rline) - 1
			" is that we want lline[:lcol-2] to be empty when lcol is 1.
			" However, lline[:-1] is the whole string lline, so if lcol is 1,
			" we should replace it with 2, so that llcol[:lcol-2] = llcol[:0],
			" which is empty
			let lpart = lline[:lcol-2]
			if(llnum == rlnum)
				let mpart=lline[lcol-1:rcol-1]
			else
				let mpart = lline[:lcol-1].rline[:rcol-1]
			endif
			let rpart = rline[rcol :]
			let mpart = substitute(mpart, l:search_and_repl[0],
						\l:search_and_repl[1], "")
			"echom "new line = ".lpart.mpart.rpart
			call setline(llnum, lpart.mpart.rpart)
			if(llnum != rlnum)
				setline(rlnum, "")
			endif

			

			"let part_line = substitute(part_line, l:search_and_repl[0],
							""\l:search_and_repl[1], "")
			"echomsg "len(line) = ".len(line)
			"echomsg line[col(".")]." = current character"
			"echomsg col(".")." = current col"
			"echomsg line(".")." = current line"
			"if (col == 1) && (line[
			" this gives the name of the syntax group for the search term we found
			"let syntax_group = synIDattr(synID(lnum,col,1),"name")
			"" only do the substitution if we are inside a math expression
			"if syntax_group =~ 'texMathZone'
				"echomsg "found syntax_group = ".syntax_group
				"echomsg "found texMathZone item at ".lnum.", ".col
				"" leave off the part of the line before the search term
				"let line = getline(lnum)
				"let part_line = getline(lnum)[col-1:]
				"echomsg "before substitute, line is ".line
				"let part_line = substitute(part_line, l:search_and_repl[0],
							"\l:search_and_repl[1], "")
				"if (col == 1) 
					"let line = part_line
				"else
					"let line = line[0:col-2].part_line
				"endif
				"call setline(lnum, line)	
				"echomsg "after substitute line is ".line
			"else
				"echomsg lnum.", ".col." is normal text"
			"endif
			
		endwhile
	endfor
	" select all with ggVG, then format with gq
	"normal ggVG
	"normal gq
	" turn off the search highlighting, it is distracting
	" nohlsearch
	" restor cursor to original position
	call setpos('.', save_cursor)
endfunction

" }}} end swiss cheese special options

" testing {{{
function! Tester()
	let thecommand="!\"C:/Program\ Files\ (x86)/vim/vim73/gvim.exe\""
	execute thecommand
endfunction
nmap <buffer> <S-r> <Esc>:e! <bar> call Tester()<CR>
"}}}

" Reformat tex file making sure comments are not broken {{{
let s:troubleshooting=0+0
" the function to iterate through the list of search and replace commands
function! Reformat_nicely()
	" store the cursor position so we can put it back where we found it
	let save_cursor = getpos(".")
	" start at the beginning of the file. see help setpos for explanation of
	" the arguments
	call setpos('.', [0,1,1,0])
	while 1
		" cursor moves, but does not wrap around because flags has 
		" no 'n' but does have 'W', this means this while loop will
		" eventually terminate, since it is set to break when the 
		" search fails
		" 'e' flag moves cursor to the end of the match, will use this
		" cursor position below to see if an alphabetic character is 
		" on the right side of the match
		" 'c' flag means accept a match at cursor position.
		" The first search finds the left side of the search term, the
		" second search finds the right side.  It is necessary to let the
		" second search find a match under the cursor so that we are
		" matchin the left and right sides of the same result
		let [llnum, lcol] = searchpos(l:search_and_repl[0], 'W')
		let [rlnum, rcol] = searchpos(l:search_and_repl[0], 'ceW')
		" use block when working to prevent infinite loops
		if(s:troubleshooting)
			if(exists("s:count_loops") == 0)
				let s:count_loops = 0
			endif
			let s:count_loops += 1
			if(s:count_loops%500 == 0)
				if confirm("continue", "yes\nno\nno way") > 1+0
					break
				endif
				let s:count_loops = 0
			endif
			endif
			" end of troubleshooting block
			" this is the 'halfway' mark of the loop-and-a-half,
			" the sentinel at which we stop.  lnum=0 means the search term was
			" not found
			if (rlnum == 0+0) || (llnum==0)
				break
			endif
			let lline = getline(llnum)
			let rline = getline(rlnum)
			"echomsg "line = \"".line."\""
			"echomsg "[lnum, col] = [".lnum.", ".col."]"
			" let lcol be 2 at minimum
			if (lcol<=1)
				let lcol=2
			endif
			" let rcol be last position in rline at maximum
			if (rcol >= len(rline))
				let rcol = len(rline)-1
			endif
			" see if we have alphabetic characters to the right or to the left
			" of the search term.  If so, skip this search result
			if (lline[lcol-2] =~ '[a-zA-Z]') || (rline[rcol] =~ '[a-zA-Z]')
				continue
			endif
			" The reason for ensuring that lcol >= 2 and rcol <= len(rline) - 1
			" is that we want lline[:lcol-2] to be empty when lcol is 1.
			" However, lline[:-1] is the whole string lline, so if lcol is 1,
			" we should replace it with 2, so that llcol[:lcol-2] = llcol[:0],
			" which is empty
			let lpart = lline[:lcol-2]
			if(llnum == rlnum)
				let mpart=lline[lcol-1:rcol-1]
			else
				let mpart = lline[:lcol-1].rline[:rcol-1]
			endif
			let rpart = rline[rcol :]
			let mpart = substitute(mpart, l:search_and_repl[0],
						\l:search_and_repl[1], "")
			"echom "new line = ".lpart.mpart.rpart
			call setline(llnum, lpart.mpart.rpart)
			if(llnum != rlnum)
				setline(rlnum, "")
			endif

			

			"let part_line = substitute(part_line, l:search_and_repl[0],
							""\l:search_and_repl[1], "")
			"echomsg "len(line) = ".len(line)
			"echomsg line[col(".")]." = current character"
			"echomsg col(".")." = current col"
			"echomsg line(".")." = current line"
			"if (col == 1) && (line[
			" this gives the name of the syntax group for the search term we found
			"let syntax_group = synIDattr(synID(lnum,col,1),"name")
			"" only do the substitution if we are inside a math expression
			"if syntax_group =~ 'texMathZone'
				"echomsg "found syntax_group = ".syntax_group
				"echomsg "found texMathZone item at ".lnum.", ".col
				"" leave off the part of the line before the search term
				"let line = getline(lnum)
				"let part_line = getline(lnum)[col-1:]
				"echomsg "before substitute, line is ".line
				"let part_line = substitute(part_line, l:search_and_repl[0],
							"\l:search_and_repl[1], "")
				"if (col == 1) 
					"let line = part_line
				"else
					"let line = line[0:col-2].part_line
				"endif
				"call setline(lnum, line)	
				"echomsg "after substitute line is ".line
			"else
				"echomsg lnum.", ".col." is normal text"
			"endif
			
		endwhile
	endfor
	" select all with ggVG, then format with gq
	"normal ggVG
	"normal gq
	" turn off the search highlighting, it is distracting
	" nohlsearch
	" restor cursor to original position
	call setpos('.', save_cursor)
endfunction
 
" }}}
