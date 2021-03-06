

" misc


set mouse-=a
syntax on
set number
set autoread

set tabstop=4
set shiftwidth=4
set expandtab

set exrc
set secure

set hidden

cnoremap w!! w !sudo tee %

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

noremap <C-u> 3<C-u>
noremap <C-d> 3<C-d>

" windows encoding switch
map <S-w> :e ++enc=cp1251<CR>

" auto yank to clipboard
autocmd TextYankPost * if v:event.operator ==# 'y' | :let @+ = @" | endif

" save opened buffers
"exec 'set viminfo=%,' . &viminfo


" make


noremap <C-m>a :make!<CR>
noremap <C-m>c :make! clean<CR>
noremap <C-m>w :w \| make!<CR>
noremap <C-m>r :make! 
noremap <C-m>i :w \| make! 
noremap <C-m>l :silent! :copen<CR>
noremap <C-m>t :UpdateTags -R 
noremap <C-m>b :let @+ = 'b ' . expand('%:t') . ':' . line('.')<CR>
"noremap <C-m>b :let @+ = 'b ' . expand('%:p') . ':' . line('.')<CR>


" fzf.vim


noremap <C-f> <CR>
noremap <C-f>f :Files<CR>

noremap <C-f>j :BTags<CR>

noremap <C-f>t yiw \| :Tags <C-r>"<CR>
noremap <C-f>T :Tags<CR>

noremap <C-f>b :Buffers<CR>
noremap <C-f>m :!mc<CR>

noremap <C-f>a yiw \| :Ag <C-r>"<CR>
noremap <C-f>A :Ag<CR>

noremap <C-f>l :BLines<CR>


" clang


function! Formatonsave()
  let l:formatdiff = 1
  pyf /usr/share/clang/clang-format.py
endfunction
"autocmd BufWritePre *.h,*.hpp,*.cc,*.cpp call Formatonsave()


" swp directory


set backupdir=~/.vim/
set directory=~/.vim/
set undodir=~/.vim/


" completion


set wildmode=list,full
set wildmenu


" netrw setup


let g:netrw_banner = 0
let g:netrw_liststyle = 3


" YCM


let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_max_diagnostics_to_display = 1000
let g:ycm_confirm_extra_conf = 0
highlight YcmErrorSection guibg=#000000


" ctrlsf


let g:ctrlsf_position = 'right'
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
noremap <C-c>s yiw \| :CtrlSF <C-r>"<CR>


" airline-themes


let g:airline_theme='base16_google'


" fugitive


set previewheight=30


" Nerdtree


nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>


" easytags


let g:easytags_file = '~/.vim/' . fnamemodify('tags', ':p:gs?/?=?')
let g:easytags_async = 1
let g:easytags_auto_highlight = 0


" vim-plug


call plug#begin('~/.vim/plugged')

" code support

Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Plug 'vim-scripts/Conque-GDB'

" tags managment

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" refactoring

Plug 'dyng/ctrlsf.vim'

" git

Plug 'tpope/vim-fugitive'

" misc

Plug 'tpope/vim-surround'

Plug 'qpkorr/vim-bufkill'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'majutsushi/tagbar'

call plug#end()
