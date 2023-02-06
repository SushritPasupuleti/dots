local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

vim.cmd([[
	set encoding=utf-8
	au ColorScheme * hi Normal ctermbg=none guibg=none
]])
vim.opt.termguicolors = true

require("lazy").setup({
	--====Catppuccin
	--Theme must be loaded first and must never be lazy loaded
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true,
				-- term_colors = true,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					hop = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					treesitter = true,
					lsp_saga = true,
					mason = true,
					notify = true,
					which_key = true,
					harpoon = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
				},
			})

			vim.cmd([[colorscheme catppuccin]])
		end,
	}, --tag = "v0.2.7" },
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-lualine/lualine.nvim",
	{ "preservim/nerdtree", dependencies = {
		"Xuyuanp/nerdtree-git-plugin",
	} },
	"http://github.com/tpope/vim-surround",
	"ap/vim-css-color",
	"ryanoasis/vim-devicons", -- Developer Icons
	"tc50cal/vim-terminal", -- Vim Terminal
	"preservim/tagbar", -- Tagbar for code navigation
	"rafi/awesome-vim-colorschemes", -- Retro Scheme
	"yamatsum/nvim-cursorline", -- For line/keyword highlighting
	{ "mg979/vim-visual-multi", branch = "master" },
	"windwp/nvim-autopairs",
	"tpope/vim-fugitive", -- git
	"lewis6991/gitsigns.nvim", -- git signs
	"maxmellon/vim-jsx-pretty",
	-- "github/copilot.vim",
	"zbirenbaum/copilot.lua",
	-- for auto completion
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	--
	-- For luasnip users.
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	--
	-- Bufferline for tabs
	"kyazdani42/nvim-web-devicons", -- Recommended (for coloured icons)
	"kyazdani42/nvim-tree.lua",
	"akinsho/bufferline.nvim",
	--
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				-- show_current_context_start = true,
			})
		end,
	}, -- indent lines
	--
	-- Telescope
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	--
	"folke/which-key.nvim",
	--
	-- Markdown Preview
	{ "ellisonleao/glow.nvim", branch = "main" },
	--
	-- Sessions
	"rmagatti/auto-session",
	"rmagatti/session-lens",
	--
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			require("lspsaga").setup({
				theme = "round",
				-- colors = M.custom_colors(),
				-- kind = M.custom_kind(),
				-- toggle these in the future when the bugs stop
				colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
				kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
			})
		end,
	},
	--
	"petertriho/nvim-scrollbar",
	--
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",
	--
	-- Snippets
	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		run = "yarn install --frozen-lockfile && yarn compile",
	},
	{
		"vscodeshift/material-ui-snippets",
		run = "yarn install --frozen-lockfile && yarn build",
	},
	--
	"folke/lsp-colors.nvim",
	--
	"folke/trouble.nvim",
	--
	"numToStr/Comment.nvim", -- Comment things
	-- 'karb94/neoscroll.nvim' -- Smooth Scroll
	-- 'ahmedkhalf/project.nvim' --Project Manager
	"gennaro-tedesco/nvim-jqx",
	--
	"goolord/alpha-nvim", --Dashboard
	-- 'nvim-neo-tree/neo-tree.nvim' -- Neo Tree
	-- 'MunifTanjim/nui.nvim' --NUI
	"mbbill/undotree",
	"tanvirtin/vgit.nvim", --Visual Git
	"kdheepak/lazygit.nvim",
	--
	-- Zen Mode
	"folke/zen-mode.nvim",
	--
	"windwp/nvim-spectre",
	"axieax/urlview.nvim",
	"lalitmee/browse.nvim", -- Browse things
	--
	--====Color Schemes====
	"rebelot/kanagawa.nvim",
	"cpea2506/one_monokai.nvim",
	"tiagovla/tokyodark.nvim",
	"olimorris/onedarkpro.nvim",
	--
	"akinsho/toggleterm.nvim", -- Toggle Terminal
	"rcarriga/nvim-notify", -- Notification Manager
	"stevearc/dressing.nvim",
	"ziontee113/icon-picker.nvim", -- Icon Picker
	--
	--====LSP Config====
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"onsails/lspkind.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	--
	"folke/neodev.nvim",
	--===DAP===
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	--
	--===Motions
	-- 'easymotion/vim-easymotion'
	"phaazon/hop.nvim",
	"ur4ltz/move.nvim",
	--
	--===Manage and view Keybindings
	"FeiyouG/command_center.nvim",
	--
	--===Auto Relative Numbers
	"nkakouros-original/numbers.nvim",
	--
	--===Time Tracking Needs other Setup(https://github.com/git-time-metric/gtm)
	"git-time-metric/gtm-vim-plugin",
	--
	"gaborvecsei/memento.nvim",
	--
	-- Rust
	"simrat39/rust-tools.nvim",
	--
	-- Games
	"ThePrimeagen/vim-be-good",
	--
	-- Yank History
	"AckslD/nvim-neoclip.lua",
	{
		"jcdickinson/wpm.nvim",
		config = function()
			require("wpm").setup({})
		end,
	},
	-- JUPYTER
	-- "luk400/vim-jukit",
	"hkupty/iron.nvim",
	{ "GCBallesteros/vim-textobj-hydrogen", dependencies = { "kana/vim-textobj-user", "kana/vim-textobj-line" } },
	"GCBallesteros/jupytext.vim",

	-- GitHub
	{
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
		end,
	},
})

-- Essential Configs

vim.opt.number = true
-- I don't like relativenumber personally.
-- vim.opt.relativenumber
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.mouse = "a"
vim.opt.cursorline = true
-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")
-- vim.opt.cursorcolumn
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

vim.g.do_filetype_lua = 1

-- vim.api.nvim_set_hl(0, "Normal", { ctermbg = none, guibg = none })

--== LazyGit

vim.g.lazygit_floating_window_winblend = 5 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
-- vim.g.lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] -- customize lazygit popup window corner characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

-- Time tracking (needs system-side setup (https://github.com/git-time-metric/gtm))
vim.g.gtm_plugin_status_enabled = 1

-- Easy Motion
vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings

--VSnip
vim.o.completeopt = "menu,menuone,noselect"
vim.g.vsnip_filetypes = {}
vim.g.vsnip_filetypes.javascriptreact = { "javascript" }
vim.g.vsnip_filetypes.typescriptreact = { "typescript" }

vim.cmd([[
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
]])

-- call Main Config
require("main_config")
