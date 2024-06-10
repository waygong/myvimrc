set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=C:/my/file/vim/bundle/Vundle.vim/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'vimwiki/vimwiki'
" 修改位置與檔案副檔名
let g:vimwiki_list = [
                        \ {'path'       :'C:/my/file/wiki/markdown',
                        \ 'path_html'   :'C:/my/file/wiki/html',
                        \ 'syntax': 'markdown', 'ext': '.md',
                        \ 'folding': 'syntax',
                        \ }]

Plugin 'preservim/nerdtree'
" 如果文件可修改，則在 NERDTree 中找到並將光標移動到該文件，然後執行 'R' 命令
"" autocmd BufEnter * if &modifiable | NERDTreeFind | NERDTreeFocus | execute "normal R" | wincmd p | set foldmethod=syntax | endif | endif
autocmd BufEnter * if &modifiable | NERDTreeFind | NERDTreeFocus | execute "normal R" | wincmd p | endif
" 資料夾和檔案前綴不要顯示^G
let g:NERDTreeNodeDelimiter = "\u00a0"
" 設定側邊欄寬度
let g:NERDTreeWinSize = 60
" 單擊檔案或資料夾時就開啟
let g:NERDTreeMouseMode = 3

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

" vim 記住上次離開位置
if has("autocmd")
  au BufReadPost * if line("'\'") > 1 && line("'\'") <= line("$") | exe "normal! g'\"" | endif
endif

" vim mapping 打開 vimrc
nnoremap \vv :e C:/my/file/git/myvimrc/.vimrc<CR>

" vim 維持 backspace 刪除功能
set backspace=indent,eol,start

" vim 插入當前時間
nnoremap \tt "=strftime('%Y-%m-%d %H:%M:%S ')<CR>P
inoremap \tt <CR>=strftime('%Y-%m-%d %H:%M:%S ')<CR>P

" vim 高亮
syntax on

" vim 高亮所有搜尋文字
set hlsearch

" vim 執行當前行
nnoremap <F5> :execute '!start /B ' . getline('.')<CR>

" 加入 git 到 vim path (避免部分電腦無法使用 vundle)
let $PATH = $PATH . ';C:\Program Files\Git\cmd'

" vim 顯示相對行號
" set rnu

" vim 顯示行號
set nu

" vimrc 隱藏所有註解
autocmd BufRead,BufNewFile .vimrc setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*\"'

" vim mapping foldmethod 為 syntax
nnoremap \ff :set foldmethod=syntax<CR>

" vim nerotree 設定起始資料夾or檔案
"" autocmd VimEnter * NERDTree C:\my\file\wiki\markdown\
au GUIEnter * silent execute "edit C:\\my\\file\\wiki\\markdown\\index.md | redraw!"

" vim 設定將整row上下移動的快捷鍵 (這方法比 :m .+1 好，因為他可以移動折疊後的 row)
nnoremap <M-Up> :normal ddkP<CR>
nnoremap <M-Down> :normal ddp<CR>

" vim mapping 跳轉or產生年月日的 vimwiki markdown 檔
nnoremap \w\Y :silent! execute "edit C:\\my\\file\\wiki\\markdown\\diary\\" . strftime("%Y\\%Y") . ".md"<CR>
nnoremap \w\M :silent! execute "edit C:\\my\\file\\wiki\\markdown\\diary\\" . strftime("%Y\\%m\\%m") . ".md"<CR>