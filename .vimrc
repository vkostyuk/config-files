set nocompatible
set background=dark

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Folding
Plugin 'SimpylFold'
" Intendation
Plugin 'Vimjas/vim-python-pep8-indent'
" Syntax highlighting
Plugin 'scrooloose/syntastic'
" PEP8 checking
Plugin 'nvie/vim-flake8'
" Color schemes
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
" Commenting out lines (gc)
Plugin 'tomtom/tcomment_vim'
" Dockerfile syntax
Plugin 'ekalinin/Dockerfile.vim'
" R syntax and more
Plugin 'jalvesaq/Nvim-R'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on

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

" Dockerfile indentation
au BufNewFile,BufRead Dockerfile*
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set autoindent |

" Mark bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

let python_highlight_all=1
syntax on

" Number lines
set nu

set lazyredraw 		" Buffer redraws (e.g., during macros)

" Backup and swap files.
set nobackup            " Disable backup files.
set noswapfile          " Disable swap files.
set nowritebackup       " Disable auto backup before overwriting a file.

" Shortcut to open nerdtree
map <C-n> :NERDTreeToggle<CR>

" Disable interactive Ex mode
nnoremap Q <Nop>

" Set leader to ,
let mapleader = ","

" Show when leader (or other command key) is pressed
set showcmd

" Configuration of Nvim-R plugin for Vim+Tmux
" Run R in Tmux (not in Vim's terminal emulator)
let R_in_buffer = 0
let R_source = '/home/vkostyuk/.vim/bundle/Nvim-R/R/tmux_split.vim'
" Use my .tmux.conf
let R_notmuxconf = 1
" Display csv (csv.vim plugin) within Tmux
let R_csv_app = 'tmux new-window scim --txtdelim="\t"'
