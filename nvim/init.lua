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
        config=function()
            require("sushrit_lawliet.tree_sitter")
        end,
    },
    {
		"jcdickinson/wpm.nvim",
		event="BufReadPost",
		config = function()
			require("wpm").setup({})
		end,
	},
    {
        "nvim-lualine/lualine.nvim",
		event = "VimEnter",
        config=function()
            require("sushrit_lawliet.statusline")
        end,
    },
    { 
		"preservim/nerdtree", 
		dependencies = {
			"Xuyuanp/nerdtree-git-plugin",
		}, 
		enabled = false 
	},
    --====LSP Config====--
    { 
		"folke/neodev.nvim", 
		opts = { experimental = { pathStrict = true } },
		event={"BufRead","BufNewFile"},
	},
    {
        "neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
        dependencies={
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- "onsails/lspkind.nvim",
            "simrat39/rust-tools.nvim",
        },
        config=function()
			require("sushrit_lawliet.lspconfig")
        end,
    },
    {
        "folke/lsp-colors.nvim",
		event = { "BufReadPre", "BufNewFile" },
    },
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
    {
	    "onsails/lspkind.nvim",
		event={"BufRead","BufNewFile"},
        config=function()
			require("sushrit_lawliet.lspkind")
		end,
    },
    {
	    "jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
        config=function()
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
            ["<leader>w"] = { name = "+windows" },
            ["<leader>x"] = { name = "+diagnostics/quickfix" },
            })
        end,
    },
    {
	    "ellisonleao/glow.nvim", 
        branch = "main",
		event = "BufRead",
        ft={
            "markdown",
            "md",
        },
        config=function()
            require('glow').setup({
            -- glow_path = "", -- will be filled automatically with your glow bin in $PATH, if any
            -- install_path = "~/.local/bin", -- default path for installing glow binary
            border = "shadow", -- floating window border config
            -- style = "dark", -- filled automatically with your current editor background, you can override using glow json style
            -- pager = true,
            -- width = 80,
            height_ratio = 0.8,
            width_ratio = 0.8,
            })
        end,
    },
    	-- Sessions
	{
		"rmagatti/session-lens",
		dependencies={
			"rmagatti/auto-session",
		},
		-- event="VeryLazy",
		event="VimEnter",
	},
	-- { 
    --     "nvim-lua/plenary.nvim", 
    --     lazy = true 
    -- },
	{
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
		event="VimEnter",
		-- event="VeryLazy",
        dependencies= {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config=function()
            require("sushrit_lawliet.telescope")
        end,
    },
	{
	    "FeiyouG/command_center.nvim",
		-- event="VeryLazy",
		event="VimEnter",
		config=function()
			require("sushrit_lawliet.command-center")
		end,
	},
    {
	    "petertriho/nvim-scrollbar",
		event={"BufRead","BufNewFile"},
        opts={
            show = true,
            show_in_active_only = false,
            set_highlights = true,
            folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
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
        -- for auto completion
        "hrsh7th/nvim-cmp",
        dependencies={
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
	        "saadparwaiz1/cmp_luasnip",
        },
		event={
			"InsertEnter",
			"BufRead",
		},
        config=function()
            require("sushrit_lawliet.snippets")
        end,
    },
    -- Yank History
    {
	    "AckslD/nvim-neoclip.lua",
        event={"BufRead","BufNewFile"},
    },
    -- indent lines
    {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				-- show_current_context_start = true,
			})
		end,
	}, 
    {
        "kyazdani42/nvim-tree.lua",
		event={"BufRead","BufNewFile"},
        config=function()
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
        event = "VeryLazy",
    },
    {
		"http://github.com/tpope/vim-surround",
		event={"BufRead","BufNewFile"},
	},
    {
		"ap/vim-css-color",
		event={"BufRead","BufNewFile"},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"ryanoasis/vim-devicons", -- Developer Icons
		event={"BufRead","BufNewFile"},
	},
    {
		"tc50cal/vim-terminal", -- Vim Terminal
		event="VeryLazy",
	},
	{
		"preservim/tagbar", -- Tagbar for code navigation
		event={"BufRead","BufNewFile"},
	},
	{
		"rafi/awesome-vim-colorschemes", -- Retro Scheme
		event="VeryLazy",
	},
	{
		"yamatsum/nvim-cursorline", -- For line/keyword highlighting
		event={"BufRead","BufNewFile"},
	},
    { 
        "mg979/vim-visual-multi", 
        branch = "master",
        enabled=false,
    },
    {
        "windwp/nvim-autopairs",
		event={"BufRead","BufNewFile"},
    },
    {
        "tpope/vim-fugitive", -- git
		event="VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim", -- git signs
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require('gitsigns').setup()
		end
    },
	{
		"maxmellon/vim-jsx-pretty",
		event={"BufRead","BufNewFile"},
	},
    {
	    "zbirenbaum/copilot.lua",
		event="BufReadPost",
        config=function()
            require("sushrit_lawliet.copilot")
        end,
    },
    {
        	"hrsh7th/vim-vsnip",
            dependencies={
                "hrsh7th/vim-vsnip-integ",
            },
            enabled=false,
    },
    -- Snippets
	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		run = "yarn install --frozen-lockfile && yarn compile",
		event={"BufRead","BufNewFile"},
		name="vscode-es7-javascript-react-snippets",
	},
	{
		"vscodeshift/material-ui-snippets",
		run = "yarn install --frozen-lockfile && yarn build",
		event={"BufRead","BufNewFile"},
		name="material-ui-snippets",
	},
    {
	    "folke/trouble.nvim",
		event={"BufRead","BufNewFile"},
        config=function()
            require("sushrit_lawliet.diagnostics")
        end,
    },
    {
	    "numToStr/Comment.nvim", -- Comment things
		event="bufReadPost",
	},
    {
	    "gennaro-tedesco/nvim-jqx",
		event={"BufRead","BufNewFile"},
	},
    {
	    "mbbill/undotree",
		event={"BufRead","BufNewFile"},
    },
	{
		"tanvirtin/vgit.nvim", --Visual Git
		event={"BufRead","BufNewFile"},
	},
	{
		"kdheepak/lazygit.nvim",
		enabled=false,
	},
    {
        "windwp/nvim-spectre",
		event="bufReadPost",
    },
    {
        "akinsho/toggleterm.nvim",
		event="VeryLazy",
		config=function()
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
        opts={
            disable_legacy_commands = true
        },
		event="BufReadPost",
    },
    {
		"lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts={
			show_current_context = true,
        },
	}, -- indent lines
    {
        "ur4ltz/move.nvim",
		event = "BufReadPost",
    },
    {
	    "nkakouros-original/numbers.nvim",
		event="BufReadPost",
        opts={
            excluded_filetypes = {
                "nerdtree",
            },
        }
    },
    {
	    "git-time-metric/gtm-vim-plugin",
		event="BufReadPost",
    },
    {
        "gaborvecsei/memento.nvim",
        event="VeryLazy"
    },
    {
        "ThePrimeagen/vim-be-good",
        event="VeryLazy",
		enabled=false,
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
		"elihunter173/dirbuf.nvim",
		event="VeryLazy",
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
		event={"BufRead","BufNewFile"},
		config = function()
			require("hlslens").setup()
		end,
	},
    {
        "mfussenegger/nvim-dap",
        dependencies={
	        "rcarriga/nvim-dap-ui",
        },
        event={"BufRead","BufNewFile"},
        config=function()
            require("sushrit_lawliet.dap")
    	end,
    },
    {
	    "axieax/urlview.nvim",
        event={"BufRead","BufNewFile"},
    },
    {
        "lalitmee/browse.nvim",
        event={"BufRead","BufNewFile"},
        config=function()
            require("sushrit_lawliet.browse_config")
        end,
    },
    { 
        "goolord/alpha-nvim", 
        name = "alpha", 
        commit = "21a0f2520ad3a7c32c0822f943368dc063a569fb",
        event = "VimEnter",
        config=function()
            require('sushrit_lawliet.dashboard')
            vim.cmd("Alpha")
        end,
    },
    {
	    "phaazon/hop.nvim",
        event={"BufRead","BufNewFile"},
        config=function()
            require("sushrit_lawliet.motions")
        end,
    },
    {
       "rcarriga/nvim-notify",
	   event="VimEnter",
       	config=function()
			require("sushrit_lawliet.notify")
       	end,
    },
    {
	    "folke/zen-mode.nvim",
		event={"BufRead","BufNewFile"},
        config=function()
            require("zen-mode").setup({
                window = {
                    width = 0.85, -- width will be 85% of the editor width
                    backdrop = 0,
                    options={
                        signcolumn="yes",
                        number=true,
                        relativenumber=true,
                        cursorline=true,
                        cursorcolumn=true,
                        -- wrap=false,
                        -- linebreak=false,
                        -- spell=false,
                        -- list=false,
                    },
                },
                plugins = {
                    options = {
                        enabled = true,
                        ruler = false, -- disables the ruler text in the cmd line area
                        showcmd = false, -- disables the command in the last line of the screen
                    },
                    tmux = { enabled = false },
                }
            })
        end,
    },
})

--options
require("sushrit_lawliet.options")
--remaps
require("sushrit_lawliet.remaps")
