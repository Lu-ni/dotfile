set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'
    Plugin 'prabirshrestha/vim-lsp'
    Plugin 'mattn/vim-lsp-settings'
    Plugin 'prabirshrestha/asyncomplete.vim'
    Plugin 'prabirshrestha/asyncomplete-lsp.vim'
    Plugin 'preservim/nerdtree'
	Plugin 'google/vim-maktaba'
	Plugin 'google/vim-codefmt'
	Plugin 'google/vim-glaive'
	Plugin 'ctrlpvim/ctrlp.vim'
	" All of your Plugins must be added before the following line
call vundle#end()            " required
call glaive#Install()

filetype plugin indent on    " required

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
  autocmd FileType swift AutoFormatBuffer swift-format
augroup END

  syntax enable
 " set number
 " set relativenumber
  set backspace=indent,eol,start " Intuitive backspace behavior.

  set autoindent
  set expandtab
  set shiftround
  set shiftwidth=4
  set tabstop=4
  set smarttab
  set noexpandtab     " tabs are used, not spaces


  set ruler
  set cursorline
  set title

  set wildmenu
  set incsearch
  set hlsearch

  set ignorecase
  set smartcase

  set backup      " keep a backup file
  set backupdir=~/.vim/backup
  " Maps NERDTree to F2 "
  map <F2> :NERDTreeToggle<CR>
  " map tap to autocomplete
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"


  " autoformat with 42 format on save
function! FormatWithClang()
  if &modified
    echo "Buffer has unsaved changes. Save before formatting."
    return
  endif

  let l:current_file = expand('%:p')
  let l:format_file = '~/.vim/.clang-format'  " specify the path to your custom config
  " Replace the '~' with the actual path to the home directory if the below command doesn't work
  exec '!' . 'clang-format -i --style=file -assume-filename=' . l:format_file . ' ' . l:current_file

  " Temporarily set the current buffer as unmodified (as if it's just been saved)
  setlocal nomodified
  " Force Vim to reload the current file
  edit!
endfunction

command! ClangFormat call FormatWithClang()
nnoremap <leader>cf :ClangFormat<CR>
" us jk to Esc
inoremap jk <Esc>
" Use , as leader key
:let mapleader = ","
" testing lsp shortcut
nnoremap <leader>g :LspDefinition<CR>
nnoremap <leader>G :LspDeclaration<CR>
nnoremap <leader>p :LspPeekDefinition<CR>
nnoremap <leader>P :LspPeekDeclaration<CR>
"Remove diagnostic from lsp
let g:lsp_diagnostics_enabled = 0

"http://stackoverflow.com/questions/849084/what-fold-should-i-use-in-vim
" Folding stuff
hi Folded guibg=red guifg=Red cterm=bold ctermbg=DarkGrey ctermfg=lightblue
"hi FoldColumn guibg=grey78 gui=Bold guifg=DarkBlue
set foldcolumn=0
set foldclose=
set foldmethod=syntax
set foldnestmax=10
set foldlevel=999
" Toggle fold state between closed and opened.

" If there is no fold at current line, just moves forward.
" If it is present, reverse it's state.
fu! ToggleFold()
  if foldlevel('.') == 0
    normal! l
  else
    if foldclosed('.') < 0
      . foldclose
    else
      . foldopen
    endif
  endif
  echo
endf
" Map this function to Space key.
noremap <space> :call ToggleFold()<CR>

if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
end

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set number relativenumber
    autocmd WinLeave * set nonumber norelativenumber
augroup END

hi StatusLine ctermfg=NONE     ctermbg=67     cterm=NONE
