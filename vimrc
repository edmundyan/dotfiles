" Pathogen
set nocompatible
filetype off " Pathogen needs to run before plugin indent on
call pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
filetype plugin indent on
filetype on
syntax enable
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" let g:solarized_contrast='high'
" let g:solarized_visibility='normal'
" set background=dark
" colorscheme solarized
" colorscheme Tomorrow-Night
colorscheme tomorrow-night-dcosson

"Simple switching between hard tabs and spaces
command! -nargs=* HardTab setlocal noexpandtab shiftwidth=2
command! -nargs=? SoftTab setlocal expandtab tabstop=<args> shiftwidth=<args> softtabstop=<args>

set number
set et
set sw=2
set smarttab
" set smartindent
set incsearch
set hlsearch
set smartcase
set cursorline
" set cursorcolumn
set title
set ruler
set showmode
set showcmd
set ai " Automatically set the indent of a new line (local to buffer)
set tags=./tags;
set grepprg=ack
set hidden
set noswapfile

" On OSX
" copy paste craziness
nmap <F3> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F3> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

set mouse=a  " enable scroll with mouse wheel
set clipboard=unnamed " yank to clipboard

" Set '\' and ' ' as leader
let mapleader="\\"
:map " " <leader>

" Powerline status line
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'default'
set t_Co=256
set laststatus=2 "show even if window not split
" set statusline=%F%m%r%h%w\ \ \ [TYPE=%Y]\ \ \ [POS=%l,%v][%p%%]" [FORMAT=%{&ff}] %{strftime(\"%d/%m/%y\ -\ %H:%M\")} %F%m%r%h%w

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" cursorline only in active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Python
autocmd FileType python set nosmartindent list shiftwidth=2 softtabstop=2
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
autocmd FileType python nmap ,8 :call Pep8()<CR>
" Ruby
autocmd FileType ruby set expandtab shiftwidth=2 softtabstop=2
autocmd FileType yaml set expandtab shiftwidth=2 softtabstop=2

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html SoftTab 2
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css SoftTab 2
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END


" Custom filetypes
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
au BufRead,BufNewFile {*.less,*.sass} set ft=css
au BufRead,BufNewFile *.us set ft=html "our underscore.js html templates

" don't show binary files in list of files to open
set wildignore+=*.pyc,node_modules/**
set wildignore+=*.compiled.templates.js
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$|venmo_tests/cassettes/.*$',
  \ }
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '__pycache__' ]


" fix backspace in vim 7
:set backspace=indent,eol,start

""" Clipboard
" copy all to clipboard
nmap ,a ggVG"*y
" copy word to clipboard
nmap ,d "*yiw
" copy highlighted to clipboard
vmap ,c "*y
" paste
nmap ,v :set paste<CR>"*p:set nopaste<CR>
nnoremap <F1> :set invpaste paste?<CR>
set pastetoggle=<F1>
set showmode
" underline current line, markdown style
nmap ,u "zyy"zp:.s/./-/g<CR>:let @/ = ""<CR>

" delete inner xml tag
nmap ,dit dt<dT>
nmap ,cit dt<cT>
"
"clear the fucking search buffer, not just remove the highlight
map \c :let @/ = ""<CR>

" Revert the current buffer
nnoremap \r :e!<CR>

"Easy edit of vimrc
nmap \s :source $MYVIMRC<CR>
nmap \v :e $MYVIMRC<CR>

" :runtime! ~/.vim/

" w!! to write with sudo
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Open useful sidebars (taglist, nerdtree)
nnoremap <Leader>w :TlistToggle<CR>
nnoremap <Leader>W :NERDTreeToggle<CR>

" Taglist options
let g:Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 45

" --- GIT
" -----------

" Remove all whitespace in file
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"""
""" Syntastic syntax checking
"""
" status line
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_disable=['py']
let g:syntastic_enable_signs=0 "sign markings (at beginning of line, before line numbers)
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_loc_list=0
let g:syntastic_check_on_open=0
let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225,E302,E702,E126'
" mode info
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['txt', 'go'] }
" key shortcuts
nmap ,e :SyntasticCheck<CR> :Errors<CR>
nmap ,R :!!<CR>

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
noremap <leader>ws :call DeleteTrailingWS()<CR>

"folding settings
" set foldmethod=indent   "fold based on indent
" set foldnestmax=10      "deepest fold is 10 levels
" set foldlevel=1

" --- GIT
" -----------
fun! PullAndRefresh()
  set noconfirm
  bufdo e!
  set confirm
endfun
nmap <Leader>gr call PullAndRefresh()

" --- Vimux commands to run tests
let g:vimux_nose_setup_cmd="vagrant ssh; cd /vagrant"
let g:vimux_nose_options="--nologcapture"
map <Leader>rs :call VimuxRunNoseSetup()<CR>
map <Leader>ri :call VimuxInspectRunner()<CR>
map <Leader>rc :call VimuxCloseRunner()<CR>

map <Leader>ra :call VimuxRunNoseAll()<CR>
map <Leader>rF :call VimuxRunNoseFile()<CR>
map <Leader>rf :call VimuxRunNoseLine()<CR>
map <Leader>rr :call VimuxTogglePane()<CR>


" --- NERDtree
" ------------
let NERDTreeShowHidden=1
let NERDSpaceDelims=1 "Add a space after comment for nerdcommenter


" --- CtrlP
" ------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nmap <Ctrl>P ::CtrlPClearCache<CR>
"
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore "*/*.yaml" -g "" '

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" --- vim-isort
" -----------
let g:vim_isort_map = '<c-i>'
"
" --- vim-multiple-cursors
" -----------
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key = '<C-d>'
let g:multi_cursor_quit_key='<Esc>'

let g:bufExplorerShowRelativePath=1  " Show relative paths.

set visualbell
