set nocompatible                   "required
filetype off                       "required

set rtp+=~/.vim/bundle/Vundle.vim  "required

call vundle#begin()                "required

Plugin 'VundleVim/Vundle.vim'      "required
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'myusuf3/numbers.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-sensible'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'wavded/vim-stylus'
Plugin 'kchmck/vim-coffee-script'
Plugin 'plasticboy/vim-markdown'
Plugin 'mattn/emmet-vim'
Plugin 'clones/vim-zsh'
Plugin 'freitass/todo.txt-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dotenv'
Plugin 'vimwiki/vimwiki'
Plugin 'mileszs/ack.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'elixir-lang/vim-elixir'

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

" Bindings for ack.vim
nnoremap <localleader>a :Ack!<space>
vnoremap <localleader>a y:Ack! <C-r>=nameescape(@0)<CR><CR>

" gp - select the pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" highlight search
" toggle
nnoremap <localleader>h :set hlsearch!<cr>
" clear search result
nnoremap <localleader>ch :nohlsearch<cr>

" reindent the whole file
nnoremap <localleader>= gg=G''

" additional insert mode commands
inoremap <c-d> <esc>ddi

" vsplit command
nnoremap <localleader>s :vs<cr>

" select all
nnoremap <C-a> ggVG

" vim-jsx Config
let g:jsx_ext_required = 0

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
" Always start NERDTree
" autocmd vimenter * NERDTree
" Open NERDTree automatically if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Closes if only NerdTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <localleader>n :NERDTreeFind<CR>

" Markdown folding
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

" Wildmenu
if has("wildmenu")
  set wildignore+=*.a,*.o
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*~,*.swp,*.tmp
  set wildmenu
  set wildmode=list:longest,full
endif

" Invisible chars
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Colorscheme
"colorscheme peachpuff
colorscheme wombat256i
"colorscheme miko

" Mouse mode
set mouse=a

" open todo.txt file in project root
nnoremap <localleader>t :10sp todo.txt<cr>

" Source the vimrc file automatically on write
map <Leader>s :tabe $MYVIMRC<cr>
autocmd bufwritepost .vimrc source $MYVIMRC

try
   execute "silent! source .vimrc." . $USER
catch
   " no-op
endtry

