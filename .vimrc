" Modeline and Notes {
"	vim: set foldmarker={,} foldlevel=0 spell:
"
"	This is my personal .vimrc, I don't recommend you copy it, just
"	use the "	pieces you want(and understand!).  When you copy a
"	.vimrc in its entirety, weird and unexpected things can happen.
"
"	If you find an obvious mistake hit me up at:
"	http://robertmelton.com/contact (many forms of communication)
" }

" Add by Jie {

	call pathogen#runtime_append_all_bundles()
	call pathogen#helptags()

	set makeprg=scons "use gmake
	" set grepprg=~/sl.sh "use grep
	" set grepprg=internal
	set grepprg=grep\ -rn\ --include=$*\ .

	se fencs=utf-8,cp936
	set encoding=utf-8
	set tenc=utf-8

	set updatetime=200
	set timeoutlen=300

	" au BufWritePre *.cpp,*.hpp,*.c,*.h,*.lua,*.py,*.sh set fenc=utf-8
	au BufReadPre hg-editor*.txt set enc=utf-8

	let mapleader = ","

	set pastetoggle=<leader>p

	nnoremap ; :

	cnoremap ` <C-r>"

	nnoremap <C-k> :cp<RETURN>
	nnoremap <C-j> :cn<RETURN>
	noremap <C-h> :tabprevious<CR>
	noremap <C-l> :tabnext<CR>

	let g:fuf_modesDisable = ['mrucmd']
	let g:fuf_mrufile_maxItem = 400

	nnoremap <leader>b :FufMruFile<CR>
	nnoremap <leader>f :FufCoverageFile<CR>
	nnoremap <leader>r :GundoToggle<CR>
	nnoremap <leader>t :NERDTreeToggle<RETURN>
	nnoremap <leader>g :TagbarToggle<RETURN>
	nnoremap <leader>c :exec "%s/".expand("<cword>")."//gn"<CR>
	" nnoremap <C-]> :FufTagWithCursorWord<CR>

	inoremap jj <ESC>
	inoremap kk <ESC>

    let g:yankring_map_dot = 0

	" Insert and command-line mode Caps Lock.
	" Lock search keymap to be the same as insert mode
	" set imsearch=-1
	" Load the keymap that acts like capslock
	" set keymap=insert-only_capslock
	" Turn it off by default
	" set iminsert=0
	" Kill the capslock when leaving insert mode
	" autocmd InsertLeave * set iminsert=0
	" Cursor color change when capslock in on
	":highlight Cursor guifg=NONE guibg=Green
	":highlight lCursor guifg=NONE guibg=Cyan

	func! SearchWord()
		let w = expand("<cword>")
		exe "grep *.{lua,[ch],[ch]pp,pto} \"" . w . "\""
	endfun
	map <F8> :call SearchWord()<CR><CR>
	func! ReloadAllFiles()
		bufdo e
		syntax on
	endfun
	map <F9> :call ReloadAllFiles()<CR>
	map <F10> :call ReloadAllSnippets()<CR>

	map <leader>sv :so $MYVIMRC<CR>
	map <leader>ev :e $MYVIMRC<CR>

	" transfer/read and write one block of text between vim sessions
	" " Usage:
	" " 'from' session:
	" " ma
	" " move to end-of-block
	" " xw
	" "
	" " 'to' session:
	" " move to where I want block inserted
	" " xr
	" "
	"if has("unix")
	"	nmap <leader>r :r $HOME/.vimxfer<CR>
	"	nmap <leader>w :'a,.w! $HOME/.vimxfer<CR>
	"	vmap <leader>r c<Esc>:r $HOME/.vimxfer<CR>
	"	vmap <leader>w :w! $HOME/.vimxfer<CR>
	"else
	"	nmap <leader>r :r c:/.vimxfer<CR>
	"	nmap <leader>w :'a,.w! c:/.vimxfer<CR>
	"	vmap <leader>r c<Esc>:r c:/.vimxfer<CR>
	"	vmap <leader>w :w! c:/.vimxfer<CR>
	"endif

	function! s:ChangeVarName(varname)
		let s:specials = {}

		let s:specials['.*ToString()'] = ''
		let s:specials['UId'] = 'UserId'

		let s:rt = a:varname
		for pattern in keys(s:specials)
			if match(s:rt, pattern) != -1
				let s:rt = s:specials[pattern]
			endif
		endfor
		let s:rt = substitute(s:rt, ":Get", "", "")
		let s:rt = substitute(s:rt, "Obj", "", "")
		let s:rt = substitute(s:rt, "()", "", "")
		let s:rt = substitute(s:rt, "self\\.", "", "")
		let s:rt = substitute(s:rt, "self", "", "")
		let s:rt = substitute(s:rt, "\\.", "", "")
		let s:rt = substitute(s:rt, "id", "Id", "")
		let s:rt = substitute(s:rt, "amount", "Amount", "")
		return s:rt
	endfunction

	function! AddLog()
		let s:formats = {}

		let s:formats['.*ToString()'] = '%s'
		let s:formats['.*Name'] = '=%s'
		let s:formats['.*Message'] = '=%s'
		let s:formats['vfd'] = '=%d'
		let s:formats['.*Id'] = '=%d'
		let s:formats['.*'] = '=%d'

		normal mb0f(f.lv$hh"ay
		let s:params = @a
		let s:words = split(s:params, ", *")
		let @b = s:words[0] . ' = '
		let s:words[0] = tr(s:words[0], "_0", " %")
		for i in range(1, len(s:words)-1)
			for pattern in keys(s:formats)
				if match(s:words[i], pattern) != -1
					let s:format = s:formats[pattern]
				endif
			endfor
			let s:words[i] = s:ChangeVarName(s:words[i]) . s:format
		endfor
		let @a = '"' . join(s:words, ",") . '",'

		normal `aO
		normal "bp"ap`b

	endfunction

	nmap ## :call AddLog()<CR>
" }

" 256 Color {
if &term =~ "xterm"
	" 256 color
	let &t_Co=256
	" restore screen after quitting
	" set t_ti=7[?47h
   	" set t_te=[2J[?47l8
	" set t_ti=[?47h
   	" set t_te=[?47l
	if has("terminfo")
		let &t_Sf="[3%p1%dm"
		let &t_Sb="[4%p1%dm"
	else
		let &t_Sf="[3%dm"
		let &t_Sb="[4%dm"
	endif
endif
" }

" Basics {
	set nocompatible " explicitly get out of vi-compatible mode
	set noexrc " don't use local version of .(g)vimrc, .exrc
	set background=dark " we plan to use a dark background
	set cpoptions=aABceFsmq
	"			  |||||||||
	"			  ||||||||+-- When joining lines, leave the cursor
	"			  |||||||	   between joined lines
	"			  |||||||+-- When a new match is created (showmatch)
	"			  ||||||	  pause for .5
	"			  ||||||+-- Set buffer options when entering the
	"			  |||||		 buffer
	"			  |||||+-- :write command updates current file name
	"			  ||||+-- Automatically add <CR> to the last line
	"			  |||	   when using :@r
	"			  |||+-- Searching continues at the end of the match
	"			  ||	  at the cursor position
	"			  ||+-- A backslash has no special meaning in mappings
	"			  |+-- :write updates alternative file name
	"			  +-- :read updates alternative file name
	syntax on " syntax highlighting on
" }

" General {
	filetype plugin indent on " load filetype plugins/indent settings
	" set autochdir " always switch to the current file directory
	set backspace=indent,eol,start " make backspace a more flexible
	set nobackup " make backup files
	" set backupdir=~/.vim/backup " where to put backup files
	set clipboard+=unnamed " share windows clipboard
	set noswapfile
	" set directory=~/.vim/tmp " directory to place swap files in
	set fileformats=unix,dos,mac " support all three, in this order
	set hidden " you can change buffers without saving
	" (XXX: #VIM/tpope warns the line below could break things)
	set iskeyword+=_,$,@,% " none of these are word dividers
	" set mouse=a " use mouse everywhere
	set noerrorbells " don't make noise
	set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
	"			  | | | | | | | | |
	"			  | | | | | | | | +-- "]" Insert and Replace
	"			  | | | | | | | +-- "[" Insert and Replace
	"			  | | | | | | +-- "~" Normal
	"			  | | | | | +-- <Right> Normal and Visual
	"			  | | | | +-- <Left> Normal and Visual
	"			  | | | +-- "l" Normal and Visual (not recommended)
	"			  | | +-- "h" Normal and Visual (not recommended)
	"			  | +-- <Space> Normal and Visual
	"			  +-- <BS> Normal and Visual
	set wildmenu " turn on command line completion wild style
	" ignore these list file extensions
	set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
					\*.jpg,*.gif,*.png
	set wildmode=list:longest " turn on wild mode huge list
" }

" Vim UI {
	" set cursorcolumn " highlight the current column
	" set cursorline " highlight current line
	set incsearch " BUT do highlight as you type you
				   " search phrase
	set laststatus=2 " always show the status line
	set lazyredraw " do not redraw while running macros
	set linespace=0 " don't insert any extra pixel lines
					 " betweens rows
	set list " we do what to show tabs, to ensure we get them
			  " out of my files
	set listchars=tab:\ \ ,trail:- " show tabs and trailing
	set matchtime=5 " how many tenths of a second to blink
					 " matching brackets for
	set hlsearch " do not highlight searched for phrases
	set nostartofline " leave my cursor where it was
	set novisualbell " don't blink
	set number " turn on line numbers
	set numberwidth=5 " We are good up to 99999 lines
	set report=0 " tell us when anything is changed via :...
	set ruler " Always show current positions along the bottom
	set scrolloff=10 " Keep 10 lines (top/bottom) for scope
	set shortmess=aOstT " shortens messages to avoid
						 " 'press a key' prompt
	set showcmd " show the command being typed
	set showmatch " show matching brackets
	set sidescrolloff=10 " Keep 5 lines at the size
	set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
	"			   | | | | |  |   |		 |	|	  |    |
	"			   | | | | |  |   |		 |	|	  |    + current
	"			   | | | | |  |   |		 |	|	  |		  column
	"			   | | | | |  |   |		 |	|	  +-- current line
	"			   | | | | |  |   |		 |	+-- current % into file
	"			   | | | | |  |   |		 +-- current syntax in
	"			   | | | | |  |   |			 square brackets
	"			   | | | | |  |   +-- current fileformat
	"			   | | | | |  +-- number of lines
	"			   | | | | +-- preview flag in square brackets
	"			   | | | +-- help flag in square brackets
	"			   | | +-- readonly flag in square brackets
	"			   | +-- rodified flag in square brackets
	"			   +-- full path to file in the buffer
" }

" Text Formatting/Layout {
	set completeopt= " don't use a pop up menu for completions
	set noexpandtab " use real tabs please!
	set formatoptions=rq " Automatically insert comment leader on return,
						  " and let gq format comments
	" set ignorecase " case insensitive by default
	set infercase " case inferred by default
	set nowrap " do not wrap line
	set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
	set smartcase " if there are caps, go case-sensitive
	set shiftwidth=4 " auto-indent amount when using cindent,
					  " >>, << and stuff like that
	set softtabstop=4 " when hitting tab or backspace, how many spaces
					   "should a tab be (see expandtab)
	set tabstop=4 " real tabs should be 8, and they will show with
				   " set list on
" }

" Folding {
	set foldenable " Turn on folding
	set foldmarker={,} " Fold C style code (only use this as default
						" if you use a high foldlevel)
	set foldmethod=marker " Fold on the marker
	set foldlevel=100 " Don't autofold anything (but I can still
					  " fold manually)
	set foldopen=block,hor,mark,percent,quickfix,tag " what movements
													  " open folds
	function! SimpleFoldText() " {
		return getline(v:foldstart).' '
	endfunction " }
	set foldtext=SimpleFoldText() " Custom fold text function
								   " (cleaner than default)
" }

" Plugin Settings {
	let b:match_ignorecase = 1 " case is stupid
	let perl_extended_vars=1 " highlight advanced perl vars
							  " inside strings

	" TagList Settings {
		let Tlist_Auto_Open=0 " let the tag list open automagically
		let Tlist_Compact_Format = 1 " show small menu
		" let Tlist_Ctags_Cmd = 'ctags' " location of ctags
		let Tlist_Enable_Fold_Column = 0 " do show folding tree
		let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill
										" yourself
		let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
		let Tlist_Sort_Type = "name" " order by
		let Tlist_Use_Right_Window = 1 " split to the right side
										" of the screen
		let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always)
								 " read my functions
		" Language Specifics {
			" just functions and classes please
			let tlist_aspjscript_settings = 'asp;f:function;c:class' 
			" just functions and subs please
			let tlist_aspvbs_settings = 'asp;f:function;s:sub' 
			" don't show variables in freaking php
			let tlist_php_settings = 'php;c:class;d:constant;f:function' 
			" just functions and classes please
			let tlist_vb_settings = 'asp;f:function;c:class' 
		" }
	" }
" }

" Mappings {
	" ROT13 - fun
	map <F12> ggVGg?

	" space / shift-space scroll in normal mode
	" noremap <S-space> <C-b>
	" noremap <space> <C-f>

	" Make Arrow Keys Useful Again {
		" map <s-down> <ESC>:bn<RETURN>
		" map <s-up> <ESC>:bp<RETURN>
	" }
" }

" Autocommands {
	" Ruby {
		" ruby standard 2 spaces, always
		au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2 
		au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2 
	" }
	" Notes {
		" I consider .notes files special, and handle them differently, I
		" should probably put this in another file
		au BufRead,BufNewFile *.notes set foldlevel=2
		au BufRead,BufNewFile *.notes set foldmethod=indent
		au BufRead,BufNewFile *.notes set foldtext=foldtext()
		au BufRead,BufNewFile *.notes set listchars=tab:\ \
		au BufRead,BufNewFile *.notes set noexpandtab
		au BufRead,BufNewFile *.notes set shiftwidth=8
		au BufRead,BufNewFile *.notes set softtabstop=8
		au BufRead,BufNewFile *.notes set tabstop=8
		au BufRead,BufNewFile *.notes set syntax=notes
		au BufRead,BufNewFile *.notes set nocursorcolumn
		au BufRead,BufNewFile *.notes set nocursorline
		au BufRead,BufNewFile *.notes set guifont=Consolas:h12
		au BufRead,BufNewFile *.notes set spell
	" }
	au BufNewFile,BufRead *.ahk setf ahk
	au BufNewFile,BufRead *.pto setf xml
	au BufNewFile,BufRead *.go setf go
	au BufNewFile,BufRead *.tmpl setf mako
	au BufWritePre *.cpp,*.hpp,*.c,*.h,*.lua,*.py,*.go %s/\s\+$//ge
	au BufWritePre *.cpp,*.hpp,*.c,*.h,*.lua,*.py,*.go %retab!
" }

" GUI Settings {
if has("gui_running")
	" Basics {
		colorscheme darkblue " my color scheme (only works in GUI)
		set columns=80 " perfect size for me
		set lines=35 " perfect size for me
		set guifont=Monospace\ 12 " My favorite font

		" set columns=180 " perfect size for me
		" set lines=55 " perfect size for me
		" set guifont=Consolas:h10 " My favorite font

		set guioptions=ce
		"			   ||
		"			   |+-- use simple dialogs rather than pop-ups
		"			   +  use GUI tabs, not console style tabs
		set mousehide " hide the mouse cursor when typing
	" }

	" Font Switching Binds {
		" map <F8> <ESC>:set guifont=Consolas:h8<CR>
		" map <F9> <ESC>:set guifont=Consolas:h10<CR>
		" map <F10> <ESC>:set guifont=Consolas:h12<CR>
		" map <F11> <ESC>:set guifont=Consolas:h16<CR>
		" map <F12> <ESC>:set guifont=Consolas:h20<CR>
	" }
else
	" colorscheme molokai
	colorscheme myrdark
	" colorscheme dante
endif
" }
