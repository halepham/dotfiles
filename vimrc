""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Plugins                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugins will be downloaded under the specified directory. "
call plug#begin('~/.vim/bundle')

" Theme "
Plug 'gmoe/vim-espresso'

" Show indent line "
Plug 'Yggdroot/indentLine'

" File Management "
Plug 'scrooloose/nerdtree'

" Statusline "
Plug 'itchyny/lightline.vim'

" Ctrl + P: Find, move to a File "
Plug 'kien/ctrlp.vim'

" Auto-completion | Syntax & checking"
Plug 'ycm-core/YouCompleteMe'

if has('nvim')
    " Plugin to read or write files with sudo command'.
    Plug 'lambdalisue/suda.vim'
endif

" List ends here. Plugins become visible to Vim after this call. "
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           reset vimrc augroup                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  au!
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         turn on filetype plugins                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Plugin commands!
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            General settings                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8

" Theme "
syntax enable
set nocompatible
set t_Co=256
set background=dark
colorscheme espresso

" Display settings "
set scrolloff=4     " 4 lines above/below cursor when scrolling
" set showmatch     " show matching bracket (briefly jump)
" set showcmd       " show typed command in status bar
set ruler           " show cursor position in status bar
" set title         " show file in titlebar
set cursorline      " highlights the current line
set number          " Display line number

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu

" Editor settings "
set tabstop=4       " number of spaces a tab counts for
set shiftwidth=4    " spaces for autoindents
set softtabstop=4
set shiftround      " makes indenting a multiple of shiftwidth
set expandtab       " turn a tab into spaces
set laststatus=2    " the statusline is now always shown
set noshowmode      " don't show the mode ("-- INSERT --") at the bottom

" Misc settings "
set hidden              " allows making buffers hidden even with unsaved changes
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set autoread            " auto read when a file is changed from the outside
set foldlevelstart=99   " all folds open by default
if has('mouse')
    set mouse=a                 " enables the mouse in all modes
    set mousemodel=popup_setpos " right-click on selection should show up a menu
endif

" toggles vim's paste mode; when we want to paste something into vim from a
" different application, turning on paste mode prevents the insertion of extra
" whitespace
set pastetoggle=<F7>

" Width of a line "
set textwidth=80
set colorcolumn=+1

" This limits the size of the max number of items to show in Vim's popup menu
" (which is used by YouCompleteMe).
set pumheight=10

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as
  " '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif

