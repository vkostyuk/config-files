set nocompatible              " required
filetype off                  " required
set background=dark

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle
" instead of Plugin)

" Folding
Plugin 'SimpylFold'
" Intendation
Plugin 'Vimjas/vim-python-pep8-indent'
" Syntax highlighting
Plugin 'scrooloose/syntastic'
" PEP8 checking
Plugin 'nvie/vim-flake8'
" Color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" File browsing
Plugin 'scrooloose/nerdtree'
" Search in files
Plugin 'kien/ctrlp.vim'
" Powerline (status)
Plugin 'vim-airline/vim-airline'
" Autoformatting 
Plugin 'Chiel92/vim-autoformat'
" Autocomplete
Plugin 'Valloric/YouCompleteMe'
" Commenting out lines
Plugin 'tomtom/tcomment_vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" js/html/css indentation
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

" Mark bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

let python_highlight_all=1
syntax on

if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme zenburn
endif

" Number lines
set nu


" Flake8 (pep8 checker) config
" Remove warnings window with a single keystroke
map <leader>c <C-w>j<C-w>q
" Don't open quickfix window
let g:flake8_show_quickfix=0

set lazyredraw 		" Buffer redraws (e.g., during macros)

" Backup and swap files.
set nobackup            " Disable backup files.
set noswapfile          " Disable swap files.
set nowritebackup       " Disable auto backup before overwriting a file.
