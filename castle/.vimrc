set nocompatible
filetype plugin on
set encoding=utf8

call plug#begin('~/.vim/plugged')

" Themes
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/seoul256.vim'
Plug 'dracula/vim'

" General Purpose Utilities
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'mhinz/vim-startify'
Plug 'dr-chip-vim-scripts/ZoomWin', { 'on': 'ZoomWin' }
Plug 'easymotion/vim-easymotion'

if v:version > 700
  Plug 'yegappan/mru'
  Plug 'majutsushi/tagbar'
  Plug 'ludovicchabant/vim-gutentags', { 'on': 'TagbarToggle' }
endif

if has("gui_macvim")
  Plug 'Valloric/YouCompleteMe'    "only works on macvim
endif

" Buffer Handling
Plug 'jeetsukumaran/vim-buffergator'
Plug 'moll/vim-bbye'

" Distraction Free writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  \ | Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

" Status Bar Plugins
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'

" General Purpose Syntax Checker
Plug 'scrooloose/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': 'javascript' }
Plug 'rodrigore/syntastic-local-semistandard.vim', { 'for': 'javascript' }
Plug 'flowtype/vim-flow', { 'for': 'javascript' }

" NERDTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin'

" Search Plugin
Plug 'mileszs/ack.vim'

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

" Colorscheme

"colorscheme peachpuff
colorscheme dracula
"colorscheme wombat256i
"colorscheme miko
"colorscheme seoul256
"set background=dark

" Fix vertical split separator
set fillchars+=vert:│
"autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme = "dracula"
let &t_Co=256
let g:airline#extensions#tabline#enabled = 1
"let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'

" Map leaders
let mapleader = "-"
let maplocalleader = "--"

" Linenumbers Config
nnoremap <C-l> :NumbersToggle<CR>
setl number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Bindings for ack.vim
nnoremap <leader>aa :Ack!<space>
nnoremap <leader>aw :Ack! <cword><cr>
xnoremap <leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>

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
" Show current buffer in NERDTree
nnoremap <leader>n :NERDTreeFind<CR>

" netrw Config
let g:netrw_banner=0       " disable banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()

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
highlight BookmarkSign ctermbg=NONE ctermfg=160
let g:bookmark_sign = '🔖'
highlight BookmarkLine ctermbg=22 ctermfg=NONE
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
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

" vim-bbye bindings
nnoremap <Leader>q :Bdelete<CR>

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

command! Standard :call <SID>standard()
command! Semistandard :call <SID>semistandard()

function! s:standard()
  let g:syntastic_javascript_checkers = ['standard']
  let g:syntastic_javascript_standard_exec = 'standard'
  SyntasticCheck
endfunction

function! s:semistandard()
  let g:syntastic_javascript_checkers = ['standard']
  let g:syntastic_javascript_standard_exec = 'semistandard'
  SyntasticCheck
endfunction
