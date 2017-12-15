execute pathogen#infect()
set tags+=~/.vim/tags/cpp_src/tags   " 设置tags搜索路径
syntax on
filetype plugin indent on

map ; :NERDTree<CR>
map m :TlistToggle<CR>

inoremap jj <esc>
" pathongen
execute pathogen#infect()

" taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"

" omnicppcomplete
set completeopt=longest,menu
let OmniCpp_NamespaceSearch = 2     " search namespaces in the current buffer and in included files
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]


set nu






set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
winpos 5 5          " 设定窗口位置  
set lines=30 columns=100  " 设定窗口大小  
set go=             " 不要图形按钮  
set guifont=Courier_New:h10:cANSI   " 设置字体  
syntax on           " 语法高亮  
syntax enable
autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  
set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set novisualbell    " 不要闪烁(不明白)  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)  
set foldenable      " 允许折叠  
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif
" 设置配色方案
colorscheme blue
au Syntax c runtime! syntax/c.vim
au Syntax cpp runtime! syntax/cpp.vim
"字体 
"if (has("gui_running")) 
"set guifont=Bitstream\ Vera\ Sans\ Mono\ 10 
"endif 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
if &filetype == 'sh' 
call setline(1,"\#########################################################################") 
call append(line("."), "\# File Name: ".expand("%")) 
call append(line(".")+1, "\# Author: ma6174") 
call append(line(".")+2, "\# mail: ma6174@163.com") 
call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
call append(line(".")+4, "\#########################################################################") 
call append(line(".")+5, "\#!/bin/bash") 
call append(line(".")+6, "") 
else 
call setline(1, "/*************************************************************************") 
call append(line("."), "	> File Name: ".expand("%")) 
call append(line(".")+1, "	> Author: lzx") 
call append(line(".")+2, "	> Mail: 1726361003 ") 
call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
call append(line(".")+4, " ************************************************************************/") 
call append(line(".")+5, "")
	endif
if &filetype == 'cpp'
call append(line(".")+6, "#include<iostream>")
call append(line(".")+7, "using namespace std;")
call append(line(".")+8, "")
endif
if &filetype == 'c'
call append(line(".")+6, "#include<stdio.h>")
call append(line(".")+7, "")
endif
if &filetype == 'java'
call append(line(".")+6,"public class ".expand("%"))
call append(line(".")+7,"")
endif
	"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行  
"C，C++ 按F5编译运行
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++  % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ -std=c++11 % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'py'
		exec "!python %"
		exec "!python %<"
	endif
endfunc
"C,C++的调试
map e :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc


if exists('b:current_syntax')
  finish
    endif 
        syn match aleFixerComment /^.*$/
	   syn match aleFixerName /\(^\|, \)'[^']*'/
	     syn match aleFixerHelp /^See :help ale-fix-configuration/ 
	        hi def link aleFixerComment Comment
		 hi def link aleFixerName String
		   hi def link aleFixerHelp Statement 
		    let b:current_syntax = 'ale-fix-suggest'
		    
		    
		    
		    
		
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'lightline'
Plugin 'youcompleteme'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set shell=/bin/bash













"ale语法错误检查
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction


let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 1

set statusline=%{LinterStatus()}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


let g:ale_emit_conflict_warnings = 0


if exists('b:current_syntax')
    finish
endif

syn match aleFixerComment /^.*$/
syn match aleFixerName /\(^\|, \)'[^']*'/
syn match aleFixerHelp /^See :help ale-fix-configuration/

hi def link aleFixerComment Comment
hi def link aleFixerName String
hi def link aleFixerHelp Statement

let b:current_syntax = 'ale-fix-suggest'




"synac语法检查
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_checkers = ['cpp','c']

let g:syntastic_aggregate_errors = 1




set laststatus=2
