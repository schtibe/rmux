" Basic initialization for RMUX change if need, add your settings
set nocp
let &rtp .= expand(",$HOME/.rmux-$RMUXID/vim,$HOME/.rmux-$RMUDID/vim/after")
let $PYTHONPATH .= expand(":$HOME/.rmux-$RMUX/jedi")

call pathogen#infect()
call pathogen#helptags()

syntax on
filetype plugin on


" If you do not change above chances are good you can merge any upstream
" changes
"
" Your settings
set tw=80
set autoindent
set noeb vb t_vb=
set ignorecase
set smartcase

let g:jedi#use_tabs_not_buffers     = 0
" let g:jedi#show_function_definition = 0
let g:pymode_lint_checker           = "pyflakes,pep8,mccabe"
let g:pymode_lint_ignore            = "E203,E272,E221,E251,E202"
let g:pymode_rope_vim_completion    = 0
let g:pymode_breakpoint_cmd         = "import ipdb; ipdb.set_trace()  # XXX BREAKPOINT"

set guifont=Menlo\ Regular:h13
set number
set tabstop=4 shiftwidth=4 noexpandtab
set hlsearch

set wildmenu
set wildmode=list:longest,full
set completeopt=menuone,longest,preview

set tags=./tags;tags;
map <C-Enter> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

set background=dark
colorscheme solarized
set ruler

set guioptions-=T

map <C-h> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-l> <C-W>l

inoremap <Esc> <nop>
imap <C-M-space> <C-p><C-p><C-n>
imap <A-space> <C-x><C-o><C-n>

" Disable cursor keys
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
:nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
:nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

let g:EasyGrepMode=1

" EasyGrep quick fix window position buttom
:autocmd FileType qf wincmd J

" Only load cursorline / visible tab etc in GUI mode
if has("gui_running")
	set list listchars=tab:⎮\ ,trail:●,precedes:…,extends:…,nbsp:‗
	highlight SpecialKey guibg=background
	if &background == "light"
		highlight SpecialKey guifg=#eee8d5
	else
		highlight SpecialKey guifg=#073642
	end
else
	let g:solarized_termcolors=256
end
