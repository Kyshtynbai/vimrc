" General settings {{{
set encoding=utf-8
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set fileencoding=utf-8
set nu
set backspace=indent,eol,start
set belloff=all
set directory=~\.vimswap
"" }}}
" Making folding works in .vimrc {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Gui settings  {{{
if has('gui_running')
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
	set guifont=DejaVu\ Sans\ Mono:h12
	set linespace=3
endif
" }}}
" Vundle and plugins {{{	
filetype off " required
filetype plugin indent on    " required
set shellslash
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin('~/vimfiles/bundle')
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'dense-analysis/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nvie/vim-flake8'
Plugin 'sainnhe/sonokai'
Plugin 'mhinz/vim-startify'
call vundle#end()            " required
" }}}
colorscheme sonokai
" Autocompletion and code guidelines {{{
set maxmempattern=2000000
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_python_binary_path='./venv/bin/python'
let g:ycm_extra_conf_vim_data = ['g:ycm_python_interpreter_path', 'g:ycm_python_sys_path']
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
let g:SimpylFold_docstring_preview = 1
augroup code_guidelines
	autocmd!
	au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
	au BufNewFile,BufRead *.js,*.html,*.css set tabstop=2 softtabstop=2 shiftwidth=2
augroup END
syntax on
" }}}
" NerdTREE settings {{{
" Close vim if NERDTree is the only opened buffer:
augroup nerdtree
	autocmd!
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
let NERDTreeHijackNetrw = 0
" }}}

" Variables and file paths
let cheatsheet_path = '$HOME/.cheatsheet'

" Map hotkeys and abbreviations {{{
let maplocalleader=","
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <c-ц> <c-w>
inoremap <c-u> <esc>wbveUea
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>ss :Startify<cr>
nnoremap <leader>ec :vsplit <c-r>=cheatsheet_path<cr><cr>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>lel
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <silent> <leader>h <plug>(YCMHover)
inoremap jk <Esc>
iabbrev @@ imartynow@gmail.com
" }}}
" DOKUWIKI {{{
augroup doku 
	autocmd!
	autocmd FileType text inoremap h1 ======   ======<esc>bhhi
	autocmd FileType text inoremap h2 =====   =====<esc>bhhi
	autocmd FileType text inoremap h3 ====   ====<esc>bhhi
augroup END
" }}}
"Autocommands
"autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
"autocmd FileType python     :iabbrev <buffer> iff if:<left>
func! Siski()
	call popup_notification("Подсказки по клавишам:", 
	\ #{ line: 10, col: 60, highlight: 'WildMenu', close: 'button' } )
endfunc
nnoremap <F1> :call Siski()<cr>
" Переопределение секции airline {{{
" https://stackoverflow.com/questions/73636092/how-to-add-custom-text-to-vi-airline
" https://vi.stackexchange.com/questions/15698/add-custom-section-to-airline
function! StatusLineHelper()
	return 'F1 for keys'
endfunc
call airline#parts#define_function('foo', "StatusLineHelper")
let g:airline_section_y = airline#section#create_right(['ffenc','foo'])
" }}}
