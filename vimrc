""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Plugins                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugins will be downloaded under the specified directory. "
call plug#begin('~/.vim/bundle')

" Theme "
Plug 'gmoe/vim-espresso'
Plug 'nanotech/jellybeans.vim'
Plug 'ajmwagar/vim-deus'
Plug 'dracula/vim'
Plug 'rakr/vim-one'
Plug 'BarretRen/vim-colorscheme'
Plug 'sainnhe/edge'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'sainnhe/gruvbox-material'
Plug 'ayu-theme/ayu-vim'

" Show indent line "
Plug 'Yggdroot/indentLine'

" displays tags in a window
Plug 'majutsushi/tagbar'

" File Management "
Plug 'scrooloose/nerdtree'

" Statusline "
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" Ctrl + P: Find, move to a File "
Plug 'kien/ctrlp.vim'

" Automatically append closing characters
Plug 'jiangmiao/auto-pairs'

" Language Server Protocol "
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto-completion | Syntax & checking "
" Plug 'ycm-core/YouCompleteMe'
" Plug 'Valloric/ListToggle'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

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
" set background=light
set background=dark

if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" hide cursor line when focus in on other window
" https://stackoverflow.com/questions/14068751/how-to-hide-cursor-line-when-focus-in-on-other-window-in-vim
" Set colorscheme after VimEnter
" https://www.reddit.com/r/neovim/comments/8lt2ot/colorscheme_not_loading_from_vimrc/dzk1l0e/
augroup CursorLine
    au!
    au VimEnter     * setlocal cursorline
    au WinEnter     * setlocal cursorline
    au BufWinEnter  * setlocal cursorline
    au WinLeave     * setlocal nocursorline
augroup END

