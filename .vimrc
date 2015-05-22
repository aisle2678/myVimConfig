"To insert space characters whenever the tab key is pressed
"With this option set, if you want to enter a real tab character use Ctrl-V<Tab>
set expandtab
"To control the number of space characters that will be inserted when the tab key is pressed
set tabstop=4
set shiftwidth=4
"autoindent
set autoindent
"set line number
set nu
"searching starts after you enter the string and highlight the search result
set incsearch
set hlsearch
" do not use vi's keyboard mode, use vim's
set nocompatible 
"history log max lines
set history=400
"set default decode mode
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"这条命令会在vim的光标所在行上标记为一条横线
"set cursorline
"highlight CursorLine guibg=lightblue ctermbg=lightgray
"侦测文件类型
"filetype on
filetype plugin on
"filetype indent on

"turn off default ctrl-j
"let g:BASH_Ctrl_j = 'off'

"多种颜色的括号
"func! s:rainbow_parenthsis_load()
"	call rainbow_parenthsis#LoadSquare ()
"	call rainbow_parenthsis#LoadRound ()
"	call rainbow_parenthsis#Activate ()
"endfunc
"au Syntax csc call s:rainbow_parenthsis_load()

"在状态行上显示光标所在位置的行号和列号 
set ruler
"set command window size
set cmdheight=2
"我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{strftime(\"%m/%d\ %H:%M\")}
set laststatus=2 statusline=%<%F\ %1*%m%*%{strftime('%c',getftime(expand('%:p')))}%=%-10(%3l,%2c%V%)%25(%L\ lines\ --%P--%)
"Bbackspace and cursor keys wrap to
set whichwrap+=h,l


"keep my lines 110 chars at most
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

"map all the alt combination keys with <ESC>
let c='a'
while c <= 'z'
exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=50 "a crucial setting let us distinguish combination and seperate key press

"set the width of the NERDTree window
"let g:NERDTreeWinSize=20
"NERDTree auto start
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror
"autocmd VimEnter * wincmd w

"vim's built-in netrw
"let g:netrw_banner          = 0
"let g:netrw_keepdir         = 0
"let g:netrw_liststyle       = 1 " or 3
"let g:netrw_sort_options    = 'i'
"autocmd VimEnter * if !argc() | Explore | endif

"YCM global config file
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

"pathogen vim plugin manager
execute pathogen#infect()

"the number of context lines you would like to see above and below the cursor
set scrolloff=3


"Function list
:map <F2> :TlistToggle<CR>

"folding settings
set foldmethod=indent "fold based on indent
set foldnestmax=10  "deepest fold is 10 levels
set nofoldenable    "dont fold by default
set foldlevel=1     "this is just what i use


"My own copy function
set mouse=a
let g:mymousemode = 0
nnoremap <silent> ff :silent call SetMouseToggle()<CR>
func! SetMouseToggle()
    if g:mymousemode
        let g:mymousemode = 0
        set mouse=a
        set nu
    else
        let g:mymousemode = 1
        set mouse=
        set nonu
        TlistClose
    endif
endfunction

"按v在可视模式下选中目标，然后按s，可以半自动全文替换"
: vnoremap s y:%s/<C-R>=escape(@", '\\/.*$^~[]')<CR>/

"在处理未保存或只读文件的时候，弹出确认 
set confirm

"输入:set list命令是应该显示些啥？
set listchars=trail:·,extends:»,precedes:«,eol:$
hi NonText    ctermfg=247 guifg=#a73111 cterm=bold gui=bold
hi SpecialKey ctermfg=77  guifg=#654321

"生成ctags的命令
"map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>"

"Generate cscope file
map <F8> :!find . -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.s" > cscope.files;cscope -q -R -b -i cscope.files .<CR>"
"autoload cscopes files
function! LoadCscope()
let db = findfile("cscope.out", ".;")
if (!empty(db))
let path = strpart(db, 0, match(db, "/cscope.out$"))
set nocscopeverbose " suppress 'duplicate connection' error
exe "cs add " . db . " " . path
set cscopeverbose
endif
endfunction
au BufEnter /* call LoadCscope()"


"startup function for C file
autocmd Filetype c call C_File_Func()
function C_File_Func()
    "To change all the existing tab characters to match the current tab settings
    retab
    "Use current tab config to reindent whole file
    normal gg=G
endfunction
