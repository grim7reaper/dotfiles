set nocompatible " Disable the compatibility with Vi.

" {{{ Pathogen

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" }}}
" {{{ Filetype

" Enable loading the plugin files for specific file types.
filetype plugin on
" Enable loading the indent file for specific file types.
filetype indent on

" }}}
" {{{ Options

set title          " Set title of the window.
set shortmess=a    " Abbreviation, but no loss of information.
set history=100    " Set the number of lines that are remembered.
set encoding=utf-8 " Sets the character encoding used inside Vim.
set number         " Precede the current line with its line number.
set relativenumber " Show the line number relative to the line with the cursor.
set showcmd        " Show (partial) command in the last line of the screen.
set incsearch      " Start searching when typing.
set hlsearch       " Highlights strings matched by the search.
set report=0       " Always report the number of lines changed.

set autoindent " Copy indent from current line when starting a new line.
set wildmenu   " Enable enhanced command-line completion.

" Complete longest common string, then each full match.
set wildmode=longest:full,full
" Complete automatically the longest common match.
set completeopt=menu,preview,longest
" Allow backspacing over autoindent, line breaks and the start of insert
set backspace=indent,eol,start

" Strings to use in 'list' mode.
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:¤
set list " Enable list mode (useful to see difference between tabs and spaces).

set expandtab     " Hitting Tab will produce spaces.
set softtabstop=4 " How many columns used when I hit Tab in insert mode.
set shiftwidth=4  " How many columns text is indented with the reindent operations.

" Undo file
set undofile                  " Enable persistent undo.
set undodir=~/.cache/vim/undo " Storage locations for the undofiles.

set textwidth=80   " Maximum width of a line.
set colorcolumn=+1 " highlight column after 'textwidth'
set wrap           " Wrap lines longer than the width of the window.

set foldmethod=marker " Use marker for folding.

set virtualedit=block "The cursor can be positioned anywhere in block mode.

" {{{ GUI

set guioptions-=m  " Remove menu bar.
set guioptions-=T  " Remove toolbar.
set guioptions-=r  " Remove right-hand scroll bar.
set guioptions-=L  " Remove left-hand scroll bar.

" }}}

set background=dark " Try to use colors that look good on a dark background.
colorscheme elflord " Load the colorscheme 'elflord'
syntax on           " Turn on color syntax highlighting.

" }}}
" {{{ Autocommands

" Treat *.tpp (C++ template implementation) files as C++.
autocmd BufNewFile,BufRead *.tpp setfiletype=cpp
" Treat *.md files as Markdown.
autocmd BufNewFile,BufReadPost *.md setfiletype=markdown
" Enable spell checking.
autocmd BufNewFile,BufRead *.tex  setlocal spell spelllang=fr
" Prevent the buffer listing from becoming swamped with fugitive buffers.
autocmd BufReadPost fugitive://* set bufhidden=delete
" 72 characters per line for emails.
autocmd BufRead /tmp/mutt* set textwidth=72

autocmd InsertEnter * hi StatusLine ctermbg=cyan   ctermfg=darkgrey
autocmd InsertLeave * hi StatusLine ctermbg=yellow ctermfg=darkgrey

" Restore cursor position.
" From ':h last-position-jump' but modified to handle files with only one line.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g`\"" |
    \ endif

" }}}
" {{{ Mapping

" Clear the search buffer when hitting return.
nnoremap <CR> :nohlsearch<cr>
" Use F7 to toggle the `paste` option.
set pastetoggle=<F7>
" Remove trailing spaces and stay in the same position.
map <F12> mcHmh:%s/\s\+$//ge<cr>'hzt`c

" }}}
" {{{ Highlighting

" Highlight trailing whitespaces and spaces before a tab.
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Statusline colors.
highlight StatusLine   ctermbg=yellow ctermfg=darkgrey
highlight StatusLineNC ctermbg=yellow ctermfg=black

" }}}
" {{{ Statusline

set laststatus=2                             " Always display the statusline.
set statusline+=%-2.2n\                      " Buffer number.
set statusline+=%f\                          " File name.
set statusline+=%m%r                         " Flags (modified, readonly).
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " Filetype.
set statusline+=%{&encoding},                " Encoding.
set statusline+=%{&fileformat}]\             " File format.
set statusline+=%=                           " Left/Right align. separation.
set statusline+=0x%-5B\                      " Current char.
set statusline+=%-10.(%l,%v-%c%)\ %<%P       " Offset

" }}}
" {{{ Misc.
" {{{ TOhtml settings.

let use_xhtml=1               " Generate XHTML 1.0 instead of HTML 4.01
let html_use_css=1            " Use CSS styling.
let html_no_progress=1        " Show progress bar.
let html_ignore_folding=1     " Ignore folding.
let html_prevent_copy = "n"   " Don't copy line numbers when copy-paste.
let html_no_invalid=1         " Don't use invalid attribute for uncopyable text.
let html_use_encoding="UTF-8" " Use UTF-8 encoding.

" }}}
" }}}