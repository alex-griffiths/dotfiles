set relativenumber
set rnu
set laststatus=2
set wrap
set linebreak

set updatetime=300

filetype plugin indent on

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point

if executable(s:clip)

    augroup WSLYank

        autocmd!

        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif

    augroup END

endif

" Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

""""""""""
" Plugins
""""""""""
nnoremap <C-n> :NERDTree<CR>

" Always show the sign column otherwise it would shift the text each time
" diagnostics appear/become resolved
if has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" COC Typescript
