set nocompatible              " be iMproved, required
filetype off                  " required by vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
Plugin 'VundleVim/Vundle.vim'
" Editorconfig
Plugin 'editorconfig/editorconfig-vim'
" Support for git
Plugin 'tpope/vim-fugitive'
" Searching with :Ack 
Plugin 'mileszs/ack.vim'
" Open files <C-p>
Plugin 'kien/ctrlp.vim'
" Filemanager <F2>
Plugin 'scrooloose/nerdtree'
" Autocompletion?
Plugin 'ervandew/supertab'
" Universal syntax coloring
Plugin 'vim-syntastic/syntastic'
" To get nice look-and-feel
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Makes rading and editing of md files nicer
Plugin 'plasticboy/vim-markdown'
" Sytax highligting specific to perl
Plugin 'vim-perl/vim-perl'
" <leader>T will test my perl code
Plugin 'janko-m/vim-test'
" Shows new/removed/modified lines
Plugin 'airblade/vim-gitgutter'
" Make it like SublimeText Cmd+L - fp on variable, then <C-n>
Plugin 'terryma/vim-multiple-cursors'
call vundle#end()            " required by vundle
filetype plugin indent on    " required by vundle

" call pathogen#infect()
" call pathogen#helptags()

syntax on

" Give a shortcut key to NERD Tree
map <F2> :NERDTreeToggle<CR>

" use visual bell instead of beeping
" set vb

" incremental search
set incsearch

" syntax highlighting
set bg=light
syntax on

" autoindent
autocmd FileType perl set autoindent|set smartindent

" 2 space tabs
autocmd FileType perl set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2

" show matching brackets
autocmd FileType perl set showmatch

" show line numbers
autocmd FileType perl set number

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

" dont use Q for Ex mode
map Q :q

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F11>

" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

" my perl includes pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

" Tidy selected lines (or entire file) with _t:
nnoremap <F5> :%!perltidy -q<Enter>
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>

" Run tidyall1
noremap <silent> _ta :!tidyall -a -q <Enter>


" Deparse obfuscated code
nnoremap <silent> _d :.!perl -MO=Deparse 2>/dev/null<cr>
vnoremap <silent> _d :!perl -MO=Deparse 2>/dev/null<cr>

au BufRead,BufNewFile *.t setfiletype=perl
:au FocusLost * :set number
:au FocusGained * :set relativenumber
colorscheme desert

" Searchinf filed ctrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
" cycle through tabs
nnoremap <C-l> gt
nnoremap <C-h> gT

" Noobs need backspace
set backspace=indent,eol,start

" vim test on save
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Vim-Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

