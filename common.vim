" Modeline and Notes {{{
" vim: set foldmethod=marker :
"
" This file is inspired by spf13.vim
"
" must define $BACKUPDIR and $cvim in .vimrc before sourcing this file
"
" Typical Use of this file: on each computer's $MYVIMRC file, put
" let $cvim="path/to/directory/containing/this/file"
" and then 
" source $cvim/common.vim
" }}}

" pathogen or vundle? {{{
  let s:using_pathogen = 0
	let s:using_vundle = 1 - s:using_pathogen
" }}}

" pathogen {{{
if s:using_pathogen
	source $cvim/vimfiles/bundle/vim-pathogen-master/autoload/pathogen.vim
	execute pathogen#infect()
	call pathogen#helptags()
endif
"}}}

" gmarik/vundle {{{
if s:using_vundle==1
  set nocompatible
	command! -bang BundleInstallWin call Shellslash_off('BundleInstall<bang>')
	command! -bang BundleCleanWin call Shellslash_off('BundleInstall<bang>')
	function! Shellslash_off(code)
		let sav_shellslash = &shellslash
		set noshellslash
		execute a:code
		" BundleInstall
		let &shellslash = sav_shellslash
		unlet sav_shellslash
	endf
	filetype off

	set rtp+=$cvim/vimfiles/bundle/vundle
	call vundle#rc()
	
	" snippets
	Bundle 'UltiSnips'

	" let vundle manage vundle
	Bundle 'gmarik/vundle'

	" Debugger for vim scripts
	" Bundle 'Decho'

	" <Leader>ig to toggle indent guides
	Bundle 'nathanaelkane/vim-indent-guides'

	" AutoComplPop is on bitbucket'
	" Bundle 'AutoComplPop'

	" automatically insert other delimiter
	Bundle 'Raimondi/delimitMate'

	" full path fuzzy finder for files, buffers, mru, tags
	Bundle 'kien/ctrlp.vim'

	" file tree viewer
	Bundle 'scrooloose/nerdtree'

	" A vim-script library
	Bundle 'L9'

	" autocompletion
	"'shougo/neocomplcache'

	" snippet autocomplete for use with neocomplcache
	"'shougo/neosnippet'

	" easy commenting
	"'scrooloose/nerdcommenter'
	Bundle 'tomtom/tcomment_vim'

	" relative line numbers
	Bundle 'myusuf3/numbers.vim'

	" an amalgamation of crap tpope uses for editing runtime files
	Bundle 'tpope/vim-scriptease'

	" tab completion
	" Bundle 'ervandew/supertab'

	" coffee script support
	Bundle 'kchmck/vim-coffee-script'

	" beautiful colors
	Bundle 'altercation/vim-colors-solarized'

	" <Leader><Leader>f then <character> finds all occurences in front
	Bundle 'Lokaltog/vim-easymotion'

	" tpope's Git support for vim
	Bundle 'tpope/vim-fugitive'

	" the huge latex plugin for vim.  jcf has up-to-date mirror
	Bundle 'jcf/vim-latex'
	"this does not work for some reason
	"Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex (read-only)'

	" otl files
	Bundle 'vimoutliner/vimoutliner'

	" tpope again
	Bundle 'tpope/vim-rails'
	Bundle 'tpope/vim-surround'
	
	" my wrapper around vimtweaks
	Bundle 'twoquarterrican/vim-transparency'

	" checking coffee-script files and other things as well
	Bundle 'scrooloose/syntastic'

	" supposedly usurps all functionality of acp, supertab and NeoComplCache
	Bundle 'Valloric/YouCompleteMe'
endif

" }}} vundle configuration

" check that variables are defined {{{
if !(exists("$BACKUPDIR"))
	echoerr("please define environment variable $BACKUPDIR in .vimrc")
endif

if !(exists("$LATEXOUTPUT"))
	echoerr("please define environment variable $LATEXOUTPUT in .vimrc")
endif
" }}}

" Filetype, nocompatible, etc. {{{
set nocompatible | filetype indent plugin on | syn on
set ignorecase
let mapleader=","
set tabstop=2
set shiftwidth=2
set wildignore+=*.jpg
"}}}

