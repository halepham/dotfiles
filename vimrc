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
Plug 'itchyny/vim-gitbranch'

" Ctrl + P: Find, move to a File "
Plug 'kien/ctrlp.vim'

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

" hide cursor line when focus in on other window
" https://stackoverflow.com/questions/14068751/how-to-hide-cursor-line-when-focus-in-on-other-window-in-vim
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase

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

let g:python3_host_prog = '/usr/bin/python3'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 NERDTree                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F2> :NERDTreeToggle<CR><C-w>w

" let NERDTreeMapOpenInTab='<ENTER>'
" let g:NERDTreeWinPos = "right"
" Set the working directory to the current file's directory
autocmd BufEnter * lcd %:p:h
" Show NERD tree and move cursor to current file
autocmd VimEnter * NERDTree | call feedkeys("\<C-w>w")
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \b:NERDTree.isTabTree()) | q | endif

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
                    \&filetype =~ 'vim-plug' ? '' :
                    \('' != fname ? fname_disp : '[No name]')
endfunction

function! LightLineFiletype()
    let fname = expand('%:t')
    return fname =~ 'NERD_tree' ? '' :
        \ &filetype =~ 'vim-plug' ? '' :
        \ strlen(&filetype) ? &filetype : ''
endfunction

function! LightLineMode()
    let fname = expand('%')
    if &filetype == "qf"
        return ""
    else
        return fname =~ 'NERD_tree' ?  'NERDTree' :
                    \&filetype =~ 'vim-plug' ? 'Vim-Plug' :
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
                \&filetype =~ 'vim-plug' ? '' :
                \printf("%3d%% \ue12f  %3d/%d \ue0a1 : %2d",
                \line('.') * 100 / line('$'),
                \line('.'), line('$'), col('.'))
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
                \strlen(branchname) > 0 ? "\ue0a0" . branchname : ''
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ALE                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fix files on save
let g:ale_fix_on_save = 1

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 500

" use nice symbols for errors and warnings
let g:ale_sign_error = '▸▸'
let g:ale_sign_warning = '--'

" fixer configurations
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
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
" let g:ycm_use_clangd = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_of_chars_for_completion = 3
" let g:ycm_min_num_identifier_candidate_chars = 3
"
" " Also see the 'pumheight' vim option!
" let g:ycm_max_num_identifier_candidates = 10
" let g:ycm_clangd_uses_ycmd_caching = 1
" let g:ycm_always_populate_location_list = 1
" let g:ycm_show_diagnostics_ui = 1
"
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" " let g:ycm_global_ycm_extra_conf =
" "           \ '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
"
" let g:ycm_max_diagnostics_to_display = 0
" let g:ycm_error_symbol = '▸▸'
" let g:ycm_warning_symbol = '--'
"
" let g:ycm_goto_buffer_command = 'new-or-existing-tab'
"
" let g:ycm_key_list_select_completion = ['<Tab>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>']
" let g:ycm_key_list_stop_completion = ['<Enter>', '<UP>', '<DOWN>' ]
"
" let g:lt_location_list_toggle_map = '<F9>'
" let g:lt_quickfix_list_toggle_map = '<NOP>'
" let g:lt_height = 5
"
" let g:ycm_filetype_whitelist = {
" 			\ "c":1,
" 			\ "cpp":1,
" 			\ "objc":1,
" 			\ "sh":1,
" 			\ "zsh":1,
" 			\ "zimbu":1,
" 			\ "python":1,
" 			\ }
"
" "function! s:CustomizeYcmLocationWindow()
" "  " Move the window to the top of the screen.
" "  wincmd K
" "  " Set the window height to 5.
" "  5wincmd _
" "  " Switch back to working window.
" "  wincmd p
" "endfunction
" "autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()
"
" " nnoremap <F10> :YcmDiags<CR>:lcl<CR>
" nnoremap <leader>y  :YcmForceCompileAndDiagnostics<cr>
" nnoremap <leader>g :YcmCompleter GoTo<CR>:NERDTreeFocus<CR><C-w>p
" nnoremap <m-]> :YcmCompleter GoToDefinition<CR>:NERDTreeFocus<CR><C-w>p
" nnoremap <m-}> :YcmCompleter GoToDeclaration<CR>:NERDTreeFocus<CR><C-w>p
"
" " Using <space> at the end to make it more visible and prevent trimming
" nnoremap <f6> :YcmCompleter RefactorRename<space>
"
" " functions for Lightline
" function! LightlineYcmErrors()
"     let cnt = youcompleteme#GetErrorCount()
"     return cnt > 0 ? string(cnt) . "\ue20c" : ''
" endfunction
"
" function! LightlineYcmWarnings()
"     let cnt = youcompleteme#GetWarningCount()
"     return cnt > 0 ? string(cnt) . "\ue240" : ''
" endfunction
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  COC.nvim                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>af  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                End of file                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
