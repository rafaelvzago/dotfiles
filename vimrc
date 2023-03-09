
" Author: Rafael Zago
" E-mail: rafaelvzago@gmail.com

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'loctvl842/monokai-pro.vim'
Plugin 'morhetz/gruvbox'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'mtdl9/vim-log-highlighting'
Plugin 'preservim/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'itchyny/vim-gitbranch'
Plugin 'hashivim/vim-terraform'
Plugin 'fatih/vim-go' 
Plugin 'dense-analysis/ale' 
Plugin 'junegunn/fzf'
call vundle#end()            " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
colorscheme gruvbox

filetype plugin indent on
set termguicolors
set mouse=a
set cursorline
set clipboard=unnamedplus
set bg=dark
set noerrorbells
set nowrap        				" don't wrap lines
set tabstop=2 softtabstop=2     " a tab is two spaces
set expandtab
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set autoindent    				" always set autoindenting on
set copyindent    				" copy the previous indentation on autoindenting
set number       				  " always show line numbers
set shiftwidth=2  				" number of spaces to use for autoindenting
set shiftround    				" use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     				" set show matching parenthesis
set ignorecase    				" ignore case when searching
set smartcase     				" ignore case if search pattern is all lowercase,    case-sensitive otherwise
set smarttab      				" insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      				" highlight search terms
set incsearch     				" show search matches as you type
set formatoptions-=t 			" do not automatically wrap text when typing
set laststatus=2
set wildmode=longest:full,full
set wildoptions=pum
syntax on
" Mappings
map <C-n> :NERDTreeToggle<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-t> :tabnew<CR>

" Plugins config
let g:netrw_banner = 0          " Remove nerdtree banners
let g:netrw_browse_split = 2

" Git Repo Information
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" Language specifics
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

if !has('gui_running')
  set t_Co=256
endif
