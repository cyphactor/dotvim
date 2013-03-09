" enable pathogen to load all the vim bundles in ~/.vim/bundle/
call pathogen#infect()

" set the clipboard to unnamed so it uses the system clipboard
" set clipboard=unnamed

" Set the visual bell instead of audible
set vb

" Set the font when using MacVim.app, this is ignored for console vim as it
" simply uses the console font.
set gfn=Monaco:h15

" tell vim NOT to run in Vi compatible mode
set nocompatible

" show line numbers
set number
set ruler

" keep buffers opened in background until :q or :q!
set hidden

" Number of : command entries to keep track of as history
set history=10000

" Set the word wrap character limit, this will force word wrap past the
" specified column.
set textwidth=78

" Default to tab size of two spaces and enable auto indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" Show matching bracket when a bracket is inserted
set showmatch

" Show matching pattern as typing search pattern 
set incsearch

" Highlight searches matching the search pattern
set hlsearch

" Make searches case-sensetive only if they include upper-case characters
set ignorecase smartcase

" Highlight the line the cursor is currently on for easy spotting
set cursorline

" Highlight the column the cursor is currently on for easy spottintg
set cursorcolumn

" Make the command entry area consume two rows
set cmdheight=2

" Set preference for switching butters, :help switchbuf for details
set switchbuf=useopen

" Min number of characters to use for line number column
set numberwidth=5

" Show tab lines always
set showtabline=2

" Soft min width for the active window
set winwidth=15

" Soft min height for the active window
set winheight=5

" Min height for non active window
set winminheight=5

" The shell to use when using :!
set shell=zsh

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" Minimum number of lines of context to keep around cursor
set scrolloff=3

" Settings for file swaps and backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show incomplete command
set showcmd

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" enable syntax
syntax on

" enable automatic code folder on indent
set foldmethod=syntax

" do NOT fold by default
set nofoldenable

" number of levels to auto fold when open a file
set foldlevel=1

" Set my leader key to be a comma
let mapleader = ","

" Enable file type detection.
" " Use the default filetype settings, so that mail gets 'tw' set to 72,
" " 'cindent' is on in C files, etc.
" " Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" tab completion mode for files, etc.
set wildmode=longest,list

" make tab completion for files/buffers act like bash
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd! BufRead,BufNewFile *.pp setfiletype ruby
  autocmd! BufRead,BufNewFile *.god setfiletype ruby

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Before writing a file check if the path for it exists. If it doesn't then
  " mkdir -p the path so that the file can be saved.
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif

  " Indent p tags, I commented the below out because I don't have the
  " dependencies necessary to get it to work and I am not sure if I
  " actually want it. I took it from the DestoryAllSoftware vimrc screencast.
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell it to use the solarized color scheme
" http://ethanschoonover.com/solarized
" In order to have this work properly in iTerm2 you also need to setup the
" iTerm2 solarized color scheme.
set background=dark
colorscheme solarized

" Tell it to use the ir_black color scheme
" http://blog.toddwerth.com/entries/8
" set background=dark
" colorscheme ir_black

" set background=dark
" colorscheme herald

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

" Erb statement generators
nmap <leader>- i<%<space><space>-%><esc>bhi
nmap <leader>= i<%=<space><space>%><esc>bhi
imap <leader>- <%<space><space>-%><esc>bhi
imap <leader>= <%=<space><space>%><esc>bhi

"imap <c-n> <%<space><space>%><esc>bhi
"imap <c-r> <%=<space><space>%><esc>bhi
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
nnoremap <leader><leader> <c-^>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC CtrlP TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . _ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CtrlP app/views<cr>
map <leader>gc :CtrlP app/controllers<cr>
map <leader>gm :CtrlP app/models<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>gl :CtrlP lib<cr>
map <leader>gp :CtrlP public<cr>
map <leader>gs :CtrlP public/stylesheets/sass<cr>
map <leader>gf :CtrlP features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CtrlPTag<cr>
map <leader>f :CtrlP<cr>
map <leader>F :CtrlP %%<cr>
map <leader>b :CtrlPBuffer<cr>

