" dxsh's vim conf

let mapleader = ","

" {{{ Plugins
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'klen/python-mode'
Plugin 'wesQ3/vim-windowswap'
Plugin 'dietsche/vim-lastplace'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/c.vim'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'

call vundle#end()
filetype plugin indent on
" }}}
" {{{ Plugin options
set tags=tags;/

let g:Powerline_symbols = 'fancy'
let g:NERDSpaceDelims = 1
let g:SimpylFold_docstring_preview=1
let g:NERDTreeWinSize = 20
let g:pymode_run = 1
let g:pymode_rope = 0
let pymode_lint_write = 0
let g:pymode_lint_on_write = 1
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pep8', 'pylint', 'pyflakes']
let g:pymode_options_colorcolumn = 0
let g:pymode_python = 'python3'
let g:pymode_options = 1   
let g:pymode_trim_whitespaces = 1   
let g:pymode_options_colorcolumn = 1  
let g:pymode_indent = 1                 
let g:pymode_folding = 1
let g:BASH_LineEndCommColDefault = 45
let g:cpp_class_scope_highlight = 1
let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
" }}}
" {{{ Set options
set t_Co=256                    " Force 256 term colors
"set viminfo=""                 " Don't write viminfo
set laststatus=2                " Always display status line
set number                      " Show line numbers
set backspace=eol,start,indent  " Allow backspace
set ignorecase                  " Use case-insensitive while searching
set ruler                       " Show row + column info 
set showmatch                   " Highlight matching brace/parenthesis 
set hlsearch                    " Highlight all search results
set incsearch                   " Show search results while typing
set expandtab                   " Covert tab to spaces
set wrap                        " Wrap lines
set softtabstop=4               " Number of spaces per tab
set autoindent                  " Indent automatically where suitable
set smartindent                 " `smart' indent
set textwidth=79                " Line wrap
set undolevels=1000             " Number of undo levels
set history=1500                " Number of history lines to remember
set foldmethod=indent           " Use indentation to fold
set foldlevel=0                 " Start off with all folds closed
set shiftwidth=4                " Shift lines by 4 spaces when using >>/<<
set colorcolumn=79              " 80 col delimiter
set pastetoggle=<leader>p	" toggle paste mode w/ <leader>p
set wildignore=*.o,*~,*.pyc     " Ignore compiled files
set encoding=utf8               " Set utf-8 as the standard encoding
set modeline
set modelines=5
set noswapfile nobackup nowritebackup 
set cursorline cursorcolumn

au BufRead,BufNewFile *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent filetype=python fileformat=unix
au BufRead,BufNewFile *.pl set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent filetype=perl fileformat=unix
au BufRead,BufNewFile *.sh set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79 expandtab autoindent filetype=sh fileformat=unix
au BufRead,BufNewFile *.cpp,*.c,*.h set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79 expandtab autoindent fileformat=unix fileencoding=utf-8
au BufRead,BufNewFile *.rst,*.yml set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79 expandtab autoindent fileformat=unix
au BufRead,BufNewFile *.sql set tabstop=8 softtabstop=8 backspace=2 shiftwidth=2 textwidth=79 expandtab autoindent fileformat=unix

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
au FocusGained,BufEnter * :silent! !
syntax enable
" }}}

" Enable syntax highlighting
if has("syntax") | syntax on | colors peaksea | set background=dark | endif

" Our statusline
set statusline=\%{HasPaste()}%F%m%r%h\ %w\ %y\ \ cwd:\ %r%{getcwd()}%h\ \ %l\,%1c\,%L

" {{{ Functions 
" Notify that we're in paste mode
function HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction


" Append modeline
function AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d ft=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &filetype, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

" Strip white space on saving
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.pl :call DeleteTrailingWS()
" }}}
" {{{ Mappings
" Put modeline
nnoremap <silent> <leader>ml :call AppendModeline()<CR>
map <leader>rc :w <CR> :!g++ -std=c++14 -Wall -Wextra -pedantic -Wmissing-declarations -pthread % -o %< && ./%< <CR>


" Update file
nmap <silent> <leader>e :e $MYVIMRC<CR>

" Insert datetime
nnoremap <silent> <leader>dt "=strftime("%F %T (%Z)")<CR>P
" }}}
"
" {{{ templates
augroup templates
  au!
  autocmd BufNewFile *.sql silent! execute '0r $HOME/.vim/templates/skeleton.'.expand("<afile>:e")
  autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

" }}}
