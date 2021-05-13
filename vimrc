" file:    vimrc
" brief:   configuration of the mighty VIm editor
" author:  (c) 2009 - 2021 Alexander Puls <https://0vv1.io>
" license: MIT <https://opensource.org/licenses/MIT>
" ------------------------------------------------------------------------------

" directories ________________________________
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo

" colors ________________
"colorscheme
"if &term =~ '256color'		" disable background color erase (BCE) so that
"set t_ut=					" color schemes render properly when inside
"endif						" 256-color tmux and GNU screen
"set t_Co=16				" enable 256 colors
"set termguicolors			" enable GUI colors in terminal to get truecolors
if &diff
	colorscheme solarized	" color theme for vimdiff
endif

" syntax highlighting _______________________________
if has("syntax")
	syntax on
endif

augroup tex
	autocmd!
	autocmd BufNewFile,BufRead *.cls   set syntax=tex
	autocmd BufNewFile,BufRead *.lco   set syntax=tex
	autocmd BufNewFile,BufRead *.tex   set syntax=tex
augroup END

" UI _______________________________________________________________
set autoindent			" always set autoindenting on
set linebreak			" don't wrap words by default
highlight LineNr term=bold cterm=bold ctermfg=Yellow ctermbg=Black 
highlight LineNr gui=NONE guibg=NONE
set number				" set line numbers
highlight CursorLine term=bold cterm=bold ctermfg=NONE ctermbg=Black
highlight CursorLine gui=NONE guibg=NONE
highlight ColorColumn ctermbg=black
let &colorcolumn = join(range(81, 120), ',')
set cursorline			" highlight line
autocmd InsertEnter,InsertLeave * set cul!
set shiftwidth=4		" number of columns text is indented
set showcmd				" show (partial) command in status line
set showmatch			" show matching brackets
set wildmenu			" command-line completion operates in an enhanced mode
if has("autocmd")
	filetype indent on	" load indentation rules according to filetype
endif
if has("autocmd")
	au FileType mail set tw=70
endif

" behavior _____________________________________________________________________
set autowrite			" autosave before commands like :next and :make
set history=50			" keep 50 lines of command line history
set nobackup			" don't keep a backup file
" suffixes that get lower priority when doing tab completion for filenames
set suffixes=~,.swp,.o,.info,.aux,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out
set viminfo=""			" no .viminfo file
if has("autocmd")		" jump to the last position when reopening a file
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endif

" spaces and tabs ____________
set backspace=indent,eol,start	" more powerful backspacing
"set expandtab					" turn tab into spaces
set softtabstop=4				" number of spaces in tab when editing
set tabstop=4					" number of spaces in tab

" searching ______________________________________________________________
set hlsearch								" highlight all search matches
set ignorecase								" do case insensitive matching
set incsearch								" incremental search
set smartcase								" use case if any caps used
nnoremap <silent> <CR> :nohlsearch <CR><CR>

" EOF $HOME/.vim/vimrc ---------------------------------------------------------
