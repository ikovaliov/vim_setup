" Fundamentals
" init autocmd
autocmd!

" set script encoding
scriptencoding utf-8

" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set number
syntax on
filetype off
filetype plugin indent on
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
" set relativenumber
set scrolloff=8
set shiftwidth=4
set smartcase
set hlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set expandtab

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

" Ignore case when searching
set ignorecase

" Be smart when using tabs ;)
set smarttab

" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

" Highlights
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

" File types
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
au BufNewFile,BufRead *.fish set filetype=fish

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" For disable error
let g:loaded_perl_provider = 0

" Eslint/Prittier
let js_fixers = ['prettier', 'eslint']

let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': js_fixers,
    \ 'javascript.jsx': js_fixers,
    \ 'typescript': js_fixers,
    \ 'typescriptreact': js_fixers,
    \ 'css': ['prettier'],
    \ 'json': ['prettier'],
    \}

let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_sign_info = "ℹ"
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = "🔥 "

let g:prettier#autoformat_config_present = 1
let g:prettier#config#config_precedence = 'prefer-file'

" NRDTTree
let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pf :Files<CR>
inoremap jk <esc>:w<CR>
nnoremap <C-p> :GFiles<CR>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = ['node_modules']
let NERDTreeStatusLine='NERDTree'

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-t>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+n
function! OpenTerminal()
split term://zsh
resize 10
endfunction
nnoremap <c-t> :call OpenTerminal()<CR>

" Plugins
runtime ./plug.vim

let g:coc_global_extensions = ['coc-stylelint',
\ 'coc-docker',
\ 'coc-svg',
\ 'coc-spell-checker',
\ 'coc-json',
\ 'coc-git',
\ 'coc-emmet',
\ 'coc-tsserver',
\ 'coc-eslint',
\ 'coc-styled-components',
\ 'coc-prettier']

" colors
syntax enable
" set termguicolors
set winblend=0
set wildoptions=pum
set pumblend=5
set background=dark
set colorcolumn=130
highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme gruvbox

" extras
set exrc
"
lua << EOF
require('telescope').setup{
    defaults = { file_ignore_patterns = { "node_modules" }}
}
EOF