" backup and history (set $BACKUPDIR in .vimrc) {{{
set backupdir=$BACKUPDIR
set nobackup
set history=1000
" locations for swap files, in order of preference
set directory=~/tmp/swap
"}}}

" User interface {{{

imap <Leader>c <Esc>bg~wea

" always set the local directory to be the directory of the current file
autocmd BufEnter * execute 'lcd %:p:h'

"completion in the command line: first tab hit will complete as much as
"possible, the second tab hit will provide a list, the third and subsequent
"tabs will cycle through completion options
set wildmode=longest,list,full
set wildmenu

" complete options
set completeopt=longest,menuone

"backspace behaves as in other programs
set backspace=eol,start,indent

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" jump straight to the bottom when viewing messages
set nomore

" Set the forward slash for filename separator-ness
set shellslash

" Window Position, size, guioptions, ruler, etc. {{{
set sessionoptions+=winpos

"set lines=80 columns=85
" no scrollbars
set guioptions-=L
set guioptions-=l
set guioptions-=R
set guioptions-=r
set guioptions-=b
set guioptions-=h

" ascii tab titles keep vime from resizing window every time I open a
" new tab
set guioptions-=e

" no toolbar
set guioptions-=T

set ruler
" The vertical line numbers on the left (numbers plugin) {{{
nnoremap <Leader>nu :NumbersToggle<CR>
"}}}

" move the screen more when scrolling off the page
set scrolloff=2
" amount to umjq
set scrolljump=5
" highlight search terms
set hlsearch
" unhighlight current search terms
nmap <Leader>nh :nohlsearch<CR>
" update on partial searches
set incsearch
" wrap around the end of the file, treat the file as S^1 for the purposes of
" search
set wrapscan

" no ding
set noerrorbells
set novisualbell

" Color {{{
	syntax enable
	set background=dark

	colorscheme solarized
	if has("gui")
		"solarized is nice, blueish background, easy to read
		"desert is pleasant too
		color desert
	endif
"}}}

"}}}
"}}}

" Abbreviations and mappings not specific to any plugin {{{
iabbr wiht with

" go back to previous buffer
nnoremap gb :e#<CR>

au FileType eruby,ruby  setlocal nowrap foldmethod=syntax foldlevel=1

"}}}

" <Leader> {{{
let mapleader=","
" }}}

" runtimepath {{{
" trying to discourage myself from dropping settings into the home folder
" or in vim's default local settings folder $VIM/vimfiles
" only want to put settings into the common vim folder
"set rtp-=~/vimfiles
"set rtp-=~/vimfiles/after
"set rtp-=$VIM/vimfiles
"set rtp-=$VIM/vimfiles/after
" now tell vim the location of my local settings files
" Note: $cvim should be set on each local machine
set rtp+=$cvim/vimfiles
set rtp+=$cvim/vimfiles/after
" troubleshooting: line below shows a popup with current state of rtp
" let abc=confirm("just set rtp to ".&rtp)
"}}}

" LaTeX {{{
" this setting is native to vim, but the vim-latex plugin does not seem to
" work without it
let g:tex_flavor='latex'
" }}}

" Font {{{
if has("gui")
	"Andale_Mono:h10 does not seem to work
	"Meno:h15 does not seem to work
	set guifont=Consolas:h12
	",Courier_New:h18
endif

"set uft8 as standard encoding and en_US as the standard language
set encoding=utf8
" }}}

" Tabs {{{
" Just found out I can use gt to go to the next tab and gT to go to the
" previous tab.  <S-h> and <S-l> take you to the top and bottom of the file
" respectively, so I will leave those alone
"nmap <S-h> :tabprevious<CR>
"nmap <S-l> :tabnext<CR>
"}}}

" Plugins {{{

" easymotion {{{
" search the whole screen
if match(&rtp, 'easymotion')
	function! EasymotionWholeScreen()
		let save_scrolloff = &scrolloff
		set scrolloff=0
		normal H0
		call EasyMotion#F(0,0)
		let &scrolloff = save_scrolloff
	endfunction
endif
nmap <Leader>f :call EasymotionWholeScreen()<CR>
" }}}

" savevers (not managed by pathogen) {{{
" Note: backup and backupdir set above for vim, want savevers to use the same
let savevers_dirs=&backupdir

