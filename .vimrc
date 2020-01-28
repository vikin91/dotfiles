set nocompatible              " be iMproved, required
filetype off                  " required by vundle

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/bin/fzf
call vundle#begin()
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
Plugin 'VundleVim/Vundle.vim'
Plugin 'SpellCheck'
" Editorconfig
Plugin 'editorconfig/editorconfig-vim'
" Support for git
Plugin 'tpope/vim-fugitive'
" Searching with :Ack
" Plugin 'mileszs/ack.vim'
" Vim-Go
Plugin 'fatih/vim-go'
Plugin 'mileszs/ack.vim'
" Fuzzy searcher
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Filemanager <F2>
Plugin 'scrooloose/nerdtree'
" Autocompletion?
Plugin 'ervandew/supertab'
" Universal syntax coloring
" Plugin 'vim-syntastic/syntastic'
" To get nice look-and-feel
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
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
" Linting for multiple languages
Plugin 'w0rp/ale'
" Tab9 - https://tabnine.com/
" Plugin 'zxqfl/tabnine-vim'
" Plugin to colorize ngix config files
Plugin 'chr4/nginx.vim'
call vundle#end()            " required by vundle
filetype plugin indent on    " required by vundle

syntax on
" This prevents performance degradation when handling extreemely long lines faster
set synmaxcol=120

" Enable spellcheck for particular types of files
setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.md setlocal spell
" Auto spell-check for git commit messages
autocmd FileType gitcommit setlocal spell
" Autocompletion - press CTRL-N or CTRL-P in insert-mode to complete the word we’re typing!
set complete+=kspell


" Highlight abandoned spaces at the end of the lines http://vim.wikia.com/wiki/Highlight_unwanted_spaces
set hlsearch
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Allow to search for / without escaping
command! -nargs=1 Ss let @/ = <q-args>

" Give a shortcut key to NERD Tree
map <F2> :NERDTreeToggle<CR>

" use visual bell instead of beeping
" set vb

" incremental search
" set incsearch

" syntax highlighting
set bg=dark
syntax on

" autoindent
autocmd FileType perl set autoindent|set smartindent

" 2 space tabs
autocmd FileType perl set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2

" show matching brackets
autocmd FileType perl set showmatch

" show line numbers
autocmd FileType perl set number

" fzf mappings
nmap <C-p> <ESC>:FZF<CR>
" nmap ; :Buffers<CR>
" nmap <Leader>t :Files<CR>
" nmap <Leader>r :Tags<CR>

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

" disable scaning included files during autocompletion for perl i
" reason: scanning takes too long
augroup PerlSettings
    autocmd!
    autocmd FileType perl setlocal complete-=i
augroup END

" dont use Q for Ex mode
map Q :q

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
" nmap <tab> I<tab><esc>
" nmap <s-tab> ^i<bs><esc>

" paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F11>

" my perl includes pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

"define :Tidy command to run perltidy on visual selection || entire buffer"
command Tidy !perltidy -q

" Tidy selected lines (or entire file) with _t:
nnoremap <F5> :%!perltidy -q<Enter>
nnoremap <silent> <leader>p :%!perltidy -q<Enter>
vnoremap <silent> <leader>p :!perltidy -q<Enter>

" Run tidyall
noremap <silent> _ta :!tidyall -a -q <Enter>

" Cycle through buffers with C-BS
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

au BufRead,BufNewFile *.t setfiletype=perl
:au FocusLost * :set number
:au FocusGained * :set relativenumber
colorscheme desert

" Searchinf filed ctrlP
" set runtimepath^=~/.vim/bundle/ctrlp.vim
" cycle through tabs
noremap <C-l> gt
noremap <C-h> gT
" Configure iterm2 to use CMD+Backspace to cycle with <C-h>: Send hex Codes 0x1B 0x08

" Noobs need backspace
set backspace=indent,eol,start

" vim test on save
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>v :TestNearest -v<CR>
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

" Airline config
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
" Enable after reconfiguring iTerm to use Powerline fonts
let g:airline_powerline_fonts = 1

" Mouse drag can resize splits
" set mouse=n
" Mouse for scrolling =a
" Mouse setting to enable copying from iterm2 =
set mouse=

" Commenting
map ,# :s/^/#/ <BAR> :noh <CR>
map ,/ :s/^/\/\// <BAR> :noh <CR>
map ," :s/^/\"/ <BAR> :noh <CR>
map ,% :s/^/%/ <BAR> :noh <CR>
map ,c :s/^\/\/\\|^[#"%;]// <BAR> :noh <CR>
" Wrapping comments
map ,* :s/^\(.*\)$/\/\* \1 \*\// <BAR> :noh <CR>
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/ <BAR> :noh <CR>

" Fancy fonts for VIM status bar. Src: https://github.com/gabrielelana/awesome-terminal-fonts/tree/patching-strategy
let g:Powerline_symbols = 'fancy'
let g:Powerline_dividers_override = [[0xe0b0], [0xe0b1], [0xe0b2], [0xe0b3]]
let g:Powerline_symbols_override = {
  \ 'BRANCH': [0xe238],
  \ 'RO'    : [0xe0a2],
  \ 'FT'    : [0xe1f6],
  \ 'LINE'  : [0xe0a1],
\ }

