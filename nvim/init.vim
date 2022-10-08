" ----------------------------------------------------------------------------
" Will refactor this into Lua in the near future
" ----------------------------------------------------------------------------
:set number
" I don't like relativenumber personally.
" :set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set cursorline
":set cursorcolumn
:set wildmenu
:set wildmode=list:longest
:set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
:set termguicolors
" :set foldmethod=indent
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldmethod=syntax

:let mapleader = ","

" Yank to System Clipboard
" set clipboard+=unnamedplus

"call plug#begin()
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'vim-airline/vim-airline' " Status bar
" Plug 'vim-airline/vim-airline-themes' " Status bar themes
Plug 'nvim-lualine/lualine.nvim' " Lua line

Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'" NerdTree
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'ap/vim-css-color' " CSS Color Preview
" Plug 'neoclide/coc.nvim'  " Auto Completion
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'preservim/tagbar' " Tagbar for code navigation
" Plug 'terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
" Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'yamatsum/nvim-cursorline' " For line/keyword highlighting
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-fugitive'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'github/copilot.vim'

" For nvim autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Bufferline for tabs
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

Plug 'folke/which-key.nvim'
Plug 'windwp/nvim-autopairs'

Plug 'ellisonleao/glow.nvim', {'branch': 'main'}

" Sessions
Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'

Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

Plug 'petertriho/nvim-scrollbar'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Plug 'matze/vim-move'
" Plug 'fedepujol/move.nvim'

" Snippets
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }
Plug 'vscodeshift/material-ui-snippets', { 'do': 'yarn install --frozen-lockfile && yarn build' }

Plug 'folke/lsp-colors.nvim'

Plug 'folke/trouble.nvim'

Plug 'numToStr/Comment.nvim' " Comment things
" Plug 'karb94/neoscroll.nvim' " Smooth Scroll
" Plug 'ahmedkhalf/project.nvim' "Project Manager
Plug 'gennaro-tedesco/nvim-jqx'

Plug 'goolord/alpha-nvim' "Dashboard
" Plug 'nvim-neo-tree/neo-tree.nvim'" Neo Tree
" Plug 'MunifTanjim/nui.nvim' "NUI
Plug 'mbbill/undotree'
Plug 'tanvirtin/vgit.nvim' "Visual Git
Plug 'kdheepak/lazygit.nvim'

Plug 'folke/zen-mode.nvim'
Plug 'windwp/nvim-spectre'
Plug 'axieax/urlview.nvim'
Plug 'lalitmee/browse.nvim' " Browse things

"====Color Schemes====
Plug 'rebelot/kanagawa.nvim'
Plug 'cpea2506/one_monokai.nvim'
Plug 'tiagovla/tokyodark.nvim'
Plug 'olimorris/onedarkpro.nvim'

Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'} " Toggle Terminal
Plug 'rcarriga/nvim-notify' " Notification Manager
Plug 'stevearc/dressing.nvim'
Plug 'ziontee113/icon-picker.nvim' " Icon Picker

"====LSP Config====
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

"====Catppuccin
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

"===DAP===
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'


"===Motions
" Plug 'easymotion/vim-easymotion'
Plug 'phaazon/hop.nvim'

"===Manage and view Keybindings
Plug 'FeiyouG/command_center.nvim'

"===Auto Relative Numbers
Plug 'nkakouros-original/numbers.nvim'

"===Time Tracking Needs other Setup(https://github.com/git-time-metric/gtm)
Plug 'git-time-metric/gtm-vim-plugin'

Plug 'gaborvecsei/memento.nvim'

" CHADTree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

set encoding=UTF-8

call plug#end()

" Keybindings
nmap <C-b> :NERDTreeToggle<CR>

filetype on
filetype plugin on
filetype indent on
 
syntax on

"for transparency across any theme
"onedark has no transparency so this enables it
au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

" :colorscheme onedark

" let g:airline_theme='onedark'
" let g:airline_theme='ayu_dark'"'deus'"'powerlineish'
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline#extensions#whitespace#enabled = 0
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = '|'

" LazyGit

let g:lazygit_floating_window_winblend = 5 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
" let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed

" Time tracking (needs system-side setup (https://github.com/git-time-metric/gtm))
let g:gtm_plugin_status_enabled = 1

"telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fc <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fu <cmd>Telescope urlview theme=dropdown<cr>
nnoremap <leader>fk <CMD>Telescope command_center<CR>

" LSPSaga
" nnoremap <leader>rn <cmd>Lspsaga rename<cr>
" nnoremap <leader>ca <cmd>Lspsaga code_action<cr>
"nnoremap <silent> ge <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" nnoremap <silent><leader>k :Lspsaga hover_doc<CR>
" nnoremap <silent>gs :Lspsaga signature_help<CR>
" nnoremap <silent> gh :Lspsaga lsp_finder<CR>
" nnoremap <silent><space>e :Lspsaga show_line_diagnostics<CR>

" Spectre for Find and Replace
nnoremap <leader>S <cmd>lua require('spectre').open()<CR>
nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>
" GLow Preview
noremap <leader>p :Glow<CR>

" undotree
nnoremap <leader>z :UndotreeToggle<CR>

" Zen Mode
noremap <space>z :ZenMode<CR>
" let g:move_key_modifier = 'S'
" let g:move_key_modifier_visualmode = 'C'

" let g:glow_use_pager = v:true

" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
nnoremap <silent> <leader>gf :LazyGitFilter<CR>
nnoremap <silent> <leader>gc :LazyGitFilterCurrentFile<CR>

" Setup memento
nnoremap <leader>hh <cmd>lua require('memento').toggle()<CR>
nnoremap <leader>hc <cmd>lua require('memento').clear_history()<CR>

" Load Lua Configs
:lua require('main_config')

" nvim autocomplete
set completeopt=menu,menuone,noselect

" Snippets

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" let g:move_key_modifier = 'C'
" let g:move_key_modifier_visualmode = 'S'

" Move 1 more lines up or down in normal and visual selection modes.
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Easy Motion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader><Leader> <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" move to line
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" nmap <Leader>j <Plug>(easymotion-overwin-line)

" Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)
