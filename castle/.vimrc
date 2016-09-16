set nocompatible
filetype plugin on

call plug#begin('~/.vim/plugged')

" General Purpose Utilities
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/seoul256.vim'
Plug 'kien/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'myusuf3/numbers.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree'
Plug 'schickling/vim-bufonly'
Plug 'MattesGroeger/vim-bookmarks'

" Distraction Free writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  \ | Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

" Status Bar Plugins
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'

" General Purpose Syntax Checker
Plug 'scrooloose/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': 'javascript' }

" NERDTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] } | Plug 'Xuyuanp/nerdtree-git-plugin'

" Search Plugin
Plug 'mileszs/ack.vim'

" Syntax
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'clones/vim-zsh', { 'for': 'zsh' }
Plug 'freitass/todo.txt-vim', { 'for': 'todo' }
Plug 'tpope/vim-dotenv'

call plug#end()

syntax on

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme = "wombat"
let &t_Co=256

" Map leaders
let mapleader = "'"
let maplocalleader = "''"

" Linenumbers Config
nnoremap <C-l> :NumbersToggle<CR>
setl number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Bindings for ack.vim
nnoremap <localleader>a<space> :Ack!<space>
nnoremap <localleader>aw :Ack! <cword><cr>
xnoremap <localleader>a y:Ack <C-r>=fnameescape(@")<CR><CR>

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
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
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
"colorscheme seoul256
"set background=dark

" Goyo+Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Undo Tree
nnoremap <F5> :UndotreeToggle<cr>

" Mouse mode
set mouse=a

" open todo.txt file in project root
nnoremap <localleader>t :bo 5sp todo.txt<cr>

" Source the vimrc file automatically on write
map <Leader>s :tabe $MYVIMRC<cr>
autocmd bufwritepost .vimrc source $MYVIMRC

try
   execute "silent! source " . $MYVIMRC . "." . $USER
catch
   " no-op
endtry

" MattesGroeger/vim-bookmarks
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=22 ctermfg=NONE
let g:bookmark_sign = '🔖'
let g:bookmark_highlight_lines = 1
" unbind vim-bookmark key mappings when NERDtree is active
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
	nmap mm :BookmarkToggle<CR>
	nmap mi :BookmarkAnnotate<CR>
	nmap mn :BookmarkNext<CR>
	nmap mp :BookmarkPrev<CR>
	nmap ma :BookmarkShowAll<CR>
	nmap mc :BookmarkClear<CR>
	nmap mx :BookmarkClearAll<CR>
	nmap mkk :BookmarkMoveUp
	nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
	unmap mm
	unmap mi
	unmap mn
	unmap mp
	unmap ma
	unmap mc
	unmap mx
	unmap mkk
	unmap mjj
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()


" Interactive Git Rebase
function! ReplaceRebaseCommand(rebaseCommand)
  :exe "s-^\(pick<bar>reword<bar>edit<bar>squash<bar>fixup<bar>exec<bar>drop\)\?-" . a:rebaseCommand . "-g<esc>"
endfunction
" normal mode
autocmd FileType gitrebase nnoremap <buffer> <localleader>p _cwpick<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>r _cwreword<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>e _cwedit<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>s _cwsquash<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>f _cwfixup<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>x _cwexec<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>d _cwdrop<esc>_
" visual mode
autocmd FileType gitrebase vnoremap <buffer> <localleader>p :s:^\(pick\|reword\|edit\|squash\|fixup\|exec\|drop\)\=:pick:g<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>r :s:^\(pick\|reword\|edit\|squash\|fixup\|exec\|drop\)\=:reword:g<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>e :s:^\(pick\|reword\|edit\|squash\|fixup\|exec\|drop\)\=:edit:g<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>s :s:^\(pick\|reword\|edit\|squash\|fixup\|exec\|drop\)\=:squash:g<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>f :s:^\(pick\|reword\|edit\|squash\|fixup\|exec\|drop\)\=:fixup:g<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>x :s:^\(pick\|reword\|edit\|squash\|fixup\|exec\|drop\)\=:exec:g<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>d :s:^\(pick\|reword\|edit\|squash\|fixup\|exec\|drop\)\=:drop:g<cr>

