set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
if has('gui_running')
    " gvim 的配置
    set rtp+=C:\my\file\git\Vundle.vim\
else
    " 非 gvim 的配置
    set rtp+=~/.vim/bundle/Vundle.vim/
endif
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
let current_year = strftime("%Y")
let current_month = strftime("%m")
let current_day = strftime("%d")
if has('gui_running')
    let g:vimwiki_list = [
      \ {'path'       :'C:\my\file\wiki\markdown',
      \ 'path_html'   :'C:\my\file\wiki\html',
      \ 'syntax': 'markdown', 'ext': '.md',
      \ 'diary_rel_path': 'diary/'.current_year.'/'.current_month.'/'.current_day,
      \ 'diary_index': "../".current_month,
      \ }]
else
    let g:vimwiki_list = [
      \ {'path'       :'/mnt/c/my/file/wiki/markdown',
      \ 'path_html'   :'/mnt/c/my/file/wiki/html',
      \ 'syntax': 'markdown', 'ext': '.md',
      \ 'diary_rel_path': 'diary/'.current_year.'/'.current_month.'/'.current_day,
      \ 'diary_index': "../".current_month,
      \ }]
endif

Plugin 'preservim/nerdtree'

Plugin 'francoiscabrol/ranger.vim'

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
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" vim mapping 打開 vimrc
if has('gui_running')
    nnoremap \vv :e C:\my\file\git\myvimrc\.vimrc<CR>
else
    nnoremap \vv :e /mnt/c/my/file/git/myvimrc/.vimrc<CR>
endif

" vim 維持 backspace 刪除功能
set backspace=indent,eol,start

" vim 插入當前時間
nnoremap \tt "=strftime('%H:%M ')<CR>P
inoremap \tt <C-R>=strftime('%H:%M ')<CR>

" vim 高亮
syntax on

" vim 高亮所有搜尋文字
set hlsearch

" vim 設定主題
if has('gui_running')
    " colorscheme shine
    colorscheme morning
else
    " colorscheme delek
    colorscheme morning
endif

" 加入 git 到 vim path (避免部分電腦無法使用 vundle)
let $PATH = $PATH . ';C:\Program Files\Git\cmd'

" vim 顯示相對行號
set rnu

" vim 顯示行號
" set nu

" vimwiki mapping 跳轉到日期首頁
nnoremap \dd :VimwikiDiaryIndex<CR>

" vim nerdtree 設定起始資料夾or檔案
if !exists("g:vim_started")
    if has('gui_running')
        au GUIEnter * silent execute "edit C:\\my\\file\\wiki\\markdown\\index.md | redraw!"
    else
        " au VimEnter * silent execute "edit /mnt/c/my/file/wiki/markdown/index.md | redraw!"
    endif
    let g:vim_started = 1
endif

" vim 設定將整row上下移動的快捷鍵 (這方法比 :m .+1 好，因為他可以移動折疊後的 row)
nnoremap <M-Up> :normal ddkP<CR>
nnoremap <M-Down> :normal ddp<CR>

" vim mapping 跳轉or產生年月日的 vimwiki markdown 檔
nnoremap \w\Y :silent! execute "edit C:\\my\\file\\wiki\\markdown\\diary\\" . strftime("%Y\\%Y") . ".md"<CR>
nnoremap \w\M :silent! execute "edit C:\\my\\file\\wiki\\markdown\\diary\\" . strftime("%Y\\%m\\%m") . ".md"<CR>

" 資料夾和檔案前綴不要顯示^G
let g:NERDTreeNodeDelimiter = "\u00a0"
" 設定側邊欄寬度
let g:NERDTreeWinSize = 60
" 單擊檔案或資料夾時就開啟
let g:NERDTreeMouseMode = 3

" vim 存檔時檢查資料夾是否存在，若不存在就自動建立資料夾
augroup Mkdir
    autocmd!
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" markdown 檔設定折疊 & 更新 nerdtree
autocmd BufWinEnter *.md if &modifiable | NERDTreeFind | NERDTreeFocus | endif
" autocmd BufEnter *.md if &modifiable | setlocal foldmethod=syntax | endif

" vimrc 檔自動折疊
autocmd BufRead .vimrc if &modifiable | setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*\"' | execute "normal zM" | endif

" 讓 vim 支援 24 位元的真彩色
set termguicolors

