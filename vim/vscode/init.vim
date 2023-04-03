""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Plugins                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugins will be downloaded under the specified directory. "
call plug#begin(stdpath('data') . '/plugged')

Plug 'asvetliakov/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'chaoren/vim-wordmotion'

" List ends here. Plugins become visible to Vim after this call. "
call plug#end()

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Using '<' and '>' in visual mode to shift code by a tab-width left/right by
" default exits visual mode. With this mapping we remain in visual mode after
" such an operation.
vnoremap < <gv
vnoremap > >gv

nnoremap <leader>n :noh<cr>

if exists('g:vscode')
    " Save
    nnoremap ;w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>

    " Close
    nnoremap ;q        <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
    nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeAllEditors')<CR>

    " Undo
    nnoremap u     <Cmd>call VSCodeNotify('undo')<CR>
    nnoremap <C-r> <Cmd>call VSCodeNotify('redo')<CR>

    nnoremap k      <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count1 })<CR>
    nnoremap j      <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count1 })<CR>
    vnoremap k      <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count1 })<CR>
    vnoremap j      <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count1 })<CR>
    nnoremap <Up>   <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count1 })<CR>
    nnoremap <Down> <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count1 })<CR>
    vnoremap <Up>   <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count1 })<CR>
    vnoremap <Down> <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count1 })<CR>

    " key bindings for quickly moving between windows
    " h left, l right, k up, j down
    nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
    nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
    nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
    nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

    nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
endif