" jump to buffer if already open, even if in another tab
let g:ctrlp_switch_buffer = 2
" set the local working directory to the nearest .git/ .hg/ .svn/ .bzr/
let g:ctrlp_working_path_mode = 2
" enable cross-session caching by not deleting cache files on exit
let g:ctrlp_clear_cache_on_exit = 0
" set the best match to be the top
let g:ctrlp_match_window_reversed = 0
" set max height of match window
let g:ctrlp_max_height = 20
" tell ctrlp to ignore some files
let g:ctrlp_custom_ignore = 'tags$\|\.DS_Store$\|\.git$\|_site$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let in_feature = match(current_file, '\.feature$') != -1
  let in_step_def = match(current_file, '^features/step_definitions/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1

  if in_feature
    " go to step defs file
    " features/choose_plan.feature
    let new_file = substitute(new_file, '\.feature$', '_steps.rb', '')
    " features/choose_plan_steps.rb
    let new_file = substitute(new_file, 'features/', 'features/step_definitions/', '')
    " features/step_definitions/choose_plan_steps.rb
  elseif in_spec
    " go to implementation file
    let new_file = substitute(new_file, 'erb_spec\.rb$', 'erb', '')
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  elseif in_step_def
    " go to feature file
    " features/step_definitions/choose_plan_steps.rb
    let new_file = substitute(new_file, '_steps\.rb$', '.feature', '')
    " features/step_definitions/choose_plan.feature
    let new_file = substitute(new_file, 'step_definitions/', '', '')
    " features/choose_plan.feature
  else
    " go to spec file
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = substitute(new_file, '\.erb$', '\.erb_spec.rb', '')
    let new_file = 'spec/' . new_file
  endif

  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Test Runner that I started messing arround with for use in MacVim so that I
" could have the tests run and use the AnsiEsc plugin to interpret the ansi
" color codes output by the test commands. This is only necessary because
" MacVim does not run in a terminal their for the terminal isn't there to
" interpret the ansi color codes. Also note this oppens a new scratch buffer
" to put the test output into. It does this because I couldn't figure out how
" to tie AnsiEsc into the :! execution path.
function! BufferedRunTests(filename)
  enew
  setlocal modifiable
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  nnoremap <buffer> <enter> :bd<CR>
  exec ":silent! AnsiEsc"

  if match(a:filename, '\.feature') != -1
      if filereadable("zeus.json")
        exec ":!zeus cucumber " . a:filename
      elseif filereadable("script/features")
        exec ":!script/features " . a:filename
      else
        exec ":!bundle exec cucumber " . a:filename
      end
  else
      if filereadable("zeus.json")
          exec ":silent read !zeus test --color --tty " . a:filename . " 2>&1"
      elseif filereadable("script/test")
          exec ":!script/test " . a:filename
      elseif filereadable("Gemfile")
        " :cexpr system('bundle exec rspec --color '.a:filename.' 2>&1')
          exec ":silent! read !bundle exec rspec --color --tty " . a:filename . " 2>&1"
      else
        " :cexpr system('rspec --color '.a:filename.' 2>&1')
          exec ":silent! read !rspec --color --tty " . a:filename . " 2>&1"
      end
  end
  setlocal nomodifiable
endfunction

" This is another variation of test runner that I was playing around with
" just to see if I would like this type of dev/test workflow. When the tests
" are run it opens the scratch buffer in a pane and outputs the test run
" there. Then if tests are run again it simply updates that buffer. The
" concept behind this workflow was simply that there was a persistent pane up
" with the test output all the time, unless you explicitly closed it of
" course. This was intended to be used in the terminal, not in MacVim.
function! PersistetBufferRunTests(filename)
    " :w
    let winnr = bufwinnr('^_drew_run_tests_output$')
    if ( winnr >= 0 )
      execute winnr . 'wincmd w'
      setlocal modifiable
      execute 'normal ggdG'
    else
      botright new _drew_run_tests_output
      setlocal modifiable
      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
      exec ":silent! AnsiEsc"
    endif
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature') != -1
        if filereadable("zeus.json")
          exec ":!zeus cucumber " . a:filename
        elseif filereadable("script/features")
          exec ":!script/features " . a:filename
        else
          exec ":!bundle exec cucumber " . a:filename
        end
    else
        if filereadable("zeus.json")
            exec ":!zeus test " . a:filename
        elseif filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
          " :cexpr system('bundle exec rspec --color '.a:filename.' 2>&1')
            exec ":silent! read !bundle exec rspec --color --tty " . a:filename . " 2>&1"
        else
          " :cexpr system('rspec --color '.a:filename.' 2>&1')
            exec ":silent! read !rspec --color --tty " . a:filename . " 2>&1"
        end
    end
    setlocal nomodifiable
endfunction

function! RunCucumberTest(filename)
  if filereadable("zeus.json")
    exec ":!zeus cucumber " . a:filename
  elseif filereadable("script/features")
    exec ":!script/features " . a:filename
  else
    exec ":!bundle exec cucumber " . a:filename
  end
endfunction

function! RunRSpecTest(filename)
  if filereadable("zeus.json")
    exec ":!zeus test --color " . a:filename
  elseif filereadable("script/test")
    exec ":!script/test " . a:filename
  elseif filereadable("Gemfile")
    exec ":!bundle exec rspec --color " . a:filename
  else
    exec ":!rspec --color " . a:filename
  end
endfunction

function! RunTests(filename)
  :w
  if match(a:filename, '\.feature') != -1
    call RunCucumberTest(a:filename)
  else
    call RunRSpecTest(a:filename)
  end
endfunction

function! StoreCurrentFileAsTestFile()
  let t:grb_test_file=@%
endfunction

function! StoreCurrentLineNumAsTestLineNum()
  let t:grb_test_line=line('.')
endfunction

function! RemoveTestLineNum()
  if exists("t:grb_test_line")
    unlet t:grb_test_line
  end
endfunction

function! RunNearestTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
  if in_test_file
    call StoreCurrentFileAsTestFile()
    call StoreCurrentLineNumAsTestLineNum()
  elseif !exists("t:grb_test_file") || !exists("t:grb_test_line")
    return
  end
  call RunTests(t:grb_test_file . ":" . t:grb_test_line)
endfunction

function! RunTestsInCurrentFile()
  call RunTests(expand("%"))
endfunction

function! RunAllTestsInCurrentTestFile()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
  if in_test_file
    call StoreCurrentFileAsTestFile()
    call RemoveTestLineNum()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file)
endfunction

function! RunAllRSpecTests()
  call RunTests('spec/')
endfunction

function! RunAllCucumberFeatures()
  call RunCucumberTest("")
endfunction

function! RunWipCucumberFeatures()
  call RunCucumberTest("--profile wip")
endfunction

map <leader>t :call RunAllTestsInCurrentTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunAllRSpecTests()<cr>
map <leader>c :call RunAllCucumberFeatures()<cr>
map <leader>w :call RunWipCucumberFeatures()<cr>
