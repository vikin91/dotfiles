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

" disable scaning included files during autocompletion for perl i
" reason: scanning takes too long
augroup PerlSettings
    autocmd!
    autocmd FileType perl setlocal complete-=i
augroup END

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

au BufRead,BufNewFile *.t setfiletype=perl
au FocusLost * :set number
au FocusGained * :set relativenumber
