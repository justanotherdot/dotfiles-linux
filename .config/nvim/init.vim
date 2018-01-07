" file: .config/nvim/init.vim
" author: Ryan James Spencer

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'atelierbram/Base2Tone-vim'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'idris-hackers/idris-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'owickstrom/neovim-ghci'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

call plug#end()

colo Base2Tone_PoolDark

set clipboard=unnamedplus " System clipboard.
set cmdheight=1
set expandtab
set formatoptions-=o
set grepprg=rg\ --vimgrep
set hidden
set inccommand=nosplit
set mouse=a
set nofoldenable
set nojoinspaces
set nowrap
set ruler
set shiftwidth=2
set softtabstop=2
set tabstop=2
set termguicolors
set visualbell
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildignorecase
set wildmenu
set wildmode=longest,list,full

let $COLORTERM = 'gnome-terminal' "Fix scrolling issues with nvim and gnome-terminal.
let g:NERDSpaceDelims = 1
let g:ghci_command = 'stack repl'
let g:ghci_command_line_options = '--ghci-options="-fobject-code"'
let g:neoformat_try_formatprg = 1
let g:netrw_banner = 0
let mapleader = ','
let g:fzf_colors =
 \ { 'fg':      ['fg', 'Normal'],
   \ 'bg':      ['bg', 'Normal'],
   \ 'hl':      ['fg', 'Comment'],
   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
   \ 'hl+':     ['fg', 'Statement'],
   \ 'info':    ['fg', 'PreProc'],
   \ 'prompt':  ['fg', 'Conditional'],
   \ 'pointer': ['fg', 'Exception'],
   \ 'marker':  ['fg', 'Keyword'],
   \ 'spinner': ['fg', 'Label'],
   \ 'header':  ['fg', 'Comment'] }

cnoremap w!! w !sudo tee > /dev/null %
nnoremap <A-;> ,
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <C-k> :Buffers<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-_> :BLines<CR>
nnoremap <leader><leader> :noh<CR>
nnoremap <leader>f :%Neoformat<CR>
nnoremap <leader>f :Rg!<CR>
nnoremap <leader>m :Neomake<CR>
nnoremap <leader>s :StripWhitespace<CR>
nnoremap [[ :bp<CR>
nnoremap ]] :bn<CR>
tnoremap <leader><ESC> <C-\><C-n>

augroup setup
  au! BufEnter * EnableStripWhitespaceOnSave
  au! BufRead,BufNewFile *.md setocal spell
  au! BufWritePost * Neomake
  au! BufWritePre *.hs Neoformat
  au! FileType gitcommit set tw=72
  au! FileType gitcommit setlocal spell
  au! FileType haskell setlocal formatprg=stylish-haskell
  au! FileType javascript setlocal formatprg=prettier\ --no-semi\ --single-quote\ --trailing-comma\ none
  au! TermOpen * setlocal conceallevel=0 colorcolumn=0
augroup END

command! -bang BLines
  \ call fzf#vim#buffer_lines(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang Lines
  \ call fzf#vim#lines(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang Ag
  \ call fzf#vim#ag(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
