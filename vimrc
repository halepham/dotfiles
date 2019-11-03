"===============================================================================
" PLUGINS
"===============================================================================

" Plugins will be downloaded under the specified directory. "
call plug#begin('~/.vim/bundle')

" Theme "
Plug 'gmoe/vim-espresso'
" Plug 'lifepillar/vim-solarized8'
" Plug 'altercation/vim-colors-solarized'

" Show indent line "
Plug 'Yggdroot/indentLine'

" File Management "
Plug 'scrooloose/nerdtree'

" GUI "
Plug 'itchyny/lightline.vim'

" Syntax & checking "
" Plug 'vim-syntastic/syntastic'
" Plug 'dense-analysis/ale'

" Ctrl + P: Find, move to a File "
Plug 'kien/ctrlp.vim'

" Auto-completion "
Plug 'ycm-core/YouCompleteMe'

" YCM Generator
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" List ends here. Plugins become visible to Vim after this call. "
call plug#end()

"===============================================================================
" CONFIGS
"===============================================================================

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" NERDTree Shortcut-keys"
map <C-e> :NERDTreeToggle<CR>
map <C-w> <C-w>w
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"===============================================================================
" CONFIGS
"===============================================================================

set encoding=utf-8

" Theme "
set nocompatible
filetype off
set t_Co=256
syntax enable
set background=dark
colorscheme espresso

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

"Always show current position
set ruler
" Display line number "
set number
" Highlight current line
set cursorline

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Enabling mouse support "
if has('mouse')
    set mouse=a
endif

" Width of a line "
set textwidth=80
set colorcolumn=+1

" Set width of tab and expand tabs into space "
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" NERDTree configs "
" Set the working directory to the current file's directory
autocmd BufEnter * lcd %:p:h
" Show NERD tree and move cursor to current file
autocmd VimEnter * NERDTree | call feedkeys("\<C-w>w")
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \ b:NERDTree.isTabTree()) | q | endif

" lightline configs "
set laststatus=2
set noshowmode
let g:rigel_lightline = 1
let g:lightline = {
            \ 'colorscheme': 'PaperColor',
            \ }

" Syntastic configs "
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_c_checkers=['gcc', 'make']
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '∆'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '∆'

"YCM Configs"
let g:ycm_use_clangd = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 0
let g:ycm_goto_buffer_command = 'new-or-existing-tab'

" For working with virtual env
let g:ycm_python_interpreter_path = 'python'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
            \  'g:ycm_python_interpreter_path',
            \  'g:ycm_python_sys_path'
            \]
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" let g:ycm_global_ycm_extra_conf =
"           \ '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_max_diagnostics_to_display = 0

" Indent Line configs indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char_list = ['┊']