" vimwiki 標題高亮
if has('gui_running')
    autocmd FileType vimwiki highlight VimwikiHeader1 guifg=#FF6347 gui=bold gui=underline
    autocmd FileType vimwiki highlight VimwikiHeader2 guifg=#A52A2A gui=bold gui=underline
    autocmd FileType vimwiki highlight VimwikiHeader3 guifg=#FF8C00 gui=bold gui=underline
    autocmd FileType vimwiki highlight VimwikiHeader4 guifg=#32CD32 gui=bold gui=underline
    autocmd FileType vimwiki highlight VimwikiHeader5 guifg=#40E0D0 gui=bold gui=underline
    autocmd FileType vimwiki highlight VimwikiHeader6 guifg=#BA55D3 gui=bold gui=underline
else
    autocmd FileType vimwiki highlight VimwikiHeader1 ctermfg=196 cterm=bold cterm=underline
    autocmd FileType vimwiki highlight VimwikiHeader2 ctermfg=88 cterm=bold cterm=underline
    autocmd FileType vimwiki highlight VimwikiHeader3 ctermfg=208 cterm=bold cterm=underline
    autocmd FileType vimwiki highlight VimwikiHeader4 ctermfg=82 cterm=bold cterm=underline
    autocmd FileType vimwiki highlight VimwikiHeader5 ctermfg=45 cterm=bold cterm=underline
    autocmd FileType vimwiki highlight VimwikiHeader6 ctermfg=141 cterm=bold cterm=underline
endif

" vimwiki 螢光筆功能
if has('gui_running')
    autocmd FileType vimwiki highlight VimwikiCode guibg=pink
    autocmd FileType vimwiki highlight VimwikiBold guibg=yellow
    autocmd FileType vimwiki highlight VimwikiBoldItalic guibg=lightgreen
    autocmd FileType vimwiki highlight VimwikiLink guibg=lightblue
else
    autocmd FileType vimwiki highlight VimwikiCode ctermbg=217
    autocmd FileType vimwiki highlight VimwikiBold ctermbg=yellow
    autocmd FileType vimwiki highlight VimwikiBoldItalic ctermbg=lightgreen
    autocmd FileType vimwiki highlight VimwikiLink ctermbg=lightblue
endif
nnoremap <leader>1 :let keyword=expand("<cWORD>")<CR>:execute "normal! ciW"."`".keyword."`"<CR>
nnoremap <leader>2 :let keyword=expand("<cWORD>")<CR>:execute "normal! ciW"."**".keyword."**"<CR>
nnoremap <leader>3 :let keyword=expand("<cWORD>")<CR>:execute "normal! ciW"."***".keyword."***"<CR>
nnoremap <leader>4 :let keyword=expand("<cWORD>")<CR>:execute "normal! ciW"."[".keyword."]()"<CR>
vnoremap <leader>1 c`<C-R>"`<Esc>
vnoremap <leader>2 c**<C-R>"**<Esc>
vnoremap <leader>3 c***<C-R>"***<Esc>
vnoremap <leader>4 c[<C-R>"]()<Esc>

" vimwiki 自動縮進&取消縮進
autocmd FileType vimwiki setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType markdown,vimwiki inoremap <buffer> <Tab> <C-o>ma<C-o>I<Space><Space><Esc>`a2l
autocmd FileType markdown,vimwiki inoremap <buffer> <S-Tab> <C-o>ma<C-o>I<BS><BS><Esc>`a2h

" vim 設定字體與大小
set guifont=Consolas:h11

" 在 vim 中打開 ranger
if has('gui_running')
    " 在 gvim 中通過 WSL 啟動 ranger
    " command! Ranger execute 'terminal wsl ranger'
else
    " 使用 :Ranger 命令在 Vim 中打開 ranger
    command! Ranger execute 'Ranger'
endif

" vim 執行當前行
nnoremap <F5> :execute '!start /B ' . getline('.')<CR>

" vim 切換資料夾到當前檔案
nnoremap <F7> :silent! lcd %:p:h<CR>

" vim 開啟當前檔案資料夾
nnoremap <F8> :silent execute '!explorer ' . expand('%:p:h')<CR>

" vim 用 windows 預設程式開啟當前行檔案
"" nnoremap <F9> :silent execute '!start /B ' . getline('.')<CR>

" vimwiki 開啟檔案路徑往前n層相對應的微軟官網文件
function! EchoURL(n)
    let l:file_path = expand('%:p')
    let l:parts = split(l:file_path, '\\')
    let l:url_parts = l:parts[-a:n:]
    let l:url = 'https://learn.microsoft.com/zh-tw/' . join(l:url_parts, '/')
    let l:url = substitute(l:url, '\.md$', '', '') " 移除 .md
    call setreg('+', l:url)
    silent execute '!start ' . l:url
endfunction
nnoremap <F10> :<C-u>call EchoURL(v:count1)<CR>
