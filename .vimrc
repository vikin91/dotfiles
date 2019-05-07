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
" Vim-Go
Plugin 'fatih/vim-go'
" Searching with :Ack
Plugin 'mileszs/ack.vim'
" Fuzzy searcher
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Filemanager <F2>
Plugin 'scrooloose/nerdtree'
" Autocompletion
Plugin 'ervandew/supertab'
" Nice look-and-feel
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
" Makes reading and editing of MD files nicer
Plugin 'plasticboy/vim-markdown'
" Sytax highligting specific to perl
Plugin 'vim-perl/vim-perl'
" <leader>T will test my perl code
Plugin 'janko-m/vim-test'
" Shows new/removed/modified lines
Plugin 'airblade/vim-gitgutter'
" Select and replace all occurences of word under cursor - fp on variable, then <C-n>
Plugin 'terryma/vim-multiple-cursors'
" Universal syntax checking - Replaced with w0rp.ale
" Plugin 'vim-syntastic/syntastic'
" Linting for multiple languages
Plugin 'w0rp/ale'
" Tab9 - https://tabnine.com/ - ML-based autocompleter - non-free
" Plugin 'zxqfl/tabnine-vim'
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

" Incremental search - while typing
set incsearch

" syntax highlighting
set bg=dark
syntax on

" fzf mappings
nmap <C-p> <ESC>:FZF<CR>

" Paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F11>

" Dont use Q for Ex mode
map Q :q

" Make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" Cycle through buffers with C-BS
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

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

" Commenting
map ,# :s/^/#/ <BAR> :noh <CR>
map ,/ :s/^/\/\// <BAR> :noh <CR>
map ," :s/^/\"/ <BAR> :noh <CR>
map ,% :s/^/%/ <BAR> :noh <CR>
map ,c :s/^\/\/\\|^[#"%;]// <BAR> :noh <CR>
" Wrapping comments
map ,* :s/^\(.*\)$/\/\* \1 \*\// <BAR> :noh <CR>
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/ <BAR> :noh <CR>

""""""" PERL
source .vimrc.perl
