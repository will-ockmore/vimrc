"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Will Ockmore
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> Tmux
"    -> Parenthesis/Bracket
"    -> Persistent undo
"    -> Command mode
"
"    -> Plugins
"    -> Colorscheme
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Sets how many lines of history VIM has to remember
    set history=500

    " Enable filetype plugins
    filetype plugin indent on

    " Set to auto read when a file is changed from the outside
    set autoread

    " With a map leader it's possible to do extra key combinations
    " like <leader>w saves the current file
    let mapleader = ","

    " Fast saving
    nmap <leader>w :w!<cr>
    " Map jk to ESC in insert mode
    inoremap jk <esc>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Set 7 lines to the cursor - when moving vertically using j/k
    set so=7

    " Avoid garbled characters in Chinese language windows OS
    let $LANG='en'
    set langmenu=en
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    " Turn on the Wild menu
    set wildmenu

    " Ignore compiled files
    set wildignore=*.o,*~,*.pyc
    if has("win16") || has("win32")
        set wildignore+=.git\*,.hg\*,.svn\*
    else
        set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
    endif

    "Always show current position
    set ruler

    "Show relative numbers for active buffer,
    " and absolute line numbers for all others
    :set number relativenumber

    :augroup numbertoggle
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    :augroup END

    " Height of the command bar
    " Better display for messages for eg. coc.nvim
    set cmdheight=2

    " A buffer becomes hidden when it is abandoned
    set hid

    " Highlight search results
    set hlsearch

    " Don't redraw while executing macros (good performance config)
    set lazyredraw

    " Show matching brackets when text indicator is over them
    set showmatch
    " How many tenths of a second to blink when matching brackets
    set mat=2

    " No annoying sound on errors
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500

    " Properly disable sound on errors on MacVim
    if has("gui_macvim")
        autocmd GUIEnter * set vb t_vb=
    endif

    " Disable folding
    set nofoldenable

    " Configure backspace so it acts as it should act
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l

    " For regular expressions turn magic on
    set magic
endif

" Makes search act like search in modern browsers
set incsearch

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Enable syntax highlighting
    syntax enable

    " Enable 256 colors palette in Gnome Terminal
    if $COLORTERM == 'gnome-terminal'
        set t_Co=256
    endif

    try
        colorscheme desert
    catch
    endtry

    set background=dark

    " Set extra options when running in GUI mode
    if has("gui_running")
        set guioptions-=T
        set guioptions-=e
        set t_Co=256
        set guitablabel=%M\ %t
    endif

    " Set utf8 as standard encoding and en_US as the standard language
    set encoding=utf8

    " Use Unix as the standard file type
    set ffs=unix,dos,mac
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Turn backup off, since most stuff is in SVN, git et.c anyway...
    set nobackup
    set nowb
    set noswapfile
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs ;)
    set smarttab

    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4

    " Javascript / Typescript: 1 tab == 2 spaces
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2
    autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
    autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2

    " Linebreak on 500 characters
    set lbr
    set tw=500

    set ai "Auto indent
    set si "Smart indent
    set wrap "Wrap lines
endif

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " Close the current buffer
    map <leader>bd :Bclose<cr>:tabclose<cr>gT

    " Close all the buffers
    map <leader>ba :bufdo bd<cr>

    map <leader>l :bnext<cr>
    map <leader>h :bprevious<cr>

    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Automatically resize panes when window size changes
    autocmd VimResized * wincmd =
endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Always show the status line
    set laststatus=2

    " Format the status line
    set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Remap VIM 0 to first non-blank character
    map 0 ^

    if has("mac") || has("macunix")
      nmap <D-j> <M-j>
      nmap <D-k> <M-k>
      vmap <D-j> <M-j>
      vmap <D-k> <M-k>
    endif

    " Delete trailing white space on save, useful for some filetypes ;)
    fun! CleanExtraSpaces()
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        silent! %s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
    endfun

    if has("autocmd")
        autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Returns true if paste mode is enabled
    function! HasPaste()
        if &paste
            return 'PASTE MODE  '
        endif
        return ''
    endfunction

    " Don't close window, when deleting a buffer
    command! Bclose call <SID>BufcloseCloseIt()
    function! <SID>BufcloseCloseIt()
        let l:currentBufNum = bufnr("%")
        let l:alternateBufNum = bufnr("#")

        if buflisted(l:alternateBufNum)
            buffer #
        else
            bnext
        endif

        if bufnr("%") == l:currentBufNum
            new
        endif

        if buflisted(l:currentBufNum)
            execute("bdelete! ".l:currentBufNum)
        endif
    endfunction

    function! CmdLine(str)
        call feedkeys(":" . a:str)
    endfunction

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Tmux
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Repeat last command in last window
    " Useful for running tests after changes without leaving vim
    nmap \r :!tmux send-keys -t {last} C-p C-j <CR><CR>
