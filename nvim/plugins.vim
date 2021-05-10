call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Themes
    Plug 'tomasiser/vim-code-dark'
    Plug 'dracula/vim', { 'as': 'dracula' }
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Airline and Airline-themes
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'    

call plug#end()
