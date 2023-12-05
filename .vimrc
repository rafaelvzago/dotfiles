" Author information and license GPLv3 Github Information: rafaelvzago/dotfiles
" This is my personal vimrc file. Feel free to use it and modify it as you wish.
" I use Vundle as my plugin manager, so you need to install it first.
" Author: Rafael Zago
" E-mail: rafaelvzago@gmail.com
" Github: rafaelvzago
" License: GPLv3
" Linkedin: https://www.linkedin.com/in/rafaelvzago/
" Site: https://rafaelvzago.com

set nocompatible                                                " be iMproved, required
filetype off                                                    " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim                              " set runtime path to vundle
call vundle#begin()                                            " required

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'                                   " Vundle plugin manager
Plugin 'mbbill/undotree'                                        " Undo tree plugin manager
Plugin 'tpope/vim-fugitive'                                     " Git wrapper for vim
Plugin 'patstockwell/vim-monokai-tasty'
Plugin 'github/copilot.vim'                                     " Github copilot plugin for vim
Plugin 'mtdl9/vim-log-highlighting'                             " Log highlighting for vim
Plugin 'preservim/nerdtree'                                     " NERDTree plugin for vim
Plugin 'itchyny/lightline.vim'                                  " Lightline plugin for vim
Plugin 'itchyny/vim-gitbranch'                                  " Git branch in lightline
Plugin 'hashivim/vim-terraform'                                 " Terraform syntax highlighting
Plugin 'fatih/vim-go'                                           " Go syntax highlighting
Plugin 'dense-analysis/ale'                                     " Asynchronous Lint Engine
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }           " Fuzzy search
Plugin 'junegunn/fzf.vim'                                       " Fuzzy search
Plugin 'christoomey/vim-tmux-navigator'                         " Tmux navigation for vim
call vundle#end()            " required

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Theme config
colorscheme vim-monokai-tasty                                   " set colorscheme
highlight Normal ctermbg=None                                   " set background to none for transparency
highlight ColorColumn ctermbg=235 guibg=#272822                 " set colorcolumn background to dark grey
set colorcolumn=80                                              " set colorcolumn to 80 characters

filetype plugin indent on
set termguicolors                                               " enable 24-bit RGB colors
set mouse=a                                                     " enable mouse support
set clipboard=unnamedplus                                       " enable clipboard support
set mouse=r                                                     " enable mouse support
set bg=dark                                                     " set background to dark
set noerrorbells                                                " don't beep
set nowrap                                                      " don't wrap lines
set tabstop=2 softtabstop=2                                     " a tab is two spaces
set expandtab                                                   " use spaces instead of tabs
set backspace=indent,eol,start                                  " allow backspacing over everything in insert mode
set smartindent                                                 " autoindent new lines
set noswapfile                                                  " don't use swapfile
set nobackup                                                    " don't create backupfile
set undodir=~/.vim/undodir                                      " set undodir
set undofile                                                    " enable undofile
set incsearch                                                   " incremental search
set autoindent                                                  " always set autoindenting on
set copyindent                                                  " copy the previous indentation on autoindenting
set number                                                      " always show line numbers
set shiftwidth=2                                                " number of spaces to use for autoindenting
set shiftround                                                  " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                                                   " set show matching parenthesis
set ignorecase                                                  " ignore case when searching
set smartcase                                                   " ignore case if search pattern is all lowercase,    case-sensitive otherwise
set smarttab                                                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch                                                    " highlight search terms
set incsearch                                                   " show search matches as you type
set formatoptions-=t                                            " do not automatically wrap text when typing
set laststatus=2                                                " always show statusline
set wildmode=longest:full,full                                  " command line completion mode
set wildoptions=pum                                             " command line completion mode
syntax on                                                       " syntax highlighting



" NERDTree config
let g:netrw_banner = 0                                          " Remove nerdtree banners
let g:netrw_browse_split = 2                                    " Open nerdtree in a new tab
map <C-n> :NERDTreeToggle<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-t> :tabnew<CR>

" Fuzzy search
let g:fzf_preview_window = ['right,50%', 'ctrl-/']              " Set fzf preview window
nnoremap <C-S-P> :Files<CR>
nnoremap <C-S-R> :Rg<CR>

" Copilot specifics
let g:copilot_filetypes = {'markdown': v:true}

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'monokai_tasty',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Language specifics
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown     " set markdown filetype

if !has('gui_running')                                          " if not running in gui mode
  set t_Co=256                                                  " set terminal colors to 256
endif

if exists('+termguicolors') && &termguicolors                   " if terminal supports true colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"                        " set true colors
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"                        " set true colors
  set termguicolors                                             " enable true colors
endif
