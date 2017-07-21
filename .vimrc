"快捷操作映射
let mapleader=" "
"set encoding="utf-8"
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>wq :wq<CR>
nmap <leader>o :CtrlP<CR>
nmap <leader>ls :ls<CR>
inoremap jj <ESC>
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <c-o>gj
inoremap <c-k> <c-o>gk
"折叠
set fdm=indent
"窗口快捷键映射
nmap <leader>ws <C-w>s
nmap <leader>wv <C-w>v
nmap <leader>wh  <C-w>h
nmap <leader>wj <C-w>j
nmap <leader>wk <C-w>k
nmap <leader>wl <C-w>l


"允许退格删除和tab操作
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set backspace=2
"set textwidth=79
set autoindent
set showmatch


set nocompatible " 关闭vi兼容模式


" Vundle插件管理配置
" Vundle可管理的插件分为三类
" 一直接在vim-scripts仓库里的，格式为Bundle '插件名'
" 二位于github网站上的插件 Bundle '作者名/插件名'
" 三其他插件， Bundle '插件的完整仓库地址(git协议)'
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'  "GUI模式主题
Plugin 'jnurmine/Zenburn' "终端模式主题
Plugin 'Valloric/YouCompleteMe'     "YCM通过Vundle安装完成后还需要到其下载目录下执行./install.py进行编译安装
Plugin 'vim-scripts/indentpython.vim'   "python自动缩进插件
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'plasticboy/vim-markdown' "markdown插件　
Plugin 'Chiel92/vim-autoformat' "格式化查件，是个格式化框架　
Plugin 'Lokaltog/vim-easymotion' "快速跳转
Plugin 'scrooloose/nerdcommenter' "注释插件
call vundle#end()

"主题设置
if has('gui_running')
    set background=dark
    colorscheme solarized
endif

filetype plugin on
syntax on "语法高亮
filetype plugin indent on "依文件类型进行自动缩进

set ruler "状态栏显示行列号
set nu "显示行号
set showcmd "在状态栏显示正在输入的命令
set cursorline "高亮显示当前行
set cursorcolumn "高亮显示当前列
set hlsearch  "高亮显示搜索结果

"状态栏配置，主要通过airline插件实现
set laststatus=2

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"启用tab功能
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>h <Plug>AirlineSelectPrevTab
nmap <leader>l <Plug>AirlineSelectNextTab

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" YouCompleteMe配置
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'   "配置默认的ycm_extra_conf.py
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>   "按jd 会跳转到定义
let g:ycm_confirm_extra_conf=0    "打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_collect_identifiers_from_tag_files = 1 "使用ctags生成的tags文件
let g:ycm_error_symbol='>>'
let g:ycm_warning_symbol='>*'
let g:ycm_sematic_triggers={
            \'javascript':['.','re!(?=[a-zA-Z]{3,4})'],
            \'html':['<','"','</',''],
            \'scss,css':['re!^\s{2,4}','re!:\s+']
            \}
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0


"Syntastic查件配置
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" python 配置
let python_highlight_all=1



" NerdTree配置
nmap <F2> : NERDTreeToggle<CR>
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=1
let g:neocomplcache_enable_at_startup = 1

"Autoformat配置
noremap <F3> :Autoformat<CR>
nnoremap <leader>fa gg=G :retab<CR> :RemoveTrailingSpaces<CR>
"EasyMotion配置
map <Leader>f <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map <Leader>h <Plug>(easymotion-linebackend)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>s <Plug>(easymotion-s)

"NerdCommenter配置
imap <C-c> <plug>NERDCommenterInsert "插入模式进行注释

" 括号引号补全
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function CloseBracket()
	if match(getline(line('.') + 1), '\s*}') < 0
		return "\<CR>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf


" html自动补全
autocmd BufNewFile *  setlocal filetype=html
function! InsertHtmlTag()
	let pat = '\c<\w\+\s*\(\s\+\w\+\s*=\s*[''#$;,()."a-z0-9]\+\)*\s*>'
	normal! a>
	let save_cursor = getpos('.')
	let result = matchstr(getline(save_cursor[1]), pat)
	"if (search(pat, 'b', save_cursor[1]) && searchpair('<','','>','bn',0,  getline('.')) > 0)
	if (search(pat, 'b', save_cursor[1]))
		normal! lyiwf>
		normal! a</
		normal! p
		normal! a>
	endif
	:call cursor(save_cursor[1], save_cursor[2], save_cursor[3])
endfunction
inoremap > <ESC>:call InsertHtmlTag()<CR>a<CR><Esc>O

"<F5>编译与运行
"python
func! RunPython()
    exec "!python %"
endfunc

func! RunDjango()
    exec "!python manage.py runserver"
endfunc

func! Run()
    exec "w"
    if search("manage.py")!=0 && &filetype=="py"
        exec "call RunDjango"
    elseif &filetype=="py"
        exec "call RunPython"
    endif
endfunc

map <F5> :call Run()<CR>
imap <F5> <ESC>:call Run()<CR>
vmap <F5> <ESC>:call Run()<CR>
