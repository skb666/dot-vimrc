" Sections:
"    => General
"    => Bundles
"    => Text, tab and indent related
"    => Colors and Fonts
"    => Helper functions
"    => Mappings
"    => Buffers
"    => Conversion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable syntax hightlight and completion
syntax on

" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Editor settings
set history=1000
set tm=2000                        " leader key timeout
set nofoldenable                   " disable folding"
set confirm                        " prompt when existing from an unsaved file
set backspace=indent,eol,start     " more powerful backspacing
set t_Co=256                       " explicitly tell vim that the terminal has 256 colors
set mouse=a                        " use mouse in all modes
set report=0                       " always report number of lines changed
set nowrap                         " dont wrap lines
set scrolloff=5                    " 5 lines above/below cursor when scrolling
set number                         " show line numbers
set showmatch                      " show matching bracket (briefly jump)
set showcmd                        " show typed command in status bar
set title                          " show file in titlebar
set laststatus=2                   " use 2 lines for the status bar
set matchtime=2                    " show matching bracket for 0.2 seconds
set matchpairs+=<:>                " specially for html
set autoread                       " set to auto read when a file is changed from the outside
set lazyredraw                     " don't redraw while executing macros (good performance config)
set magic                          " for regular expressions turn magic on
set foldcolumn=1                   " add a bit extra margin to the left
set backspace=eol,start,indent     " it acts as it should act
set viminfo^=%                     " remember info about open buffers on close
set wildmenu                       " wildmenu
set wildmode=longest,list,full     " tab complete files up to longest unambiguous prefix
set so=7                           " set 7 lines to the cursor - when moving vertically using j/k
set whichwrap+=<,>,h,l

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Turn backup off, since most stuff is in Git anyway...
set nobackup
set nowb
set noswapfile

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible               " be IMproved
filetype off                   " required!

" Enable filetype plugins
filetype plugin on
filetype indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

if filereadable(expand("~/.vim/bundles.vim"))
  source ~/.vim/bundles.vim
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent   " indent when
set tabstop=4     " tab width
set softtabstop=4 " backspace
set shiftwidth=4  " indent width
set expandtab     " expand tab to space
set smarttab

" Linebreak on 500 characters
set lbr
set textwidth=500

autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
set background=dark
try
  colorscheme solarized
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        exe "set cc+=".col_num
    else
        exe "set cc-=".col_num
    endif
endfunc

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cmap w!! %!sudo tee >/dev/null %

" Allow the normal use of "," by pressing it twice
noremap ,, ,

nnoremap ; :
cmap W w
cmap WQ wq
cmap Wq wq
cmap Q q
cmap Qa qa
cmap QA qa

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Fix Escape uncomfortable
inoremap <Esc> <Esc>l
inoremap <c-f> <Esc>lli
inoremap <c-b> <Esc>i

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

nnoremap <leader>hc :call SetColorColumn()<cr>
nnoremap <leader>dt :call DeleteTrailingWS()<cr>

" Force redraw
map <silent> <leader>r :redraw!<CR>

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Disable highlight when <leader><cr> is pressed
" But preserve cursor coloring
map <silent> <leader><cr> :noh<cr>:hi Cursor ctermbg=red guibg=red<cr>

" For macvim
if has("gui_running")
    set go=aAce    " remove toolbar
    set transparency=30
    set guifont=Monaco:h13
    set showtabline=2
    set columns=140
    set lines=40
    noremap <D-M-Left> :tabprevious<cr>
    noremap <D-M-Right> :tabnext<cr>
    map <D-1> 1gt
    map <D-2> 2gt
    map <D-3> 3gt
    map <D-4> 4gt
    map <D-5> 5gt
    map <D-6> 6gt
    map <D-7> 7gt
    map <D-8> 8gt
    map <D-9> 9gt
    map <D-0> :tablast<CR>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete

" Delete trailing whitespace
augroup whitespace
  autocmd!
  autocmd BufWrite *.lua :call DeleteTrailingWS()
  autocmd BufWrite *.pl :call DeleteTrailingWS()
  autocmd BufWrite *.py :call DeleteTrailingWS()
  autocmd BufWrite *.rb :call DeleteTrailingWS()
augroup END

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Limit git commit message length
au FileType gitcommit set tw=72

" Add underline when length exceed 81
au BufRead,BufNewFile *.lua,*.c,*.py,*.sh,*.pl,*.rb,*.erb 2match Underlined /.\%81v/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Conversion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convert symbol to string
nnoremap <silent> <leader>2s F:r"Ea"<ESC>
" Convert string to symbol
nnoremap <silent> <leader>2y F"r:,x

" Convert name to snake_case
nmap <leader>2_ cr_
" Convert name to camelCase
nmap <leader>2c crc
" Convert name to MixedCase
nmap <leader>2m crm
" Convert name to SNAKE_UPPERCASE
nmap <leader>2u cru
" Convert name to dash-case
nmap <leader>2- cr-