endif

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    vnoremap $1 <esc>`>a)<esc>`<i(<esc>
    vnoremap $2 <esc>`>a]<esc>`<i[<esc>
    vnoremap $3 <esc>`>a}<esc>`<i{<esc>
    vnoremap $$ <esc>`>a"<esc>`<i"<esc>
    vnoremap $q <esc>`>a'<esc>`<i'<esc>
    vnoremap $e <esc>`>a"<esc>`<i"<esc>

    " Map auto complete of (, ", ', [
    inoremap $1 ()<esc>i
    inoremap $2 []<esc>i
    inoremap $3 {}<esc>i
    inoremap $4 {<esc>o}<esc>O
    inoremap $q ''<esc>i
    inoremap $e ""<esc>i
endif
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    " Smart mappings on the command line
    cno $h e ~/
    cno $d e ~/Desktop/
    cno $j e ./
    cno $c e <C-\>eCurrentFileDir("e")<cr>

    " $q is super useful when browsing on the command line
    " it deletes everything until the last slash
    cno $q <C-\>eDeleteTillSlash()<cr>

    " Bash like keys for the command line
    cnoremap <C-A>		<Home>
    cnoremap <C-E>		<End>
    cnoremap <C-K>		<C-U>

    cnoremap <C-P> <Up>
    cnoremap <C-N> <Down>

    " Map ½ to something useful
    map ½ $
    cmap ½ $
    imap ½ $
endif

""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()

" Only installed for terminal vim
Plug 'EdenEast/nightfox.nvim', Cond(!exists('g:vscode'))
Plug 'bakpakin/fennel.vim', Cond(!exists('g:vscode'))
Plug 'christoomey/vim-tmux-navigator', Cond(!exists('g:vscode'))
Plug 'jiangmiao/auto-pairs', Cond(!exists('g:vscode'))
Plug 'junegunn/fzf', !exists('g:vscode') ? { 'do': { -> fzf#install() } } : { 'on': [] }
Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode'))
Plug 'kyazdani42/nvim-web-devicons', Cond(!exists('g:vscode'))
Plug 'maxbrunsfeld/vim-yankstack', Cond(!exists('g:vscode'))
Plug 'michaeljsmith/vim-indent-object', Cond(!exists('g:vscode'))
Plug 'neoclide/coc.nvim', !exists('g:vscode') ? {'branch': 'release'} : { 'on': [] }
Plug 'nvim-lualine/lualine.nvim', Cond(!exists('g:vscode'))
Plug 'will-ockmore/vim-notes', Cond(!exists('g:vscode'))

" Installed for both vscode-neovim and terminal vim
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'nvim-treesitter/nvim-treesitter',  {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

call plug#end()

""""""""""""""""""""""""""""""
" => nvim-treesitter
""""""""""""""""""""""""""""""

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "typescript", "javascript", "html", "yaml", "json" },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aP"] = "@parameter.outer",
        ["iP"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]P"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[P"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
EOF

""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
if !exists('g:vscode')
    let g:yankstack_yank_keys = ['y', 'd']

    nmap <c-p> <Plug>yankstack_substitute_older_paste
    nmap <c-n> <Plug>yankstack_substitute_newer_paste
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lualine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:vscode')
lua << EOF
require('lualine').setup {
 options = {
     theme = "nightfox"
 }
}
EOF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    set rtp+=~/.fzf
    set rtp+=/usr/local/opt/fzf

    " Search filenames
    command! -bang -nargs=? -complete=dir FzfFilesWithPreview
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    nnoremap <C-f> :FZF<CR>
    nnoremap <leader>f :FzfFilesWithPreview!<CR>

    " Search file contents (Ctrl-shift-f behaviour)
    nnoremap <leader>g :Rg<Space>

    " Search buffers
    nnoremap <leader>b :Buffers<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:vscode')
    let g:coc_global_extensions = [
    \ 'coc-emoji', 'coc-eslint', 'coc-tsserver',
    \ 'coc-css', 'coc-json', 'coc-yaml',
    \ 'coc-rls', 'coc-diagnostic', 'coc-pyright',
    \ 'coc-snippets'
    \]

    " if hidden is not set, TextEdit might fail.
    set hidden
    " " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup
    " You will have bad experience for diagnostic messages when it's default 4000.
    set updatetime=300
    "" don't give |ins-completion-menu| messages.
    set shortmess+=c
    " always show signcolumns
    set signcolumn=yes

    "" Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)


    "" Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
      else
          call CocAction('doHover')
      endif
    endfunction

    "" Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-notes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    nnoremap <leader>ne :Notes<CR>
    let g:vim_notes_date_format = "%Y-%m-%d"
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vscode')
    set termguicolors
    " Avoid the background bleed in tmux
    " See https://sunaku.github.io/vim-256color-bce.html
    set t_ut=
    colorscheme nightfox
endif
