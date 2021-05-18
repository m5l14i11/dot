let $USE_SYSTEM_GO=1

set nocompatible

syntax on
filetype plugin indent on

set encoding=utf8

set noerrorbells visualbell t_vb=
autocmd! GUIEnter * set visualbell t_vb=

set backspace=indent,eol,start

set clipboard+=unnamedplus
set ffs=unix,dos,mac

set splitbelow

set cursorline
set noswapfile

set laststatus=2

set autowrite

set statusline=\ %f

set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase

set showtabline=2
set termguicolors

set number
set title
set ruler

set mouse=a

au FocusGained,BufEnter * :checktime

set makeprg=make

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

set background=dark

execute pathogen#infect()
execute pathogen#helptags()

colorscheme gruvbox

"""---------------vim-go-----------------------
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

let g:go_jump_to_error = 0
let g:go_fmt_command = "goimports"

let g:go_auto_sameids = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

"""--------haskell-----------
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 1

"""------coc---------
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd ColorScheme * highlight CocErrorFloat guifg=#ffffff
autocmd ColorScheme * highlight CocInfoFloat guifg=#ffffff
autocmd ColorScheme * highlight CocWarningFloat guifg=#ffffff
autocmd ColorScheme * highlight SignColumn guibg=#adadad

autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <c-@> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"""---------nerdtree-------
let g:NERDTreeWinSize=40
let NERDTreeShowHidden=1


"""-------------mapping--------------
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

nnoremap <C-u> :redo<CR>
nnoremap <C-Up> :tabm +1<CR>
nnoremap <C-Down> :tabm -1<CR>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>h
nnoremap <C-w> <C-u>
nnoremap <C-s> <C-d>


autocmd BufEnter *.go nmap <leader>t  <Plug>(go-test)
autocmd BufEnter *.go nmap <leader>tt <Plug>(go-test-func)
autocmd BufEnter *.go nmap <leader>c  <Plug>(go-coverage-toggle)
autocmd BufEnter *.go nmap <leader>i  <Plug>(go-info)
autocmd BufEnter *.go nmap <leader>ii  <Plug>(go-implements)
autocmd BufEnter *.go nmap <leader>ci  <Plug>(go-describe)
autocmd BufEnter *.go nmap <leader>cc  <Plug>(go-callers)
autocmd BufEnter *.go nmap <leader>cs  <Plug>(go-callstack)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <Leader>ws <Plug>(coc-metals-expand-decoration)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)

nmap <leader>qf  <Plug>(coc-fix-current)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>
