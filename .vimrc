if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number
set cursorline
set laststatus=2
"set cursorcolumn

"set relative number toggle 
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode () != "i" | set rnu | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END



""autocomplete



inoremap <expr> <Tab> getline('.')[col('.')-2] !~ '^\s\?$' \|\| pumvisible()
      \ ? '<C-N>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() \|\| getline('.')[col('.')-2] !~ '^\s\?$'
      \ ? '<C-P>' : '<Tab>'
autocmd CmdwinEnter * inoremap <expr> <buffer> <Tab>
      \ getline('.')[col('.')-2] !~ '^\s\?$' \|\| pumvisible()
      \ ? '<C-X><C-V>' : '<Tab>'
""
""" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on



if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

"---------------------------LaTeX
map I :! pdflatex %<CR><CR>
map S :! xdg-open $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
"" imaps for shortcuts
autocmd Filetype tex inoremap ;bf \textbf{}<space><Esc>T{i
autocmd Filetype tex inoremap ;it \textit{}<space><Esc>T{i
autocmd Filetype tex inoremap ;r \ref{}<space><Esc>T{i
autocmd Filetype tex inoremap ;ig \includegraphics[width=\textwidth]{}<space><Esc>T{i
autocmd Filetype tex inoremap ;fr \begin{frame}{}<Enter><Enter>\end{frame}<Enter><Enter><Esc>3ka<Esc>i
autocmd Filetype tex inoremap ;t \begin{tabular}<Enter><Enter>\end{tabular}<Enter><Enter><Esc>3ka<Esc>i
autocmd Filetype tex inoremap ;I \begin{itemize}<Enter>\item[]{}<Enter>\end{itemize}<Enter><Enter><Esc>3ka<Esc>i
autocmd Filetype tex inoremap ;fi \begin{figure}[H]<Enter>\centering<Enter>\includegraphics[width=\textwidth]{}<space><Enter>\caption[]{}<Enter>\label{fig:}<Enter>\end{figure}<Enter><Enter><Esc>5k<Esc>$T{i

autocmd Filetype tex inoremap ;C \begin{columns}<Enter>\column{\textwidth}<space><Enter>\end{columns}<Enter><Enter><Esc>3ka<Esc>$T{i

"call plug#begin('~/.vim/plugged')

"Plug 'ervandew/supertab'

"call plug#end()

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