" a vim option, but savevers won't work unless patchmode is set
set patchmode=.clean
let savevers_max=99

" copied these settings from savevers script web site
execute "set backupskip+=*" . &patchmode
execute "set suffixes+=" . &patchmode
execute "set wildignore+=*" . &patchmode
" }}}

" vim-latex or LaTeX-Box {{{

" to disable latex-box, set b:LatexBox_loaded equal to 1
"let g:LatexBox_loaded=1

" comma at beginning of list prepends these environments to the defaults
if &rtp =~ "vim-latex"
	let g:Tex_FoldedEnvironments=',theorem,remark,definition,lemma,'
			\.'proposition,proof,notation,example'
	let g:Tex_ViewRule_pdf = 'C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe'
" configure compiler {{{
" Do not use latexmk with vim-latex.  I can't figure out how to let it run in
" the background.  In ~/SkyDrive/vimsettings/vimfiles/after/ftplugin/tex.vim I
" have overridden the \ll command to run latexmk properly
"let g:Tex_CompileRule_pdf='start latexmk -pvc -pdf --interaction=nonstopmode'
			"\.'$* & pause'
"}}}
endif

if &rtp =~ "LaTeX-Box"
	let g:vim_program=shellescape($VIMRUNTIME.'/gvim.exe')
	let g:LatexBox_Folding=1
	let g:LatexBox_fold_envs=1
	let g:LatexBox_latexmk_options="-pvc --interaction=nonstopmode"
				\." --output-directory=$LATEXOUTPUT"
	let g:LatexBox_output_type="pdf"
	let g:LatexBox_viewer="C:/Program\ Files\ (x86)/SumatraPDF/SumatraPDF.exe --reuse-instance"
endif
"}}} vim-latex or LaTeX-Box

" NerdTree {{{
        map <C-e> :NERDTreeToggle<CR>
        "map <Leader>e :NERDTreeFind<CR>
        nmap <Leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git',
					\'\.hg', '\.svn', '\.bzr', '\.$']
        let NERDTreeChDirMode=1
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }}}

" CtrlP {{{

let g:ctrlp_working_path_mode = 'ra'
nmap <Leader>mr :CtrlPMRU<CR>
nmap <Leader>p :CtrlP<CR>
" Control-Zero waits for you to enter a directory
nmap <C-0> :CtrlP 
" Control-Y opens a new tab and the Most recently used files list
nmap <C-Y> :tabnew <bar> CtrlPMRU<CR>
" do not clear cache on exit
let g:ctrlp_clear_cache_on_exit=0

" stuff for CtrlP to ignore
let g:ctrlp_custom_ignore = {
    \ 'file': '\v(\.bz2|ntuser|NTUSER)'
    \ }
"}}} CtrlP

" NeoComplCache or AutoComplPop {{{
" enable at startup?
let g:neocomplcache_enable_at_startup = 0
let g:acp_enableAtStartup = 1-g:neocomplcache_enable_at_startup

if !exists("g:defined_SetUp_neocomplcache_shortcuts")
	let g:defined_SetUp_neocomplcache_shortcuts = 1
	function SetUp_neocomplcache_shortcuts()

		" Plugin key-mappings.
		imap <C-k>     <Plug>(neocomplcache_snippets_expand)
		smap <C-k>     <Plug>(neocomplcache_snippets_expand)
		inoremap <expr><C-g>     neocomplcache#undo_completion()
		inoremap <expr><C-l>     neocomplcache#complete_common_string()

		" Recommended key-mappings.
		" <CR>: close popup and save indent.
		inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
		" <TAB>: completion.
		" TAB completion overruled by neosnippet setting
		" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
		inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
		inoremap <expr><C-y>  neocomplcache#close_popup()
		inoremap <expr><C-e>  neocomplcache#cancel_popup()

		"maximum number of candidates to show in a list
		let g:neocomplcache_max_list=10

		"trying to customize recognition of tex keywords
		"don't understand the @ symbol here,
		"this finds things like \Omega^{n_i}
		if !exists('g:neocomplcach_keyword_patterns')
			let g:neocomplcache_keyword_patterns = {}
		endif
		let g:neocomplcache_keyword_patterns.tex =
					\'\\[[:alpha:]@][[:alnum:]@]*\%(\^\|_\)\?\%({[^{]*}\)\?'

		autocmd BufEnter *.vim NeoComplCacheLock
		"let g:neocomplcache_disable_caching_file_path_pattern='*.vim'
		" troubleshooting
		"don't know why this variable does not exist
		"let g:neocomplcache_disabled_sources_list.tex = ['syntax_complete']
	endfunction
