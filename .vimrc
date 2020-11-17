set nocompatible
set background=dark

" Install Vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-plug
call plug#begin('~/.vim/plugged')

" Folding
Plug 'tmhedberg/SimpylFold'
" Syntax highlighting
Plug 'scrooloose/syntastic'
" PEP8 checking
Plug 'nvie/vim-flake8'
" Color schemes
Plug 'altercation/vim-colors-solarized'
" File browsing
Plug 'scrooloose/nerdtree'
" Search in files
Plug 'kien/ctrlp.vim'
" Powerline (status)
Plug 'vim-airline/vim-airline'
" Autoformatting 
Plug 'Chiel92/vim-autoformat'
" Autocomplete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Commenting out lines (gc)
Plug 'tomtom/tcomment_vim'
" Dockerfile syntax
Plug 'ekalinin/Dockerfile.vim'
" YAML highlighting
Plug 'ingydotnet/yaml-vim'
" R syntax and more
Plug 'jalvesaq/Nvim-R', {'tag': 'v0.9.11'}
" Awk syntax
Plug 'vim-scripts/awk.vim'
" Stan syntax
Plug 'maverickg/stan.vim'
" Markdown plugin
Plug 'gabrielelana/vim-markdown'
" Indendation for Python
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

filetype plugin indent on
syntax on

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
    \ set textwidth=90 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" R indentation
au BufNewFile,BufRead *.R,*.Rmd
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=90 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" js/html/css/yaml indentation
au BufNewFile,BufRead *.js,*.html,*.css,*.yaml,*.yml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
	\ set expandtab |

" Dockerfile indentation
au BufNewFile,BufRead Dockerfile*,.vimrc
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set autoindent |
    \ set expandtab

" Stan indentation and type
au BufNewFile,BufRead *.stan,*.Stan,*.STAN
    \ set syntax=stan |
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set autoindent |
    \ set expandtab

" Markdown indentation
au BufNewFile,BufRead *.md
    \ set filetype=markdown |
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set textwidth=90 |
    \ set fileformat=unix

" SQL indentation
au BufNewFile,BufRead *.sql,*.SQL
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=90 |
    \ set expandtab |
    \ set autoindent


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
" Use tmux split instead of new terminal for R console
let R_tmux_split = 1
" Use my .tmux.conf
let R_notmuxconf = 1
" Display csv (csv.vim plugin) within Tmux
let R_csv_app = 'tmux new-window scim --txtdelim="\t"'
" Use \ to send to R
nmap \ <Plug>RDSendLine
vmap \ <Plug>RDSendSelection
vmap \e <Plug>RESendSelection
" Don't substitute <- when typing _
let R_assign=2

" Flake8 options
" Don't show marks in file
let g:flake8_show_in_file=0

" YouCompleteMe options
" Auto close preview on option select
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path = '/usr/bin/python3'

" Strip trailing whitespace
fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

au BufWritePre *.py,*.c,*.h,*.R,*.cpp :call <SID>StripTrailingWhitespaces()

" Copy between different vim instances
vnoremap <C-c> :w! ~/.vimbuffer<CR>
nnoremap <C-c> :w! ~/.vimbuffer<CR>
noremap <C-p> :r ~/.vimbuffer<CR>

" Toggle ipdb breakpoints using <F6>
func! s:SetBreakpoint()
	if getline(line('.')-1)!~#'^\s*import\sipdb'   
		cal append(line('.')-1, repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import ipdb; ipdb.set_trace()')
	endif
endf

func! s:RemoveBreakpoint()
	exe 'silent! g/^\s*import\sipdb\;\?\n*\s*ipdb.set_trace()/d'
endf

func! s:ToggleBreakpoint()
	if getline('.')=~#'^\s*import\sipdb' | cal s:RemoveBreakpoint() | el | cal s:SetBreakpoint() | en
endf
nnoremap <F6> :call <SID>ToggleBreakpoint()<CR>

" Disable markdown spellcheck
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0

" Set better colors in vimdiff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" SQL formatting
noremap <F3> :Autoformat<CR>
let g:formatdef_sql = '"sqlformat --reindent --keywords upper - identifiers lower -"'
let g:formatters_sql = ['sql']

" Set Syntastic to use Python 3.6
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_aggregate_errors = 1

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
