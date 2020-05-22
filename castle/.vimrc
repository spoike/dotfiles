set nocompatible
set hidden " for ctrl-space
filetype plugin indent on
set encoding=utf8

set tabstop=2
set shiftwidth=2
set expandtab

" Map leaders
let mapleader = "\<Space>"
let maplocalleader = "-"

call plug#begin('~/.vim/plugged')

" Themes
Plug 'chriskempson/base16-vim'

" General Purpose Utilities
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'bronson/vim-trailing-whitespace'
Plug '/usr/local/opt/fzf'| Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'easymotion/vim-easymotion'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'gioele/vim-autoswap'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}

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
"Plug 'ryym/vim-riot', { 'for': 'riot' }
"Plug 'freitass/todo.txt-vim', { 'for': 'todo' }
Plug 'clones/vim-zsh', { 'for': 'zsh' }
Plug 'tpope/vim-dotenv'

call plug#end()

syntax on

" Copy to clipboard keybindings in visual mode
"if has("clipboard")
"	vnoremap <C-x> :!pbcopy<CR>
" vnoremap <C-c> :w !pbcopy<CR><CR>
"endif

" Invisible chars
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" closetag
let g:closetag_filenames = "*.html,*.htm,*.js,*.jsx"

" Colorscheme

set background=dark
"colorscheme base16

" autoswap - change to the tmux pane
let g:autoswap_detect_tmux = 1

" Fix vertical split separator
set fillchars+=vert:│
"autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

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

" vsplit command
nnoremap <localleader>s :vs<cr>

" select all
nnoremap <C-a> ggVG

" vim-jsx Config
let g:jsx_ext_required = 0

" wildignore config (was part of CtrlP previously)
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/node_modules/*

" fzf.vim config
nnoremap <silent><C-p> :GFiles<CR>

" netrw Config
let g:netrw_banner=0       " disable banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()

" Wildmenu
if has("wildmenu")
	set wildignore+=*.a,*.o
	set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
	set wildignore+=.DS_Store,.git,.hg,.svn
	set wildignore+=*~,*.swp,*.tmp
	set wildmenu
	set wildmode=list:longest,full
endif

" Undo Tree
nnoremap <localleader>u :UndotreeToggle<cr>

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

" Open file under cursor in a vertical split
nnoremap <C-W><C-F> <C-W>vgf

" Add fzf to runtime path
"set rtp+=/usr/local/opt/fzf

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" See https://vi.stackexchange.com/questions/2232/how-can-i-use-vim-as-a-hex-editor
" edit binary files
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