" colorscheme espresso
"""""""""""""""""""""""""""""""""""""""
" colorscheme jellybeans
"""""""""""""""""""""""""""""""""""""""
" colorscheme deus
"""""""""""""""""""""""""""""""""""""""
" colorscheme dracula
"""""""""""""""""""""""""""""""""""""""
" let g:one_allow_italics = 1
" colorscheme one
"""""""""""""""""""""""""""""""""""""""
let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 0
let g:edge_lightline_disable_bold = 1
colorscheme edge
"""""""""""""""""""""""""""""""""""""""
" colorscheme PaperColor
"""""""""""""""""""""""""""""""""""""""
" let g:quantum_black=1
" let g:quantum_italics=1
" colorscheme quantum
"""""""""""""""""""""""""""""""""""""""
" " available values: 'hard', 'medium'(default), 'soft'
" let g:gruvbox_material_background = 'soft'
" colorscheme gruvbox-material
"""""""""""""""""""""""""""""""""""""""
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

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

" Search configuration
set ignorecase      " ignore case when searching
set smartcase       " turn on smartcase

" Editor settings "
" set showtabline=2
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

" [COC issues] Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
"
" always show signcolumns
set signcolumn=yes

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
set splitbelow
set splitright

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

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

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

" Resize window
nnoremap + <C-W>+
nnoremap - <C-W>-
nnoremap < <C-W><
nnoremap > <C-W>>

" let g:python3_host_prog = '/usr/bin/python3'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Indent Line                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:indentLine_color_term = 100
" let g:indentLine_bgcolor_term = 330
let g:indentLine_color_gui = '#4c4c4c'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_concealcursor=""
let g:indentLine_leadingSpaceChar = '.'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_char_list = ['|', '¦', '┆', '┊', '']
let g:indentLine_char_list = ['┆']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Tagbar                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F3> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 NERDTree                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F2> :NERDTreeToggle<CR><C-w>w

" let NERDTreeMapOpenInTab='<ENTER>'
" let g:NERDTreeWinPos = "right"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp', '\.git',
                \   'node_modules', 'venv', '.ccls-cache']
" Set the working directory to the current file's directory
autocmd BufEnter * lcd %:p:h
" Show NERD tree and move cursor to current file
autocmd VimEnter * NERDTree | call feedkeys("\<C-w>w")
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                lightline                                     "
" colorscheme: wombat, solarized, powerline, powerlineish,                     "
"              jellybeans, molokai, seoul256, darcula, selenized_dark,         "
"              Tomorrow, Tomorrow_Night, Tomorrow_Night_Blue, gruvbox-material,"
"              Tomorrow_Night_Bright, Tomorrow_Night_Eighties, PaperColor,     "
"              landscape, one, materia, material, OldHope, nord, deus,         "
"              srcery_drk, ayu_mirage, 16color, edge, espresso, quantum        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
            \ 'colorscheme': 'edge',
            \ 'active': {
            \   'left': [
            \             [ 'readonly', 'mode', 'paste' ],
            \             [ 'gitbranch', 'filename', 'modified' ]
            \           ],
            \   'right':[
            \             [ 'lineinfo' ],
            \             [ 'linter_errors', 'linter_warnings',
            \               'filetype', 'linter_ok' ]
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
            \   'gitbranch': 'LightLineGit',
            \ },
            \'component_expand': {
            \  'linter_checking': 'lightline#ale#checking',
            \  'linter_warnings': 'lightline#ale#warnings',
            \  'linter_errors': 'lightline#ale#errors',
            \  'linter_ok': 'lightline#ale#ok',
            \    },
            \'component_type': {
            \  'linter_checking': 'left',
            \  'linter_warnings': 'warning',
            \  'linter_errors': 'error',
            \ },
            \ 'separator':      { 'left': "\ue0b0", 'right': "\ue0b2" },
            \ 'subseparator':   { 'left': "\ue0b1", 'right': "\ue0b3" },
            \ }
            "   'linter_warnings': 'LightlineYcmWarnings',
            "   'linter_errors': 'LightlineYcmErrors'

nnoremap <F5> :call lightline#update()<CR>

function! LightLineReadonly()
    let fname = expand('%')
    if fname =~ 'NERD_tree'
        return ""
    elseif &filetype == "help" || "qf" || "tagbar"
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
    elseif &filetype == "help" || "qf" || "tagbar"
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
                    \&filetype =~ 'vim-plug' ? '' :
                    \&filetype =~ 'tagbar' ? '' :
                    \('' != fname ? fname_disp : '[No name]')
    endif
endfunction

function! LightLineFiletype()
    let fname = expand('%:t')
    return fname =~ 'NERD_tree' ? '' :
        \ &filetype =~ 'vim-plug' ? '' :
        \ &filetype =~ 'tagbar' ? '' :
        \ strlen(&filetype) ? &filetype : ''
endfunction

function! LightLineMode()
    let fname = expand('%')
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  'NERDTree' :
                    \&filetype =~ 'vim-plug' ? 'Vim-Plug' :
                    \&filetype =~ 'tagbar' ? 'Tagbar' :
                    \fname =~ 'ControlP' ? 'Ctrl-P' :
                    \winwidth(0) > 60 ? lightline#mode() : ''
    endif
endfunction

function! LightLineLineInfo()
    let fname = expand('%:t')
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  '' :
                \fname =~ 'ControlP' ? '' :
                \&filetype =~ 'vim-plug' ? '' :
                \&filetype =~ 'tagbar' ? '' :
                \printf("%3d%% \ue12f  %3d/%d \ue0a1 : %2d",
                \line('.') * 100 / line('$'),
                \line('.'), line('$'), col('.'))
    endif
endfunction

function! LightLineGit()
    let fname = expand('%:t')
    let branchname = gitbranch#name()
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  '' :
                \fname =~ 'ControlP' ? '' :
                \&filetype =~ 'vim-plug' ? '' :
                \&filetype =~ 'tagbar' ? '' :
                \strlen(branchname) > 0 ? "\ue0a0" . branchname : ''
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ALE                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fix files on save
let g:ale_fix_on_save = 1

" lint after 500ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 500

" use nice symbols for errors and warnings
let g:ale_sign_error = '▸▸'
let g:ale_sign_warning = '--'

" fixer configurations
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \}

let g:ale_linters = {
            \   'c': ['ccls'],
            \   'cpp': ['ccls'],
            \   'vim': ['vint'],
            \   'bash': ['language-server']
            \}

let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'

let g:lightline#ale#indicator_warnings = "! "
let g:lightline#ale#indicator_errors = "✗ "
let g:lightline#ale#indicator_ok = ""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  ctrlp                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim's cwd
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'

" Faster indexing of files; requires having ag (AKA the_silver_searcher)
" installed.
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .ccls-cache
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore BoostParts
      \ -g ""'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  COC.nvim                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC init
let g:coc_global_extensions = [
            \   'coc-snippets',
            \   'coc-ccls',
            \   'coc-sh',
            \   'coc-vimlsp',
            \   ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `g[` and `g]` to navigate diagnostics
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use ? to show documentation in preview window
nnoremap <silent> ? :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,c,cpp,python setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd CursorMovedI * if &previewwindow != 1 | pclose | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                End of file                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
