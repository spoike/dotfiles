set nocompatible                   "required
filetype off                       "required

set rtp+=~/.vim/bundle/Vundle.vim  "required

call vundle#begin()                "required

Plugin 'VundleVim/Vundle.vim'      "required
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'bling/vim-airline'
Plugin 'myusuf3/numbers.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tpope/vim-sensible'
Plugin 'pangloss/vim-javascript'
Plugin 'wavded/vim-stylus'
Plugin 'kchmck/vim-coffee-script'
Plugin 'plasticboy/vim-markdown'
Plugin 'mattn/emmet-vim'
Plugin 'clones/vim-zsh'
Plugin 'freitass/todo.txt-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'bling/vim-bufferline'

call vundle#end()                  "required
filetype plugin indent on          "required

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme = "wombat"
let mapleader = "'"
let &t_Co=256

" Localleader map
let maplocalleader = "-"

" Linenumbers Config
nnoremap <C-l> :NumbersToggle<CR>
setl number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>
nnoremap <Leader>f :Unite grep:.<cr>

" CtrlP Config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/node_modules/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Nerdtree Config
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Markdown folding
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1
