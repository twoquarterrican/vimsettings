function! Convert_to_body_text()
	" '<,>' is visual selection
	"if mode() == "v" | mode() == "V" | mode() == "\<C-V>"
		"let lnum1 = getpos("'<")[1]
		"let lnum2 = getpos("'>")[1]
	"else
		"let lnum1 = getpos(".")[1]
		"let lnum2 = lnum1
	"endif
	"let lnum1 = a:firstline
	"let lnum2 = a:lastline
	execute "normal 0i: "
endfunction

command! -range ToBodyText <line1>,<line2>call Convert_to_body_text()
map <buffer> ,tt :ToBodyText<CR>
