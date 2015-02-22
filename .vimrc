"{{{ PLUGINS

call plug#begin('~/.vim/plugged')

"Status line
Plug 'itchyny/lightline.vim'

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
Plug 'altercation/vim-colors-solarized'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'paradigm/TextObjectify'
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'sjl/gundo.vim'
Plug 'vim-scripts/javacomplete'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'flazz/vim-colorschemes'
Plug 'szw/vim-ctrlspace'
Plug 'Lokaltog/vim-easymotion'
" Swaps two regions of texts
Plug 'tommcdo/vim-exchange'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
Plug 'maxbrunsfeld/vim-yankstack'

" tpope plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

call plug#end()

"}}}

"{{{ SETTINGS

" Plugins, indents loaded automatically based on filetype
filetype plugin indent on
" Line numbers
set number
" Get rid of gui stuff for gvim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right scrollbar
set go-=L "remove left scrollbar
" Always display status line
set laststatus=2
" Highlight match while typing search
set incsearch
" Set default folding to be with markers (three curly braces)
set foldmethod=marker
" Command line two lines high
set cmdheight=2
" Switch on syntax highlighting
syntax enable
set autoindent
" Makes backspace make normally
set backspace=2
" Searching
set ignorecase
set smartcase
" When I close a tab, remove the buffer
set nohidden
" Vim, not Vi
set nocompatible
" Show commands, extra information
set showcmd
" Spaces instead of tabs
set expandtab
set smarttab
" Use four spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Keep at least 5 lines above/below cursor
set scrolloff=5
set history=200
set undolevels=1000
set updatecount=50
" Fast terminal
set ttyfast
set noerrorbells
set shell=bash
set fileformats=unix
" Show matching bracket
set showmatch
" Set backup folder
set backupdir=~/Documents/vim_backups/
set ttimeout
set ttimeoutlen=100
set wildmenu
set autoread
set sessionoptions-=options
" Needs to be done before mapping y, d, c
call yankstack#setup()
" Make Y behave like D and C
nmap Y y$
" Increase font size
"if has("gui_macvim")
set guifont=Menlo\ Regular:h12
"elseif has("gui_gtk2")
    "set guifont=Droid\ Sans\ Mono\ 11
"end
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"


"}}}

"{{{  MAPPINGS

" Change mapleader from \ to ,
let mapleader=","
let maplocalleader=","
 "To make cut/copy/paste work normally
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
cmap <C-v> <C-r><C-o>+
"For mac (command key)
vmap <D-c> "+yi
vmap <D-x> "+c
vmap <D-v> c<ESC>"+p
imap <D-v> <C-r><C-o>+
cmap <D-v> <C-r><C-o>+
" This is totally awesome - remap jj to escape in insert mode.
" You'll never type jj anyway, so it's great!
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap JJ <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>
" Theme rotating!
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>
" Edit vimrc in new tab
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>
" New Tab
nnoremap <silent> <C-t> :tabnew<CR>
" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
" Space will toggle folds
nnoremap <space> za
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz
" Window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Change vertical split to horizontal split
map <F9> <C-w>t<C-w>K
" Change horizontal split to vertical split
map <F10> <C-w>t<C-w>H
" Map new tab
map <D-t> :tabe<CR>

"}}}

"{{{  PLUGIN SETTINS

" Gundo
nnoremap <F3> :GundoToggle<CR>
let g:gundo_close_on_revert=1
" Easymotion
nmap s <Plug>(easymotion-s2)
" Javacomplete
if has("autocmd")
  autocmd Filetype java setlocal omnifunc=javacomplete#Complete
  autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
endif
" Yankstack
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
" Solarized
let g:solarized_termcolors=256
colorscheme solarized
set background=dark
" Latex-Box
let g:LatexBox_viewer="open /Applications/Preview.app"

"}}}

"{{{ MISC

" Column at 80 characters
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
" Autocomplete for html
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" Theme rotating!
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
  	let colorstring = "inkpot#solarized#jelleybeans#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
  	let x = match( colorstring, "#", g:themeindex )
  	let y = match( colorstring, "#", x + 1 )
  	let g:themeindex = x + 1
  	if y == -1
     	let g:themeindex = 0
  	else
     	let themestring = strpart(colorstring, x + 1, y - x - 1)
     	return ":colorscheme ".themestring
  	endif
   endwhile
endfunction

"}}}

"{{{ AUTO COMMANDS

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

"}}}

"{{{ FUNCTIONS

" Functions to adjust font size
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

"}}}

"{{{ LIGHTLINE

let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

"}}}
