call plug#begin()
Plug 'arcticicestudio/nord-vim'
" Plug fzf {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Search from directory using AG {{{
function! FZFSearchInDir(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, fzf#vim#with_preview('right')))
endfunction
command! -nargs=+ -complete=dir FZFAgIn call FZFSearchInDir(<f-args>)
" }}}

" Project root files {{{
function! FZFFindGitRoot()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! FZFProjectFiles execute 'Files' FZFFindGitRoot()
" }}}

imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)

nmap K :Ag <C-R><C-W><CR>
nnoremap /f :FZFAgIn %:p:h<CR>
nnoremap /d :FZFProjectFiles<CR>
nnoremap /a :Files %:p:h<CR>
nnoremap /s :Files<CR>
nnoremap /x :Tags<Cr>
nnoremap /n :Marks<CR>
nnoremap /c :BTags <C-R><C-W>
nnoremap /b :Buffers<CR>
nnoremap /m :History<CR>
nmap <Leader>gs :GFiles?<CR>

" Plug: ale {{{
Plug 'w0rp/ale'

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
  \   '%dW %dE',
  \   all_non_errors,
  \   all_errors
  \)
endfunction

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {
  \ 'javascript': ['standard']
  \}
let g:ale_fixers = {
  \ 'javascript': ['standard'],
  \ }
let g:ale_fix_on_save = 1
nmap <leader>d <Plug>(ale_fix)
" }}}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set cursorline
" set termguicolors
colorscheme nord

" Text, tab and indent related {{{
" Use paces instead of tabs
set expandtab

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch
set inccommand=split

" Be smart when using tabs
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Use one space instead of two when joining lines
set nojoinspaces

" Automatic save on buffer change etc
set autowriteall

" Use relative numbers
" set relativenumber
" set number
" }}}
" List chars {{{
set showbreak=↪

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:.
