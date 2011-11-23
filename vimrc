" To invoke this file after vi startup read it into a buffer, e.g. x
" then execute it by typing :@x (i.e. an ex command on bottom line).

" cos really who cares about vi :)
set nocompatible

" use auto-indenting by 4 spaces. ensure tabs are never inserted and
" tab key indents by 4 spaces.
set autoindent shiftwidth=4 expandtab tabstop=4 textwidth=80

set nu
syntax on
set t_Co=256
colorscheme solarized
set background=dark

" define some useful insert mode shortcuts for C/C++ syntax.
imap  #en  #endif    /*  */<Esc>2hi
imap  #nd  #ifndef <Esc>a
imap  #if  #ifdef <Esc>a
imap  #de  #define<Space>
imap  #ii  #include ""<Esc>i
imap  #ic  #include <><Esc>i
imap  #/   /*<CR> <CR>/<Esc>kA
imap  ''wh  while (  )<CR>{<CR>}<Esc>2k0f(la
imap  ''un  union <CR>{<CR>};<Esc>2kA
imap  ''sw  switch (  )<CR>{   case:<CR><C-T><C-T>break;<CR><C-D><C-D>}<Esc>3k0f(la
imap  ''st  struct <CR>{<CR>};<Esc>2kA
imap  ''re  return();<Esc>hi
imap  ''ma int main(int argc, char *argv[])<CR>{<CR>}<Esc>O<C-T>return 0;<Esc>O
imap  ''if  if (  )<CR>{<CR>}<Esc>2k0f(la
imap  ''fo  for ( ; ; )<CR>{<CR>}<Esc>2k0f(a
imap  ''en  enum  { };<Esc>4hi
imap  ''el  else<CR>{   <CR>}<Esc>kA
imap  ''ei  else if (  )<CR>{<CR>}<Esc>2k0f(la
imap  ''do  do<CR>{   <CR>}  while (  );<Esc>kA
imap  ''fl  float ;<Esc>i
imap  ''df  default:<CR><C-T><CR>break;<Esc>kA
imap  ''ca  case: <CR>break;<Esc>kA
imap  ''//  <Esc>I//  

" bash
imap  '31  #! /bin/bash<CR><CR>

" useful latex editing shortcuts
map <F12> :w<CR>:!pdflatex %:p<CR>
map <F11> :w<CR>:!g++ -o %:t:r %:t `root-config --cflags --libs`<CR>
map <F10> :w<CR>:!root -b %:p -q<CR>
imap '% %<CR>%---------------------------------<Esc>kA
imap 'f \subsection{}<CR>\begin{frame}{\insertsubsection}<CR><CR>\end{frame}<Esc>3k$i
imap 'item \begin{itemize}<Esc>yyplcwend<Esc>O<C-T>\item  

" force me to use the proper binding
nmap <Left> <nop>
nmap <Right> <nop>
nmap <Up> <nop>
nmap <Down> <nop>

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR><CR>

" OmniCppComplete
set nocp
filetype plugin on
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
set pumheight=15
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
set tags+=./tags:

