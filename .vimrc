"
" .vimrc
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Reference: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins.
" - Avoid using standard Vim directory names like 'plugin'.
call plug#begin('~/.vim/bundle')

" Plugins
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system.
call plug#end()

" AIRLINE
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='minimalist'

" FZF
" Customize fzf colors to match your color scheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Invoke `:Files` with Ctrl+P.
nnoremap <C-p> :Files<Cr>
" Open files in horizontal split
nnoremap <silent> <Leader>s :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>
" Open files in vertical horizontal split
nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

" GITGUTTER
autocmd BufWritePost * GitGutter

" POLYGLOT
let g:vim_markdown_new_list_item_indent = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings                                                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                " Use the iMproved editor.
set backspace=indent,eol,start  " Allow backspacing past the insert point.
set autoindent                  " Auto-indent to the same width.
set history=1000                " Remember this many commands/patterns.
set iskeyword+=_,$,@,%,#,-      " Add to the list of keyword characters.
set nobackup                    " Disable backup files.

filetype on                     " Detect the filetype.
filetype plugin on              " Load filetype plugins.
filetype indent on              " Load filetype indentation settings.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set incsearch         " Enable incremental searching.
set nohlsearch        " Disable search results highlighting.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ruler          " Show the current position along the bottom.
set showcmd        " Display what you type in command mode.
set showmode       " Show which mode you're in (command/insert).
syntax on          " Enable syntax highlighting.
set scrolloff=2    " Keep a buffer at the top/bottom of the window.
set visualbell     " Use a flash instead of a beep.
set bg=dark        " Use colors for a dark-colored background.
set number         " Enable line numbers.
set wildmenu       " Enable enhanced command-line completion.
set wildmode=full  " Complete first full match, next match, etc.
set cmdheight=1    " Customize the command bar height.
set showmatch      " Show matching brackets.
set matchtime=5    " Time to blink matching brackets (1/10 s).
set notitle        " Don't mess with the window title.
set nolist         " Disable 'list' by default.
set modeline       " Enable modelines to set vim modes.
set modelines=3    " Check the last three lines for modelines.

colorscheme gruvbox

" Configure what is shown when ':set list' is enabled.
set listchars=eol:$,tab:>-,trail:-,extends:>,precedes:<

" Better copy/paste.
" (Vim must be compiled with `+clipboard` in order for this to work.)
set clipboard=unnamed
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Allow the mouse to be used to resize split windows.
" Reference: https://vi.stackexchange.com/a/521
set mouse=a
set ttymouse=xterm2

" Auto resize split panes whenever the host window is resized.
" Reference: https://vi.stackexchange.com/a/206
autocmd VimResized * wincmd =

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tabstop=4         " Customize how many spaces a <Tab> represents.
set shiftwidth=4      " Customize the number of spaces used with autoindent.
set noexpandtab       " Replace tabs with spaces.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Type Specifics                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Resume editing at the last known position.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" M$ Word Documents
autocmd BufReadPre *.doc set ro
autocmd BufReadPost *.doc silent %!antiword -f -t -s "%" - | fmt -csw78

" PDF Documents
autocmd BufReadPre *.pdf set ro
autocmd BufReadPost *.pdf silent %!pdftotext -layout "%" - | fmt -csw78

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <F10>: Remove unnecessary whitespace from the file.
nmap <F10> :%s/\s\+$//<CR>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","

" Maintain selection during indent/dedent.
vnoremap < <gv
vnoremap > >gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Completion                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use TAB to complete when typing words, else inserts TABs as usual.
" Uses dictionary and source files to find matching words to complete.
function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"
