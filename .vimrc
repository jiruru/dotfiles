" バックアップファイルと一時ファイル設定
if isdirectory(expand('~/.vim/backup'))
  set backupdir=~/.vim/backup
  set directory=~/.vim/backup
endif
set backup
set writebackup     " 上書き前にバックアップ作成
set swapfile

set modelines=0		" CVE-2007-2438
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
set hls

"行末に$で表示
set list  " 不可視文字の可視化
set listchars=eol:$,tab:>\

"clipboard
set clipboard=unnamed,autoselect

set number  "行数
set tabstop=2
set autoindent
set expandtab
:retab
set shiftwidth=2
set cursorline "横のライン
set cursorcolumn "縦のライン

"キーバインド{{{
"括弧入れた後カーソルの位置を中に戻す
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap <> <><Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `' `'<Left>))

"jjでescする
inoremap <silent> jj <ESC>
";を:にする
nnoremap ; :
"}}}

"編集関係
set infercase           " 補完時に大文字小文字を区別しない

"ステータス行を表示
set laststatus=2

"ステータス行の指定
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

"改行時に前の行のインデントを継続する
set autoindent

"vimでマウス操作をを有効にする
set mouse=a
set ttymouse=xterm2

"行末のスペースを保存時に自動的に削除
autocmd BufWritePre * :%s/\s\+$//ge

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

"x キー削除でデフォルトレジスタに入れない
nnoremap x "_x
vnoremap x "_x

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" ファイル指定で開かれた場合はNERDTreeは表示しない
if !argc()
    autocmd vimenter * NERDTree|normal gg3j
endif

" set file type
autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120

" python template
autocmd BufNewFile *.py 0r $HOME/.vim/.template/template.py

" HTML template
autocmd BufNewFile *.html 0r $HOME/.vim/.template/template.html

"nerdcommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"C言語系コメントアウト
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" vundleでneocomplcacheプラグインを管理できるように設定
" vundle
"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"


" Required:
filetype plugin indent off

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
" if_luaが有効ならneocompleteを使う
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'

if neobundle#is_installed('neocomplete')
    " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'
elseif neobundle#is_installed('neocomplcache')

    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


"python
NeoBundle "scrooloose/syntastic"
let g:syntastic_python_checkers = ['python', 'flake8', 'mypy']
NeoBundle 'davidhalter/jedi-vim'

"autocmd FileType python setlocal omnifunc=jedi#completions
"let g:jedi#completions_enabled = 0
"let g:jedi#auto_vim_configuration = 0


"QuickRun設定

  NeoBundleLazy 'thinca/vim-quickrun', {
  \ 'autoload' : {
  \   'mappings' : [['n', '\r']],
  \   'commands' : ['QuickRun']
  \ }}

" quickrun {{{
 let g:quickrun_config = {}
 let g:quickrun_config._ = { 'runner' : 'vimproc',
 \ 'runner/vimproc/updatetime' : 200,
 \ 'outputter/buffer/split' : ':botright 8sp',
 \ 'outputter' : 'multi:buffer:quickfix',
 \ 'hook/close_buffer/enable_empty_data' : 1,
 \ 'hook/close_buffer/enable_failure' : 1,
 \ }
 nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" }}}

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
"racket
NeoBundle 'wlangstroth/vim-racket'

"web用プラグイン
NeoBundle 'mattn/emmet-vim'
NeoBundle 'taichouchou2/surround.vim'
NeoBundle 'open-browser.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'taichouchou2/vim-javascript'

" HTML 5 tags
syn keyword htmlTagName contained article aside audio bb canvas command
syn keyword htmlTagName contained datalist details dialog embed figure
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time
syn keyword htmlTagName contained source figcaption
syn keyword htmlArg contained autofocus autocomplete placeholder min max
syn keyword htmlArg contained contenteditable contextmenu draggable hidden
syn keyword htmlArg contained itemprop list sandbox subject spellcheck
syn keyword htmlArg contained novalidate seamless pattern formtarget
syn keyword htmlArg contained formaction formenctype formmethod
syn keyword htmlArg contained sizes scoped async reversed sandbox srcdoc
syn keyword htmlArg contained hidden role
syn match   htmlArg "\<\(aria-[\-a-zA-Z0-9_]\+\)=" contained
syn match   htmlArg contained "\s*data-[-a-zA-Z0-9_]\+"
NeoBundle 'kchmck/vim-coffee-script'

"Golang plugin
NeoBundle 'vim-jp/vim-go-extra'

"nerdtree
NeoBundle 'scrooloose/nerdtree'
"nerdcommenter
NeoBundle 'scrooloose/nerdcommenter'

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

"インデントに色をつけて見やすくする。
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

"editorCording
NeoBundle 'editorconfig/editorconfig-vim'

" solarized
NeoBundle 'altercation/vim-colors-solarized'

call neobundle#end()

"-------------------------
" End Neobundle Settings.
"-------------------------

set t_Co=256
syntax enable
set background=dark
colorscheme solarized
