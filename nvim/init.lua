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
	checker = { enabled = true }, -- automatically check for plugin updates
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	--====Catppuccin
	--Theme must be loaded first and must never be lazy loaded
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("sushrit_lawliet.catppuccin")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.tree_sitter")
		end,
	},
	{
		"jcdickinson/wpm.nvim",
		event = "BufReadPost",
		config = function()
			require("wpm").setup({})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		-- enabled = false,
		event = "VimEnter",
		config = function()
			require("sushrit_lawliet.statusline")
		end,
	},
	{
		"freddiehaddad/feline.nvim",
		-- version = "1.1.1",
		branch = "main",
		event = "VimEnter",
		lazy = false,
		enabled = false,
		config = function()
			-- require("sushrit_lawliet.feline")
			-- require("feline").setup({})
			--require('feline').statuscolumn.setup()
			-- require("feline").winbar.setup()
			-- local ctp_feline = require("catppuccin.groups.integrations.feline")
			--
			-- ctp_feline.setup()
			--
			-- require("feline").setup({
			-- 	components = ctp_feline.get(),
			-- })
		end,
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "zbirenbaum/copilot.lua" }, -- or "zbirenbaum/copilot.lua"
		lazy = true,
		event = "BufReadPost",
		config = function()
			require("copilot_status").setup({
				icons = {
					idle = " ",
					error = " ",
					offline = " ",
					warning = " ",
					loading = " ",
				},
				debug = false,
			})
		end,
	},
	{
		"preservim/nerdtree",
		dependencies = {
			"Xuyuanp/nerdtree-git-plugin",
		},
		enabled = false,
	},
	--====LSP Config====--
	{
		"folke/neodev.nvim",
		opts = { experimental = { pathStrict = true } },
		event = { "BufRead", "BufNewFile" },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- "onsails/lspkind.nvim",
			"simrat39/rust-tools.nvim",
		},
		config = function()
			require("sushrit_lawliet.lspconfig")
		end,
	},
	{
		"JASONews/glow-hover",
		config = function()
			require("glow-hover").setup({})
		end,
	},
	{
		"j-hui/fidget.nvim",
		-- enabled=false,
		event = "VimEnter",
		config = function()
			require("fidget").setup({
				text = {
					spinner = "dots_negative",
				},
				window = {
					relative = "win", -- where to anchor, either "win" or "editor"
					blend = 0,        -- &winblend for the window
					zindex = nil,     -- the zindex value for the window
					border = "none",  -- style of border for the fidget window
				},
			})
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	},
	{
		"dnlhc/glance.nvim",
		-- enabled=false,
		config = function()
			require("glance").setup({
				-- your configuration
			})
		end,
	},
	{
		"folke/lsp-colors.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons",     -- optional
		},
		event = "LspAttach",
		-- enabled = false,
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					virtual_text = false,
					enable = false,
				},
				ui = {
					border = "single",
				},
				-- *NOTE*: Disabled inline diagnostics for now
				-- as it causes a lot of issues
				diagnostic = {
					on_insert = false,       --true,
					on_insert_follow = true, --false,
					-- insert_winblend = 0,
					show_virt_line = false,  --true,
					-- show_code_action = false, --true,
					-- show_source = false, --true,
					-- jump_num_shortcut = false, --true,
				},
				-- colors = M.custom_colors(),
				-- kind = M.custom_kind(),
				-- toggle these in the future when the bugs stop
				colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
				kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
				breadcrumbs = {
					enable = false,
				},
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.lspkind")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		name = "null-ls",
		config = function()
			require("sushrit_lawliet.null-ls")
		end,
	},
	-- {
	--     "folke/which-key.nvim",
	--     config = function()
	--         vim.o.timeout = true
	--         vim.o.timeoutlen = 300
	--         require("which-key").setup({
	--             -- your configuration comes here
	--             -- or leave it empty to use the default settings
	--             -- refer to the configuration section below
	--         })
	--     end,
	-- },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
		},
		config = function(_, opts)
			vim.o.timeoutlen = 300
			vim.o.timeout = true
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>sn"] = { name = "+noice" },
				["<leader>u"] = { name = "+ui" },
				-- ["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			})
		end,
	},
	{
		"ellisonleao/glow.nvim",
		branch = "main",
		event = "BufRead",
		ft = {
			"markdown",
			"md",
		},
		config = function()
			require("glow").setup({
				-- glow_path = "", -- will be filled automatically with your glow bin in $PATH, if any
				-- install_path = "~/.local/bin", -- default path for installing glow binary
				border = "solid", -- floating window border config
				-- style = "dark", -- filled automatically with your current editor background, you can override using glow json style
				-- pager = true,
				-- width = 80,
				height_ratio = 0.8,
				width_ratio = 0.8,
			})
		end,
	},
	-- Sessions
	-- {
	--     "rmagatti/session-lens",
	--     dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
	--     config = function()
	--         require("session-lens").setup({--[[your custom config--]]
	--         })
	--     end,
	--     -- event="VeryLazy",
	--     event = "VimEnter",
	-- },
	{
		"rmagatti/auto-session",
		-- enabled = false,
		config = function()
			require("auto-session").setup({
				log_level = "error",
				-- auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
		event = "VimEnter",
	},
	-- {
	--     "nvim-lua/plenary.nvim",
	--     lazy = true
	-- },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		event = "VimEnter",
		-- event="VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("sushrit_lawliet.telescope")
		end,
	},
	{
		"FeiyouG/command_center.nvim",
		-- event="VeryLazy",
		event = "VimEnter",
		config = function()
			require("sushrit_lawliet.command-center")
		end,
	},
	{
		"dimaportenko/telescope-simulators.nvim",
		-- event={"BufReadPost", "BufNewFile"},
		event = "VimEnter",
		name = "simulators",
		config = function()
			require("simulators").setup({
				android_emulator = true,
				apple_simulator = true,
			})
			require("telescope").load_extension("simulators")
		end,
	},
	{
		"Marskey/telescope-sg",
		event = "VimEnter",
		name = "ast_grep",
	},
	{
		"petertriho/nvim-scrollbar",
		event = { "BufRead", "BufNewFile" },
		opts = {
			show = true,
			show_in_active_only = false,
			set_highlights = true,
			folds = 1000,      -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
			max_lines = false, -- disables if no. of lines in buffer exceeds this
			handle = {
				text = " ",
				color = nil,
				cterm = nil,
				highlight = "CursorColumn",
				hide_if_all_visible = true, -- Hides handle if all lines are visible
			},
			marks = {
				Search = {
					text = { "-", "=" },
					priority = 0,
					color = nil,
					cterm = nil,
					highlight = "Search",
				},
				Error = {
					text = { "-", "=" },
					priority = 1,
					color = nil,
					cterm = nil,
					highlight = "DiagnosticVirtualTextError",
				},
				Warn = {
					text = { "-", "=" },
					priority = 2,
					color = nil,
					cterm = nil,
					highlight = "DiagnosticVirtualTextWarn",
				},
				Info = {
					text = { "-", "=" },
					priority = 3,
					color = nil,
					cterm = nil,
					highlight = "DiagnosticVirtualTextInfo",
				},
				Hint = {
					text = { "-", "=" },
					priority = 4,
					color = nil,
					cterm = nil,
					highlight = "DiagnosticVirtualTextHint",
				},
				Misc = {
					text = { "-", "=" },
					priority = 5,
					color = nil,
					cterm = nil,
					highlight = "Normal",
				},
			},
			excluded_buftypes = {
				"terminal",
			},
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
			},
			autocmd = {
				render = {
					"BufWinEnter",
					"TabEnter",
					"TermEnter",
					"WinEnter",
					"CmdwinLeave",
					"TextChanged",
					"VimResized",
					"WinScrolled",
				},
				clear = {
					"BufWinLeave",
					"TabLeave",
					"TermLeave",
					"WinLeave",
				},
			},
			handlers = {
				diagnostic = true,
				search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
			},
		},
	},
	{
		"piersolenski/telescope-import.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("import")
		end,
	},
	{
		-- for auto completion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Additional Sources:
			"kdheepak/cmp-latex-symbols",
			"andersevenrud/cmp-tmux",
			"mtoohey31/cmp-fish",
			"hrsh7th/cmp-nvim-lua",
			-- opts = {
			--     window = {
			--         completion = {
			--             border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			--             winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
			--         },
			--         documentation = {
			--             border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			--             winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
			--         },
			--     },
			-- },
		},
		event = {
			"InsertEnter",
			"BufRead",
		},
		config = function()
			require("sushrit_lawliet.snippets")
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = false,
		event = { "BufRead" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"David-Kunz/cmp-npm",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "json",
		config = function()
			require("cmp-npm").setup({})
		end,
	},
	-- Yank History
	{
		"AckslD/nvim-neoclip.lua",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"kyazdani42/nvim-tree.lua",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("nvim-tree").setup({
				auto_reload_on_write = true,
				renderer = {
					add_trailing = false,
					group_empty = false,
					highlight_git = false,
					full_name = false,
					highlight_opened_files = "none",
					root_folder_modifier = ":~",
					indent_markers = {
						enable = false,
						icons = {
							corner = "└ ",
							edge = "│ ",
							item = "│ ",
							none = "  ",
						},
					},
					icons = {
						webdev_colors = true,
						git_placement = "before",
						padding = " ",
						symlink_arrow = " ➛ ",
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
						glyphs = {
							default = "",
							symlink = "",
							folder = {
								arrow_closed = "",
								arrow_open = "",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌",
							},
						},
					},
					special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false,
		event = "VeryLazy",
	},
	{
		"http://github.com/tpope/vim-surround",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"ap/vim-css-color",
		event = { "BufRead", "BufNewFile" },
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"ryanoasis/vim-devicons", -- Developer Icons
		event = { "BufRead", "BufNewFile" },
	},
	{
		"tc50cal/vim-terminal", -- Vim Terminal
		event = "VeryLazy",
	},
	{
		"preservim/tagbar", -- Tagbar for code navigation
		enabled = false,
		event = { "BufRead", "BufNewFile" },
	},
	{
		"rafi/awesome-vim-colorschemes", -- Retro Scheme
		event = "VeryLazy",
	},
	{
		"yamatsum/nvim-cursorline", -- For line/keyword highlighting
		event = { "BufRead", "BufNewFile" },
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
		enabled = false,
	},
	{
		"windwp/nvim-autopairs",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"tpope/vim-fugitive", -- git
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim", -- git signs
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"maxmellon/vim-jsx-pretty",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("sushrit_lawliet.copilot")
		end,
	},
	{
		"hrsh7th/vim-vsnip",
		dependencies = {
			"hrsh7th/vim-vsnip-integ",
		},
		-- enabled = false,
	},
	-- Snippets
	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		run = "yarn install --frozen-lockfile && yarn compile",
		event = { "BufRead", "BufNewFile" },
		name = "vscode-es7-javascript-react-snippets",
	},
	{
		"vscodeshift/material-ui-snippets",
		run = "yarn install --frozen-lockfile && yarn build",
		event = { "BufRead", "BufNewFile" },
		name = "material-ui-snippets",
	},
	{
		"folke/trouble.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.diagnostics")
		end,
	},
	{
		"numToStr/Comment.nvim", -- Comment things
		event = "bufReadPost",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"gennaro-tedesco/nvim-jqx",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"mbbill/undotree",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"tanvirtin/vgit.nvim", --Visual Git
		event = { "BufRead", "BufNewFile" },
	},
	{
		"kdheepak/lazygit.nvim",
		enabled = false,
	},
	{
		"windwp/nvim-spectre",
		event = "bufReadPost",
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			require("sushrit_lawliet.toggle-term")
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"ziontee113/icon-picker.nvim", -- Icon Picker
		opts = {
			disable_legacy_commands = true,
		},
		event = "BufReadPost",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- show_current_context = true,
		},
	}, -- indent lines
	{
		"ur4ltz/move.nvim",
		event = "BufReadPost",
	},
	{
		"nkakouros-original/numbers.nvim",
		event = "BufReadPost",
		opts = {
			excluded_filetypes = {
				"nerdtree",
			},
		},
	},
	{
		"git-time-metric/gtm-vim-plugin",
		event = "BufReadPost",
		enabled = false,
	},
	{
		"gaborvecsei/memento.nvim",
		event = "VeryLazy",
	},
	{
		"ThePrimeagen/vim-be-good",
		event = "VeryLazy",
		enabled = false,
	},
	{
		"pwntester/octo.nvim",
		event = "VeryLazy",
		config = function()
			require("octo").setup()
		end,
	},
	-- "hkupty/iron.nvim",
	-- { "GCBallesteros/vim-textobj-hydrogen", dependencies = { "kana/vim-textobj-user", "kana/vim-textobj-line" } },
	-- "GCBallesteros/jupytext.vim",
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		config = true,
		event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		keys = {
			{
				"<leader>vs",
				"<cmd>:VenvSelect<cr>",
				"<leader>vc",
				"<cmd>:VenvSelectCached<cr>",
			},
		},
		opts = {
			-- search = false,
			search_workspace = true,
			name = { "venv", ".venv" },
		},
	},
	{
		"elihunter173/dirbuf.nvim",
		event = "VeryLazy",
		config = function()
			require("dirbuf").setup({
				hash_padding = 2,
				show_hidden = true,
				sort_order = "default",
				write_cmd = "DirbufSync",
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("hlslens").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.dap")
		end,
	},
	{
		"axieax/urlview.nvim",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"lalitmee/browse.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.browse_config")
		end,
	},
	{
		"goolord/alpha-nvim",
		name = "alpha",
		commit = "21a0f2520ad3a7c32c0822f943368dc063a569fb",
		event = "VimEnter",
		config = function()
			require("sushrit_lawliet.dashboard")
			vim.cmd("Alpha")
		end,
	},
	{
		"smoka7/hop.nvim",
		enabled = true,
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.motions")
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VimEnter",
		config = function()
			require("sushrit_lawliet.notify")
		end,
	},
	{
		"shortcuts/no-neck-pain.nvim",
		event = "VimEnter",
		config = function()
			require("no-neck-pain").setup({
				width = 100,
				buffers = {
					-- blend = 0.3,
					left = {
						-- width = 60,
						bo = {
							filetype = "md",
						},
						scratchPad = {
							enabled = true,
							fileName = "notes-left",
							location = "~/Documents/Notes/",
						},
					},
					right = {
						-- width = 60,
						bo = {
							filetype = "md",
						},
						scratchPad = {
							enabled = true,
							fileName = "notes-right",
							location = "~/Documents/Notes/",
						},
					},
				},
				integrations = {
					-- NvimTree = {
					--     position = "left",
					--     reopen = true,
					-- },
					-- NeoTree = {
					--     position = "left",
					--     reopen = true,
					-- },
					undotree = {
						position = "left",
					},
				},
			})
		end,
	},
	{
		"folke/zen-mode.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("zen-mode").setup({
				window = {
					width = 0.85, -- width will be 85% of the editor width
					backdrop = 0,
					options = {
						signcolumn = "yes",
						number = true,
						relativenumber = true,
						cursorline = true,
						cursorcolumn = true,
						-- wrap=false,
						-- linebreak=false,
						-- spell=false,
						-- list=false,
					},
				},
				plugins = {
					options = {
						enabled = true,
						ruler = false,   -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
					},
					tmux = { enabled = false },
				},
			})
		end,
	},
	{
		"jose-elias-alvarez/typescript.nvim",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"wintermute-cell/gitignore.nvim",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
	},
	{
		"toppair/peek.nvim",
		event = { "BufRead", "BufNewFile" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		opts = {},
		enabled = false,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"edKotinsky/Arduino.nvim",
		name = "arduino",
		event = "BufRead filetype=ino",
		config = function()
			require("arduino").setup({
				clangd = require("mason-core.path").bin_prefix("clangd"),
				default_fqbn = "arduino:avr:uno",
			})
			local arduino_cmd = require("arduino").configure(vim.fn.getcwd())
		end,
		-- enabled = false,
	},
	{
		"stevearc/vim-arduino",
		name = "vim-arduino",
		event = "BufRead filetype=ino",
		config = function()
			require("vim-arduino").setup({})
			vim.g.arduino_use_cli = 1
		end,
		enabled = false,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		event = "VimEnter",
		-- enabled = false,
		config = function()
			require("neogit").setup({
				use_telescope = true,
				integrations = {
					diffview = true,
					telescope = true,
				},
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("sushrit_lawliet.typescript")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- enabled = false,
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{
				"S",
				mode = { "n", "o", "x" },
				function() require("flash").treesitter() end,
				desc =
				"Flash Treesitter"
			},
			{
				"r",
				mode = "o",
				function() require("flash").remote() end,
				desc =
				"Remote Flash"
			},
			{
				"R",
				mode = { "o", "x" },
				function() require("flash").treesitter_search() end,
				desc =
				"Treesitter Search"
			},
			{
				"<c-s>",
				mode = { "c" },
				function() require("flash").toggle() end,
				desc =
				"Toggle Flash Search"
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		enabled = false,
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			require("ufo").setup()
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		enabled = false,
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false,        -- use a classic bottom cmdline for search
					command_palette = false,      -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false,           -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false,       -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"richardbizik/nvim-toc",
		event = "filetype markdown",
		config = function()
			require("nvim-toc").setup({})
		end,
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{ "<leader>sv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
		},
		opts = {
			border = "rounded",          -- Valid window border style,
			show_unknown_classes = true, -- Shows the unknown classes popup
		},
	},
	{
		"Velrok/pr_status.nvim",
		enabled = false,
		event = "BufRead",
		config = function()
			require("pr_status").setup(
				{ auto_start = true } -- if you want it to just start
			)
		end,
	},
	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			telescope = {
				enable = true,
				keymaps = {
					search = "<leader>dd",
				},
			},
			wrap = true,
			ensure_installed = {
				"python-3.11",
				"go",
				"rust",
				"lua-5.4",
				"javascript",
				"typescript",
				"react",
				"react_native",
				"elixir-1.15",
				"fish-3.6",
				"latex",
				"markdown",
				"matplotlib-3.7",
				"nginx",
				"nix",
				"node",
				"numpy-1.23",
				"pandas-1",
				"phoenix",
				"postgresql-15",
				"pytorch",
				"redis",
				"redux",
				"sequelize-6",
				"socketio-4",
				"tailwindcss",
				"tensorflow-2.9",
				"terraform",
				"vagrant",
				"yarn-berry",
				"kubernetes",
				"kubectl",
				"jsdoc",
				"jq",
				"jest",
				"git",
				"flask-2.3",
				"fastapi",
				"express",
				"docker",
				"cypress",
				"bash",
				"axios",
				"ansible",
			},
			previewer_cmd = "glow",
			picker_cmd = true,
			cmd_args = { "-s", "dark", "-w", "80" },
			picker_cmd_args = { "-p" },
		},
		{
			"GCBallesteros/NotebookNavigator.nvim",
			keys = {
				{
					"]h",
					function()
						require("notebook-navigator").move_cell("d")
					end,
				},
				{
					"[h",
					function()
						require("notebook-navigator").move_cell("u")
					end,
				},
				{ "<leader>xp", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
				{ "<leader>xP", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
			},
			dependencies = {
				"echasnovski/mini.comment",
				"hkupty/iron.nvim",
				"anuvyklack/hydra.nvim",
			},
			event = "VeryLazy",
			config = function()
				local nn = require("notebook-navigator")
				nn.setup({ activate_hydra_keys = "<leader>h" })
			end,
		},
	},
	{
		"mhartington/formatter.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.formatter")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("sushrit_lawliet.nvim_lint")
		end,
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		version = "*",
		config = function()
			require("neogen").setup({
				languages = {
					["javascript.jsdoc"] = require("neogen.configurations.javascript"),
					["javascriptreact.jsdoc"] = require("neogen.configurations.javascriptreact"),
					["typescript.tsdoc"] = require("neogen.configurations.typescript"),
					["typescriptreact.tsdoc"] = require("neogen.configurations.typescriptreact"),
				},
			})
		end,
	},
	{
		"vidocqh/data-viewer.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kkharji/sqlite.lua", -- Optional, sqlite support
		},
	},
})

--options
require("sushrit_lawliet.options")
--remaps
require("sushrit_lawliet.remaps")
