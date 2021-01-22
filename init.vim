
" For HELP: Put the cursor on the word you need help and type <leader>ahw

set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set splitright
set splitbelow
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=50
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Grey column
set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=lightgrey

"---------------------------------------  PLUGINS  ------------------------------------------------
"--------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tweekmonster/gofmt.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" NERDtree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Tema
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug '/home/mpaulson/personal/vim-be-good'

" Comentarios
Plug 'tpope/vim-commentary'

" Color primera ocurrencia de letra en una linea
Plug 'unblevable/quick-scope'

" HTML close tags
Plug 'alvan/vim-closetag'

call plug#end()

"-------------------------------------  QUICK SCOPE  ----------------------------------------------
"--------------------------------------------------------------------------------------------------

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

let g:qs_max_chars=150

"---------------------------------------- THEME ---------------------------------------------------
"--------------------------------------------------------------------------------------------------

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
set background=dark

" --- The Greatest plugin of all time.  I am not bias
" let g:vim_be_good_floating = 0


"-------------------------------------- NERDtree --------------------------------------------------
"--------------------------------------------------------------------------------------------------

" Configurac NERDtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()


"----------------------------------FUZZY FINDER CONFIG --------------------------------------------
"--------------------------------------------------------------------------------------------------

"Config fuzzi finder
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
"ignorar los node_modules de npm al buscar archivos
let $FZF_DEFAULT_COMMAND = 'ag -g ""'


if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:vrfr_rg = 'true'

"--------------------------------------------------------------------------------------------------
"------------------------------------  SEARCH REMAPS  ---------------------------------------------

"Search inside the files in current directory
nnoremap <Leader>s :Rg<SPACE>
"Search files by name in current directory
nnoremap <Leader>o :Files<CR>
"Search for word under cursor with fzf (search word)
nnoremap <leader>sw :Rg <C-R>=expand("<cword>")<CR><CR>
"Search for help of word under cursor (search help word)
nnoremap <leader>shw :h <C-R>=expand("<cword>")<CR><CR>
"Acceso rápido a TODO
nnoremap <leader>t :Rg TODO<cr>
"Acceso rápido a FIXME
nnoremap <leader>f :Rg FIXME<cr>

"--------------------------------------------------------------------------------------------------
"------------------------------  WINDOW MANAGEMENT/MOVEMENT  --------------------------------------

"Move between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"Windows size modification
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>

"TODO: Marks. Find out more about marks to use this
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"--------------------------------------------------------------------------------------------------
"------------------------------------  EDITING  ---------------------------------------------------

"Show undo tree (allows to see a timeline of changes made to the file)
nnoremap <leader>u :UndotreeShow<CR>

"Sources confg file of Nvim. Useful only when testing init.vim changes
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" IMPORTANTE: Fugitive tiene problemas debido al cambio de : y ;
nnoremap ; :
nnoremap : ;
"inoremap ; :
"inoremap : ;

" Don't save on register when deleting with uppercase X on visual mode
vnoremap X "_d

"Escape from visual mode with Ctrl+c (Second option after CapsLock remap on OS)
inoremap <C-c> <esc>

" Comment
noremap <leader>/ :Commentary<cr>

"--------------------------------------------------------------------------------------------------
"---------------------------------------  COC  ----------------------------------------------------

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()


command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

"--------------------------------------------------------------------------------------------------
"------------------------------------  FuGITive  --------------------------------------------------

" IMPORTANTE:  Los comandos comienzan con ; porque Fugitive tiene problemas debido
" al cambio de : y ;. Los otros mapeos no tienen drama, no se porque
nmap <leader>gj ;diffget //3<CR>
nmap <leader>gf ;diffget //2<CR>
nmap <leader>gs ;G<CR>

"--------------------------------------------------------------------------------------------------
"-------=---------------------- netrw TODO: What is this?  ----------------------------------------

" When seleting a file with enter, open in new vertically-splited window
let g:netrw_browse_split = 2
"Remove NERDTree banner
let g:netrw_banner = 0
" Give 25% of size to new windows
let g:netrw_winsize = 25

"--------------------------------------------------------------------------------------------------
"--------------------------------- TODO: What is this?  -------------------------------------------

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 50)
augroup END

autocmd BufWritePre * :call TrimWhitespace()

"-------------------------------------- TERMINAL --------------------------------------------------
"--------------------------------------------------------------------------------------------------

" Terminal
:tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" Toggle 'default' terminal
nnoremap <C-n> :call ChooseTerm("term-slider", 1)<CR>
inoremap <C-n> <C-\><C-n>:call ChooseTerm("term-slider", 1)<CR>
" Start terminal in current pane
"nnoremap <C-k> :call ChooseTerm("term-pane", 0)<CR>

function! ChooseTerm(termname, slider)
	let pane = bufwinnr(a:termname)
	let buf = bufexists(a:termname)
	if pane > 0
		" pane is visible
		if a:slider > 0
			:exe pane . "wincmd c"
		else
			:exe "e #"
		endif
	elseif buf > 0
		" buffer is not in pane
		if a:slider
			:exe "split"
			:exe "resize 10"
		endif
		:exe "buffer " . a:termname
	else
		" buffer is not loaded, create
		if a:slider
			:exe "split"
			:exe "resize 10"
		endif
		:terminal
		:exe "f " a:termname
	endif
endfunction

"----------------------------------  HTML vim-closetag --------------------------------------------
"--------------------------------------------------------------------------------------------------

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml'
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 0
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

"--------------------------------------------------------------------------------------------------
"--------------------------------------------------------------------------------------------------
"--------------------------------------------------------------------------------------------------