" When opening a file, go to the last position we were on
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal! g`\"" | endif

" Indent Line configs indentLine_char_list = ['|', '¦', '┆', '┊', '', '']
let g:indentLine_char_list = ['']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              custom mappings                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "."

" Export $MYVIMRC to set neovim init is sourced
let $MYVIMRC='~/.config/nvim/init.vim'

" Fast saving
nnoremap <leader>w :w!<cr>

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
" cnoremap w!! w !sudo tee % >/dev/null
cnoremap w!! w suda://%

" <leader>v brings up .vimrc
" <leader>V reloads it and makes all changes active (file has to be saved first)
noremap <leader>v :e! $MYVIMRC<CR>
noremap <leader>V :source $MYVIMRC<CR>:filetype detect<CR>
            \ :exe ":echo 'vimrc reloaded'"<CR>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" for faster scrolling
noremap <c-j> 15gj
noremap <c-k> 15gk

" This is quit all
noremap <leader>q :qa<cr>
" and quit all without save
noremap <leader>Q :qa!<cr>

" key bindings for quickly moving between windows
" w next, h left, l right, k up, j down
nnoremap <m-w> <C-w>w
nnoremap <m-h> <C-w>h
nnoremap <m-j> <C-w>j
nnoremap <m-k> <C-w>k
nnoremap <m-l> <C-w>l

" Using '<' and '>' in visual mode to shift code by a tab-width left/right by
" default exits visual mode. With this mapping we remain in visual mode after
" such an operation.
vnoremap < <gv
vnoremap > >gv

" TABs to switch files
map <leader>t :tabnext<CR>
map <leader>0 :tablast<CR>
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
" Let 'Alt+[' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <m-[> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 NERDTree                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F2> :NERDTreeToggle<CR><C-w>w

" let NERDTreeMapOpenInTab='<ENTER>'
" Set the working directory to the current file's directory
autocmd BufEnter * lcd %:p:h
" Show NERD tree and move cursor to current file
autocmd VimEnter * NERDTree | call feedkeys("\<C-w>w")
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && 
            \b:NERDTree.isTabTree()) | q | endif

function g:Check2CloseVim()
    if (winnr("$") == 2 && exists("b:NERDTree"))
        exe 'wincmd w'
        if &filetype == "qf"
            q
            if (b:NERDTree.isTabTree())
                q
            endif
        else
            exe 'wincmd p'
        endif
    endif
endfunction

autocmd BufEnter * call Check2CloseVim()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                lightline                                     "
" Currently, wombat, solarized, powerline, powerlineish,                       "
" jellybeans, molokai, seoul256, darcula, selenized_dark,                      "
" Tomorrow, Tomorrow_Night, Tomorrow_Night_Blue,                               "
" Tomorrow_Night_Bright, Tomorrow_Night_Eighties, PaperColor,                  "
" landscape, one, materia, material, OldHope, nord, deus,                      "
" srcery_drk, ayu_mirage and 16color are available.                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:rigel_lightline = 1
let g:lightline = {
            \ 'colorscheme': 'deus',
            \ 'active': {
            \   'left': [
            \             [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ]
            \           ],
            \   'right':[
            \             [ 'lineinfo', 'percent' ],
            \             [ 'linter_warnings', 'linter_errors', 'filetype' ]
            \           ]
            \ },
            \ 'inactive': {
            \   'left': [
            \             [ 'filename' ]
            \           ],
            \   'right':[
            \             [ 'lineinfo' ]
            \           ]
            \ },
            \ 'component_function': {
            \   'readonly':  'LightLineReadonly',
            \   'modified':  'LightLineModified',
            \   'filename':  'LightLineFilename',
            \   'filetype':  'LightLineFiletype',
            \   'mode':      'LightLineMode',
            \   'percent':   'LightLinePercent',
            \   'lineinfo':  'LightLineLineInfo',
            \ },
            \'component_expand': {
            \   'linter_warnings': 'LightlineYcmWarnings',
            \   'linter_errors': 'LightlineYcmErrors'
            \    },
            \'component_type': {
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \ },
            \ 'separator':      { 'left': "\ue0b0", 'right': "\ue0b2" },
            \ 'subseparator':   { 'left': "\ue0b1", 'right': "\ue0b3" },
            \ }

function! LightLineReadonly()
    let fname = expand('%')
    if fname =~ 'NERD_tree'
        return ""
    elseif &filetype == "help" | "qf"
        return ""
    elseif &readonly
        return "\ue0a2"
    else
        return ""
    endif
endfunction

function! LightLineModified()
    let fname = expand('%')
    if fname =~ 'NERD_tree'
        return ""
    elseif &filetype == "help" || "qf"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! LightLineFilename()
    let fname = expand('%')
    let width = winwidth(0) - 50
    let fname_disp = width > strlen(fname) ? fname : fname[ -1 * width : ]
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  '' :
                    \fname =~ 'ControlP' ? '' :
                    \('' != fname ? fname_disp : '[No name]')
endfunction

function! LightLineFiletype()
    let fname = expand('%:t')
    return fname =~ 'NERD_tree' ? '' :
        \ strlen(&filetype) ? &filetype : ''
endfunction

function! LightLineMode()
    let fname = expand('%')
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  'NERDTree' :
                    \fname =~ 'ControlP' ? 'Ctrl-P' :
                    \winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineLineInfo()
    let fname = expand('%:t')
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  '' :
                    \fname =~ 'ControlP' ? '' :
                    \printf("%3d:%-2d", line('.'), col('.'))
                    " line('.') * 100 / line('$'))
endfunction

function! LightLinePercent()
    let fname = expand('%:t')
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  '' :
                    \fname =~ 'ControlP' ? '' :
                    \printf("%3d%%", line('.') * 100 / line('$'))
endfunction

function! LightlineYcmErrors()
    let cnt = youcompleteme#GetErrorCount()
    return cnt > 0 ? string(cnt) . " \ue20c" : ''
endfunction

function! LightlineYcmWarnings()
    let cnt = youcompleteme#GetWarningCount()
    return cnt > 0 ? string(cnt) . " \ue240" : ''
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  ctrlp                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" " let g:ctrlp_map = '<leader>t'
" " nnoremap <leader>n :CtrlPMRU<cr>
" " nnoremap <leader>' :CtrlPClearCache<cr>
" 
" " Use Vim's cwd
" let g:ctrlp_working_path_mode = 0
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'
" 
" " Faster indexing of files; requires having ag (AKA the_silver_searcher)
" " installed.
" let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
"       \ --ignore .git
"       \ --ignore .svn
"       \ --ignore .hg
"       \ --ignore .DS_Store
"       \ --ignore "**/*.pyc"
"       \ --ignore BoostParts
"       \ -g ""'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                YouCompleteMe                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_use_clangd = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 3

" Also see the 'pumheight' vim option!
let g:ycm_max_num_identifier_candidates = 10
let g:ycm_clangd_uses_ycmd_caching = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_show_diagnostics_ui = 1

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" let g:ycm_global_ycm_extra_conf =
"           \ '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

let g:ycm_max_diagnostics_to_display = 0
let g:ycm_error_symbol = '✘'
let g:ycm_warning_symbol = '∆'

let g:ycm_goto_buffer_command = 'new-or-existing-tab'

" Remove <Tab> from the list of keys mapped by YCM.
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_stop_completion = ['<Tab>']

nnoremap <F5> :YcmDiags<cr><C-w>k
nnoremap <leader>y  :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>g :YcmCompleter GoTo<CR>:NERDTreeFocus<CR><C-w>w
nnoremap <m-]> :YcmCompleter GoToDefinition<CR>:NERDTreeFocus<CR><C-w>w
nnoremap <m-}> :YcmCompleter GoToDeclaration<CR>:NERDTreeFocus<CR><C-w>w

" Using <space> at the end to make it more visible and prevent trimming
nnoremap <f6> :YcmCompleter RefactorRename<space>

" " For working with virtual env
" let g:ycm_python_interpreter_path = 'python'
" let g:ycm_python_sys_path = []
" let g:ycm_extra_conf_vim_data = [
"             \  'g:ycm_python_interpreter_path',
"             \  'g:ycm_python_sys_path'
"             \]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                End of file                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
