set modelines=0		" CVE-2007-2438
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
:syntax on "色:

set number  "行数
"set list listchars=tab:\¦\ "tab 縦線
":set tabstop=2 "tab幅
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2
:set cursorline "横のライン
set cursorcolumn "縦のライン
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
"改行時に前の行のインデントを継続する
set autoindent
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

call neobundle#end()

"-------------------------
" End Neobundle Settings.
"-------------------------
