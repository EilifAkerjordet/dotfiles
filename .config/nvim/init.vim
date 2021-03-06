call plug#begin('~/local/share/nvim/plugged')
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'alampros/vim-styled-jsx'
 Plug 'sheerun/vim-polyglot'
 Plug 'SirVer/ultisnips'
 Plug 'pechorin/any-jump.vim'
 Plug 'lervag/vimtex'
 Plug 'Konfekt/FastFold'
 Plug 'matze/vim-tex-fold'
 Plug 'mattn/emmet-vim'
 Plug 'w0rp/ale'
 Plug 'hail2u/vim-css3-syntax'
 Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
 Plug 'sbdchd/neoformat'
 Plug 'tpope/vim-sensible'
 Plug 'hzchirs/vim-material'
 Plug 'vim-airline/vim-airline'
 Plug 'justinmk/vim-sneak'
 Plug 'tpope/vim-surround'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'benmills/vimux'
 Plug 'mlaursen/vim-react-snippets'
 Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
 Plug 'tpope/vim-commentary'
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'jiangmiao/auto-pairs'
 Plug 'lgeorget/maude.vim'
 Plug 'ThePrimeagen/vim-be-good', { 'do': './install.sh' }
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
 Plug 'junegunn/fzf.vim'
 Plug 'airblade/vim-rooter'
 Plug 'vimwiki/vimwiki'
 Plug 'tpope/vim-fugitive'
 Plug 'unblevable/quick-scope'
 Plug 'kevinhwang91/rnvimr', {'branch': 'main'}
 Plug 'miyakogi/seiya.vim'
 Plug 'turbio/bracey.vim'
 Plug 'yuttie/comfortable-motion.vim'
 " NEEDS TO BE LAST TO LOAD "
 Plug 'ryanoasis/vim-devicons'
 " NEEDS TO BE LAST TO LOAD "
call plug#end()
set number
set relativenumber
set expandtab
set sts=2
set sw=2
set cursorline
set laststatus=2
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=no
set splitbelow splitright
set laststatus=0
set noshowmode

let g:bufferline_echo = 0
let b:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:javascript_plugin_flow = 1
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']
let g:seiya_auto_enable = 1
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_picker = 1
" Make Ranger to be hialendar with google cal
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:bracey_server_allow_remote_connections = 1

let R_auto_start=1

let R_in_buffer = 0
let R_source = '/home/eilif/local/share/nvim/plugged/Nvim-R/R/tmux_split.vim'

 " KEY MAPS START
let mapleader = " "
let maplocalleader = ','

nnoremap <C-s> :w<CR>
nnoremap <C-w> :wq<CR>
nnoremap <C-q> :q!<CR>

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>

nmap <Leader>gs :G<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>ga :Gadd .<CR>
nmap <Leader>g; :Gpull<CR>
nmap <Leader>gp :Gpush<CR>
nmap <Leader>gj :diffget //3<CR>
nmap <Leader>gf :diffget //2<CR>

nmap <Leader>rv :source $MYVIMRC<CR>
map <Leader>af :ALEFix standard<CR>
nmap <Leader>vbg :VimBeGood<CR>
nmap <Leader>k :RnvimrToggle<CR>
nmap <C-p> :GFiles<CR>
nmap / :BLines<CR>
nmap <C-m> :Rg<CR>

vmap <C-_> gc
nmap <C-_> gcc

" Vim wiki

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" 2-character Sneak (default)
    nmap s <Plug>Sneak_s
    nmap S <Plug>Sneak_S
" visual-mode
    xmap s <Plug>Sneak_s
    xmap S <Plug>Sneak_S
" operator-pending-mode
    omap s <Plug>Sneak_s
    omap S <Plug>Sneak_S
" KEY MAPS END

 """""""""""""""""""COC NVIM"""""""""""""""""""""""""""""

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nmap <leader>qf  <Plug>(coc-fix-current)

"""""""""""""""""""COC NVIM"""""""""""""""""""""""""""""
"""""""""""""""""""FZF""""""""""""""""""""""""""""""""""
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.5 } }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"""""""""""""""""""FZF""""""""""""""""""""""""""""""""""
"""""""""""""""""""EMMET"""""""""""""""""""""""""""""
let g:user_emmet_leader_key='<C-c>'
nmap <expr> <C-l> emmet#expandAbbrIntelligent("\<C-l>")
imap <expr> <C-l> emmet#expandAbbrIntelligent("\<C-l>")
"""""""""""""""""""EMMET"""""""""""""""""""""""""""""
"""""""""""""""""""ANy-JUMP"""""""""""""""""""""""""""""
let g:any_jump_list_numbers=0
"""""""""""""""""""ANy-JUMP"""""""""""""""""""""""""""""
"""""""""""""""""""QuickScope"""""""""""""""""""""""""""
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"""""""""""""""""""QuickScope"""""""""""""""""""""""""""
"""""""""""""""""""VIMTEX"""""""""""""""""""""""""""
let g:vimtex_view_method = 'zathura'
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
" use SumatraPDF if you are on Windows
"""""""""""""""""""VIMTEX"""""""""""""""""""""""""""

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"let g:material_terminal_italics = 1
"let g:material_theme_style = 'darker'
let g:material_style='oceanic'
set background=dark
colorscheme vim-material
let g:airline_theme = 'material'

