set nocompatible
set hidden " for ctrl-space
filetype plugin indent on
set encoding=utf8

set tabstop=2
set shiftwidth=2
set expandtab

call plug#begin('~/.vim/plugged')

" Themes
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/seoul256.vim'
Plug 'dracula/vim'
Plug 'chriskempson/base16-vim'

" General Purpose Utilities
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ctrlspace/vim-ctrlspace'
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
Plug '/usr/local/opt/fzf'| Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'schickling/vim-bufonly'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mhinz/vim-startify'
Plug 'dr-chip-vim-scripts/ZoomWin', { 'on': 'ZoomWin' }
Plug 'easymotion/vim-easymotion'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'gioele/vim-autoswap'

if v:version > 700
	Plug 'yegappan/mru'
  " Tags Handling
  set tags=./tags;/,tags;/
	Plug 'majutsushi/tagbar'
  Plug 'ludovicchabant/vim-gutentags'
  let g:airline#extensions#gutentags#enabled = 1
endif

if has("gui_macvim") || has('python') || has('python3')
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --js-completer' }
endif

" Buffer Handling
Plug 'moll/vim-bbye'

" Distraction Free writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
			\ | Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

" Status Bar Plugins
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" General Purpose Syntax Checker (ale)
Plug 'w0rp/ale'
nmap <silent> <C-h> :lwindow<cr>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:airline#extensions#ale#enabled = 1
" Plug 'flowtype/vim-flow', { 'for': 'javascript' }

" NERDTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin'

" Search Plugin
Plug 'mileszs/ack.vim' | Plug 'tpope/vim-dispatch'
let g:ack_use_dispatch = 1
" Bindings for ack.vim
nnoremap <leader>aa :Ack!<space>
nnoremap <leader>aw :Ack! <cword><cr>
xnoremap <leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag --vimgrep -l --nocolor -g ""'
endif

" Syntax
Plug 'sheerun/vim-polyglot'
" Note: please check if a syntax plugin isn't already in vim-polyglot
Plug 'ryym/vim-riot', { 'for': 'riot' }
Plug 'clones/vim-zsh', { 'for': 'zsh' }
Plug 'freitass/todo.txt-vim', { 'for': 'todo' }
Plug 'tpope/vim-dotenv'

Plug 'ryanoasis/vim-devicons'
call plug#end()

syntax on

" Copy to clipboard keybindings in visual mode
if has("clipboard")
	vnoremap <C-x> :!pbcopy<CR>
	vnoremap <C-c> :w !pbcopy<CR><CR>
endif

" Invisible chars
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" closetag
let g:closetag_filenames = "*.html,*.htm,*.js,*.jsx"

" Colorscheme

set background=dark
colorscheme dracula

" Highlight for YCM
highlight Pmenu ctermbg=56 ctermfg=15
" ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel term=standout ctermbg=165 ctermfg=15

" autoswap - change to the tmux pane
let g:autoswap_detect_tmux = 1

" Fix vertical split separator
set fillchars+=vert:│
"autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme = "base16"
let &t_Co=256
let g:airline#extensions#tabline#enabled = 0
"let g:airline_section_b = '%{getcwd()}'
"let g:airline_section_z = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v'
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'

" Map leaders
let mapleader = "\<Space>"
let maplocalleader = "-"

" Linenumbers Config
nnoremap <C-l> :NumbersToggle<CR>
setl number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

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

" wildignore config (was part of CtrlP previously)
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/node_modules/*

" vim-ctrlspace config
let g:airline_exclude_preview = 1
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
set showtabline=0

" fzf.vim config
nnoremap <silent><C-p> :GFiles<CR>

" Nerdtree Config
map <C-n> :NERDTreeToggle<CR>
" Always start NERDTree
" autocmd vimenter * NERDTree
" Open NERDTree automatically if no files specified
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Closes if only NerdTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Show current buffer in NERDTree
nnoremap <leader>n :NERDTreeFind<CR>

" netrw Config
let g:netrw_banner=0       " disable banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()

" Generic folding
set foldmethod=syntax
set foldlevelstart=999

let javaScript_fold=1       " JavaScript
let sh_fold_enabled=1       " sh
let vimsyn_folding='af'     " Vim script
let xml_syntax_folding=1    " XML

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
"highlight BookmarkSign ctermbg=NONE ctermfg=160
"highlight BookmarkLine ctermbg=22 ctermfg=NONE
let g:bookmark_sign = '🔖'
let g:bookmark_annotation_sign = '📝'
"let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1
let g:bookmark_center = 1
" unbind vim-bookmark key mappings when NERDtree is active
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
	nmap mm <Plug>BookmarkToggle
	nmap mi <Plug>BookmarkAnnotate
	nmap mn <Plug>BookmarkNext
	nmap mp <Plug>BookmarkPrev
	nmap ma <Plug>BookmarkShowAll
	nmap mc <Plug>BookmarkClear
	nmap mx <Plug>BookmarkClearAll
	nmap mkk <Plug>BookmarkMoveUp
	nmap mjj <Plug>BookmarkMoveDown
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

" vim-bbye bindings
nnoremap <Leader>q :Bdelete<CR>

" Interactive Git Rebase
" normal mode
autocmd FileType gitrebase nnoremap <buffer> <localleader>p _cwpick<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>r _cwreword<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>e _cwedit<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>s _cwsquash<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>f _cwfixup<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>x _cwexec<esc>_
autocmd FileType gitrebase nnoremap <buffer> <localleader>d _cwdrop<esc>_
" visual mode
autocmd FileType gitrebase vnoremap <buffer> <localleader>p :s/\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)/pick/<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>r :s/\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)/reword/<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>e :s/\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)/edit/<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>s :s/\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)/squash/<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>f :s/\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)/fixup/<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>x :s/\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)/exec/<cr>
autocmd FileType gitrebase vnoremap <buffer> <localleader>d :s/\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)/drop/<cr>

" easy motion bindings
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" tagbar
nmap <Leader>m :TagbarToggle<cr>

" automatically set filetype for json rc files
au BufRead,BufNewFile .babelrc set filetype=json
au BufRead,BufNewFile .frag set filetype=glsl
au BufRead,BufNewFile .vert set filetype=glsl

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
	let open_buffers = []

	for i in range(tabpagenr('$'))
		call extend(open_buffers, tabpagebuflist(i + 1))
	endfor

	for num in range(1, bufnr("$") + 1)
		if buflisted(num) && index(open_buffers, num) == -1
			exec "bdelete ".num
		endif
	endfor
endfunction

" devicons
let g:webdevicons_conceal_nerdtree_brackets = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFolderNodes = 0
" re-source, fix syntax matching issues (concealing brackets):
"if exists('g:loaded_webdevicons')
"	call webdevicons#refresh()
"endif

" flowtype/vim-flow
let g:flow#autoclose = 1

" Open file under cursor in a vertical split
nnoremap <C-W><C-F> <C-W>vgf

" Add fzf to runtime path
"set rtp+=/usr/local/opt/fzf

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" See https://andrew.stwrt.ca/posts/project-specific-vimrc/
" Allow project specific vimrc
set exrc
" disable unsafe commands in project specific vimrc files
set secure