endif

if match(&rtp, 'neocomplcache') && g:neocomplcache_enable_at_startup == 1
	call SetUp_neocomplcache_shortcuts()
endif
" }}} neocomplcache

" neosnippet {{{
if !exists("g:defined_SetUp_neosnippet_shortcuts")
	let g:defined_SetUp_neosnippet_shortcuts = 1
	function SetUp_neosnippet_shortcuts()
		inoremap <expr><TAB> pumvisible() ?  
					\ "\<C-n>" : 
					\ neosnippet#expandable_or_jumpable() ? 
					\ "\<Plug>(neosnippet_expand_or_jump)" :
					\ "\<TAB>"
		snoremap <expr><TAB> pumvisible() ?  
					\ "\<C-n>" : 
					\ neosnippet#expandable_or_jumpable() ? 
					\ "\<Plug>(neosnippet_expand_or_jump)" :
					\ "\<TAB>"
		let g:neosnippet#snippets_directory='$cvim/vimfiles/snippets'
	endfunction
endif	

if match(&rtp, 'neosnippet') && g:neocomplcache_enable_at_startup == 1
	call SetUp_neosnippet_shortcuts()
endif
" }}} neosnippet

" vim-session {{{
set sessionoptions-=buffers
set sessionoptions-=options
set sessionoptions+=resize
let g:sessionman_sessions_path="$cvim/vimfiles/session"
let g:session_autosave='no'
let g:session_autoload='no'
let g:session_default_to_last=1
" }}}

" delimitMate or autoclose {{{

" load delimitMate?
let s:activate_delimitMate = 1
let s:loaded_delimitMate = 1 - s:activate_delimitMate
if (s:activate_delimitMate==1)
	" more delimiters for tex files
	au FileType tex let b:delimitMate_matchpairs = "``:'',(:),[:],{:},<:>"
	au FileType html let b:delimitMate_quotes = "\" ' $"
	au FileType vim let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
	" expand carriage return within an empty pair
	inoremap <expr> <CR> delimitMate#WithinEmptyPair() ?
				\ "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
				\ "\<CR>"
endif

	"}}}
	
" eclim {{{
" netbeans_enabled doesn't work headless
"if has("netbeans_enabled")
if (!exists("g:eclim_settings_loaded") || (g:eclim_settings_loaded == 1+0))
	let g:eclim_settings_loaded = 1
	augroup eclim
		au!
		autocmd BufRead *.java call Eclim_settings()
	augroup END

	function! Eclim_settings()
		" maps Ctrl-<F11> to eclipse's Ctrl-<F11> binding to run the current
		" configuration
		nmap <silent> <C-F11> :call eclim#vimplugin#FeedKeys('Ctrl+F11', 1)<cr>
		" eclim interferes with neocomplcache
"NeoComplCacheDisable
	endfunction
endif
"}}}

" supertab {{{
  " let g:SuperTabMappingForward = '<c-space>'
  " let g:SuperTabMappingBackward = '<s-c-space>'
" }}}

" indent guides {{{
" turn on 
let g:indent_guides_enable_on_vim_startup = 1
" }}}

" AutoComplPop {{{
if match(&rtp, 'autocomplpop')
	if exists('g:autoload_acp_was_edited') && g:autoload_acp_was_edited
		echoerr 'AutoComplPop has been updated. Your edit is gone.  Here it is:'.
					\'in autoload/acp.vim:acp#onPopupPost you replaced '.
					\'" return (s:behavsCurrent[s:iBehavs].command =~# blah blah ..."'.
					\'with \"return \"\\<C-p>\"'.
					\' so that the first selection would not be chosen by default'
	endif
endif
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:UltiSnipsListSnippets = '<C-j>'
" }}}

"}}}
