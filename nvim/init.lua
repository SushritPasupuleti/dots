-- Base46 Config
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
-- End of Base46 Config

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
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
    -- Theme must be loaded first and must never be lazy loaded
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        -- enabled = false,
        priority = 1000,
        config = function()
            require("sushrit_lawliet.catppuccin")
        end,
    },
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", lazy = true },
    -- {
    --     "nvchad/ui",
    --     config = function()
    --         require("nvchad")
    --
    --         -- local opts = {
    --         -- 	base64 = {
    --         -- 		theme = "catppuccin-mocha",
    --         -- 	},
    --         -- }
    --         --
    --         -- return opts
    --     end,
    -- },
    -- {
    --     "nvchad/base46",
    --     lazy = true,
    --     build = function()
    --         require("base46").load_all_highlights()
    --         -- dofile(vim.g.base46_cache .. "base46")
    --     end,
    -- },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
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
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- enabled = false,
        event = "VimEnter",
        config = function()
            require("sushrit_lawliet.statusline")
        end,
    },
    -- {
    --     "freddiehaddad/feline.nvim",
    --     -- version = "1.1.1",
    --     branch = "main",
    --     -- event = "VimEnter",
    --     -- lazy = false,
    --     -- opts = {},
    --     enabled = false,
    --     config = function()
    --         -- require("feline").setup()
    --         -- require("feline").winbar.setup()
    --         require("sushrit_lawliet.feline")
    --         -- 	-- require("feline").setup({})
    --         -- 	--require('feline').statuscolumn.setup()
    --         -- 	-- require("feline").winbar.setup()
    --         -- 	-- local ctp_feline = require("catppuccin.groups.integrations.feline")
    --         -- 	--
    --         -- 	-- ctp_feline.setup()
    --         -- 	--
    --         -- 	-- require("feline").setup({
    --         -- 	-- 	components = ctp_feline.get(),
    --         -- })
    --     end,
    -- },
    -- {
    -- 	"utilyre/barbecue.nvim",
    -- 	name = "barbecue",
    -- 	version = "*",
    -- 	dependencies = {
    -- 		"SmiteshP/nvim-navic",
    -- 		"nvim-tree/nvim-web-devicons", -- optional dependency
    -- 	},
    -- 	opts = {
    -- 		-- configurations go here
    -- 		theme = "catppuccin-mocha", -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
    -- 	},
    -- },
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
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        ft = { "rust" },
    },
    {
        "SmiteshP/nvim-navic",
        -- name = "navic",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        -- enabled = false,
        config = function()
            require("nvim-navic").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                highlight = true,
                icons = {
                    File = " ",
                    Module = " ",
                    Namespace = " ",
                    Package = " ",
                    Class = " ",
                    Method = " ",
                    Property = " ",
                    Field = " ",
                    Constructor = " ",
                    Enum = " ",
                    Interface = " ",
                    Function = " ",
                    Variable = " ",
                    Constant = " ",
                    String = " ",
                    Number = " ",
                    Boolean = " ",
                    Array = " ",
                    Object = " ",
                    Key = " ",
                    Null = " ",
                    EnumMember = " ",
                    Struct = " ",
                    Event = " ",
                    Operator = " ",
                    TypeParameter = " ",
                },
            })
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
        enabled = false,
        event = "VimEnter",
        config = function()
            require("fidget").setup({
                -- text = {
                -- 	spinner = "dots_negative",
                -- },
                -- window = {
                -- 	relative = "win", -- where to anchor, either "win" or "editor"
                -- 	blend = 0,        -- &winblend for the window
                -- 	zindex = nil,     -- the zindex value for the window
                -- 	border = "none",  -- style of border for the fidget window
                -- },
                notification = {
                    window = {
                        winblend = 0,
                    },
                },
                display = {
                    progress_icon = {
                        pattern = "dots_negative",
                    },
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
                -- null_ls = {
                --     enabled = true,
                --     name = "crates.nvim",
                -- },
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
            "nvim-tree/nvim-web-devicons", -- optional
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
                    on_insert = false, --true,
                    on_insert_follow = true, --false,
                    -- insert_winblend = 0,
                    show_virt_line = false, --true,
                    -- show_code_action = false, --true,
                    -- show_source = false, --true,
                    -- jump_num_shortcut = false, --true,
                },
                symbol_in_winbar = {
                    enable = false,
                },
                -- colors = M.custom_colors(),
                -- kind = M.custom_kind(),
                -- toggle these in the future when the bugs stop
                -- colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
                -- kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
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
    -- none-ls removed: formatters handled by conform.nvim, diagnostics by nvim-lint
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
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        config = function()
            require("render-markdown").setup({})
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
            -- dofile(vim.g.base46_cache .. "telescope")
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
        "FabianWirth/search.nvim",
        name = "search",
        dependencies = { "nvim-telescope/telescope.nvim" },
        event = "VimEnter",
        config = function()
            require("search").setup({
                append_tabs = { -- append_tabs will add the provided tabs to the default ones
                    {
                        name = "Buffers",
                        tele_func = require("telescope.builtin").buffers,
                    },
                },
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        enabled = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("sushrit_lawliet.fzf")
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        event = { "BufRead", "BufNewFile" },
        opts = {
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
            -- "L3MON4D3/LuaSnip",
            -- "saadparwaiz1/cmp_luasnip",
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
            require("gitsigns").setup({
                -- numhl = true,
                current_line_blame = true,
            })
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
        -- enabled = false,
        config = function()
            require("sushrit_lawliet.copilot")
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        -- enabled = false,
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            debug = true, -- Enable debugging
            -- See Configuration section for rest
        },
        -- See Commands section for default commands if you want to lazy load on them
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
        "nvzone/floaterm",
        dependencies = "nvzone/volt",
        opts = {
            terminals = {
                { name = "Terminal" },
                -- cmd can be function too
                -- More terminals
            },
        },
        cmd = "FloatermToggle",
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
        "fedepujol/move.nvim",
        event = "BufReadPost",
        config = function()
            require("move").setup({})
        end,
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
        "GCBallesteros/jupytext.nvim",
        config = true,
        lazy = false,
        -- Depending on your nvim distro or config you may need to make the loading not lazy
        -- event = "BufRead filetype=ipynb",
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
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            "mfussenegger/nvim-dap-python", --optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = false,
        branch = "main",
        config = function(_, opts)
            require("venv-selector").setup(opts)
        end,
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
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                silent = true,
            },
        },
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
                        ruler = false, -- disables the ruler text in the cmd line area
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
            require("colorizer").setup({
                tailwind = true,
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
            border = "rounded", -- Valid window border style,
            show_unknown_classes = true, -- Shows the unknown classes popup
        },
    },
    {
        "luckasRanarison/tailwind-tools.nvim",
        opts = {}, -- your configuration
        enabled = false,
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
                nn.setup({ activate_hydra_keys = nil })
            end,
        },
    },
    {
        "mhartington/formatter.nvim",
        event = { "BufRead", "BufNewFile" },
        enabled = false,
        config = function()
            require("sushrit_lawliet.formatter")
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {},
        -- enabled = false,
        config = function()
            -- require('conform').setup()
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
    {
        "jghauser/mkdir.nvim",
    },
    {
        "folke/noice.nvim",
        enabled = false,
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
        config = function()
            require("sushrit_lawliet.noice")
        end,
    },
    {
        "aznhe21/actions-preview.nvim",
        event = { "BufRead", "BufNewFile" },
        -- keys = {
        -- 	{ "n", "<leader>gf", "<cmd>lua require('actions-preview').code_actions()<cr>" },
        -- { "v", "<leader>gf", "<cmd>lua require('actions-preview').range_code_actions()<cr>" },
        -- },
        config = function() end,
    },
    {
        "https://github.com/nocksock/do.nvim",
        config = function()
            require("do").setup({
                -- winbar = true,
                store = {
                    auto_create_file = true, -- automatically create a .do_tasks when calling :Do
                    file_name = ".do_tasks",
                },
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require("lsp_signature").setup(opts)
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- adapters
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-python",
        },
        config = function()
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup({
                require("neotest-go"),
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            })
        end,
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup({
                lsp_codelens = false,
                lsp_inlay_hints = {
                    enable = false,
                },
            })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    {
        "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
        event = { "BufReadPre", "BufNewFile" }, -- Activate when a file is created/opened
        enabled = false,
        -- ft = { "go", "javascript", "python", "ruby" }, -- Activate when a supported filetype is open
        cond = function()
            return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= "" -- Only activate if token is present in environment variable (remove to use interactive workflow)
        end,
        opts = {
            statusline = {
                enabled = true, -- Hook into the builtin statusline to indicate the status of the GitLab Duo Code Suggestions integration
            },
        },
    },
    {
        "b0o/schemastore.nvim",
        event = "BufRead",
    },
    {
        "gorbit99/codewindow.nvim",
        enabled = false,
        init = function()
            require("codewindow").apply_default_keybinds()
        end,
    },
    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("yaml_schema")
            require("yaml-companion").setup({
                -- telescope = {
                -- 	enabled = true,
                -- },
            })
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            notifier = { enabled = false },
            quickfile = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            scratch = { enabled = true },
        },
        {
            "marcussimonsen/let-it-snow.nvim",
            cmd = "LetItSnow", -- Wait with loading until command is run
            opts = {},
        },
        {
            "seblyng/roslyn.nvim",
            ft = "cs",
            ---@module 'roslyn.config'
            ---@type RoslynNvimConfig
            opts = {
                -- your configuration comes here; leave empty for default settings
                -- NOTE: You must configure `cmd` in `config.cmd` unless you have installed via mason
            },
        },
    },
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
        },
        opts = {
            -- NOTE: The log_level is in `opts.opts`
            opts = {
                -- log_level = "DEBUG", -- or "TRACE"
            },
        },
        config = function()
            require("sushrit_lawliet.agent")
        end,
    },
    -- keys = {
    -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer"},
    -- },

    -- {
    --     "Cannon07/claude-preview.nvim",
    --     -- enabled = false,
    --     config = function()
    --         require("claude-preview").setup({
    --             diff = {
    --                 layout = "inline",
    --             },
    --         })
    --         -- install by running: `:CodePreviewInstallOpenCodeHooks`
    --     end,
    -- },
    {
        "sudo-tee/opencode.nvim",
        -- enabled = false,
        config = function()
            require("opencode").setup({
                preferred_picker = "telescope", -- 'telescope', 'fzf', 'mini.pick', 'snacks', 'select', if nil, it will use the best available picker. Note mini.pick does not support multiple selections
                preferred_completion = "nvim-cmp", -- 'blink', 'nvim-cmp','vim_complete' if nil, it will use the best available completion
                default_mode = "build", -- 'build' or 'plan' or any custom configured. @see [OpenCode Agents](https://opencode.ai/docs/modes/)
                default_system_prompt = nil, -- Custom system prompt to use for all sessions. If nil, uses the default built-in system prompt
                default_global_keymaps = true, -- If false, disables all default global keymaps
                keymap_prefix = "<leader>o", -- Default keymap prefix for global keymaps change to your preferred prefix and it will be applied to all keymaps starting with <leader>o
                opencode_executable = "opencode", -- Name of your opencode binary

                -- Server configuration for custom/external opencode servers
                server = {
                    url = nil, -- URL/hostname (e.g., 'http://192.168.1.100', 'localhost', 'https://myserver.com')
                    port = nil, -- Port number (e.g., 8080), 'auto' for random port
                    timeout = 5, -- Health check timeout in seconds when connecting
                    spawn_command = nil, -- Optional function to start the server: function(port, url) ... end
                    auto_kill = true, -- Kill spawned servers when last nvim instance exits (default: true) Only applies to servers spawned by the plugin with spawn_command/kill_command
                    path_map = nil, -- Map host paths to server paths: string ('/app') or function(path) -> string
                },

                keymap = {
                    editor = {
                        ["<leader>og"] = { "toggle" }, -- Open opencode. Close if opened
                        ["<leader>oi"] = { "open_input" }, -- Opens and focuses on input window on insert mode
                        ["<leader>oI"] = { "open_input_new_session" }, -- Opens and focuses on input window on insert mode. Creates a new session
                        ["<leader>oo"] = { "open_output" }, -- Opens and focuses on output window
                        ["<leader>ot"] = { "toggle_focus" }, -- Toggle focus between opencode and last window
                        ["<leader>oT"] = { "timeline" }, -- Display timeline picker to navigate/undo/redo/fork messages
                        ["<leader>oq"] = { "close" }, -- Close UI windows
                        ["<leader>os"] = { "select_session" }, -- Select and load a opencode session
                        ["<leader>oR"] = { "rename_session" }, -- Rename current session
                        ["<leader>op"] = { "configure_provider" }, -- Quick provider and model switch from predefined list
                        ["<leader>oV"] = { "configure_variant" }, -- Switch model variant for the current model
                        ["<leader>oy"] = { "add_visual_selection", mode = { "v" } },
                        ["<leader>oY"] = { "add_visual_selection_inline", mode = { "v" } }, -- Insert visual selection as inline code block in the input buffer
                        ["<leader>oz"] = { "toggle_zoom" }, -- Zoom in/out on the Opencode windows
                        ["<leader>ov"] = { "paste_image" }, -- Paste image from clipboard into current session
                        ["<leader>od"] = { "diff_open" }, -- Opens a diff tab of a modified file since the last opencode prompt
                        ["<leader>o]"] = { "diff_next" }, -- Navigate to next file diff
                        ["<leader>o["] = { "diff_prev" }, -- Navigate to previous file diff
                        ["<leader>oc"] = { "diff_close" }, -- Close diff view tab and return to normal editing
                        ["<leader>ora"] = { "diff_revert_all_last_prompt" }, -- Revert all file changes since the last opencode prompt
                        ["<leader>ort"] = { "diff_revert_this_last_prompt" }, -- Revert current file changes since the last opencode prompt
                        ["<leader>orA"] = { "diff_revert_all" }, -- Revert all file changes since the last opencode session
                        ["<leader>orT"] = { "diff_revert_this" }, -- Revert current file changes since the last opencode session
                        ["<leader>orr"] = { "diff_restore_snapshot_file" }, -- Restore a file to a restore point
                        ["<leader>orR"] = { "diff_restore_snapshot_all" }, -- Restore all files to a restore point
                        ["<leader>ox"] = { "swap_position" }, -- Swap Opencode pane left/right
                        ["<leader>ott"] = { "toggle_tool_output" }, -- Toggle tools output (diffs, cmd output, etc.)
                        ["<leader>otr"] = { "toggle_reasoning_output" }, -- Toggle reasoning output (thinking steps)
                        ["<leader>o/"] = { "quick_chat", mode = { "n", "x" } }, -- Open quick chat input with selection context in visual mode or current line context in normal mode
                    },
                    input_window = {
                        ["<S-cr>"] = { "submit_input_prompt", mode = { "n", "i" } }, -- Submit prompt (normal mode and insert mode)
                        ["<esc>"] = { "close", defer_to_completion = true }, -- Close UI windows
                        ["<C-c>"] = { "cancel", defer_to_completion = true }, -- Cancel opencode request while it is running
                        ["~"] = { "mention_file", mode = "i" }, -- Pick a file and add to context. See File Mentions section
                        ["@"] = { "mention", mode = "i" }, -- Insert mention (file/agent)
                        ["/"] = { "slash_commands", mode = "i" }, -- Pick a command to run in the input window
                        ["#"] = { "context_items", mode = "i" }, -- Manage context items (current file, selection, diagnostics, mentioned files)
                        ["<M-v>"] = { "paste_image", mode = "i" }, -- Paste image from clipboard as attachment
                        ["<tab>"] = { "toggle_pane", mode = { "n", "i" }, defer_to_completion = true }, -- Toggle between input and output panes
                        ["<up>"] = { "prev_prompt_history", mode = { "n", "i" }, defer_to_completion = true }, -- Navigate to previous prompt in history
                        ["<down>"] = { "next_prompt_history", mode = { "n", "i" }, defer_to_completion = true }, -- Navigate to next prompt in history
                        ["<M-m>"] = { "switch_mode" }, -- Switch between modes (build/plan)
                        ["<M-r>"] = { "cycle_variant", mode = { "n", "i" } }, -- Cycle through available model variants
                    },
                    output_window = {
                        ["<esc>"] = { "close" }, -- Close UI windows
                        ["<C-c>"] = { "cancel" }, -- Cancel opencode request while it is running
                        ["]]"] = { "next_message" }, -- Navigate to next message in the conversation
                        ["[["] = { "prev_message" }, -- Navigate to previous message in the conversation
                        ["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle between input and output panes
                        ["i"] = { "focus_input", "n" }, -- Focus on input window and enter insert mode at the end of the input from the output window
                        ["<M-r>"] = { "cycle_variant", mode = { "n" } }, -- Cycle through available model variants
                        ["<leader>oS"] = { "select_child_session" }, -- Select and load a child session
                        ["<leader>oD"] = { "debug_message" }, -- Open raw message in new buffer for debugging
                        ["<leader>oO"] = { "debug_output" }, -- Open raw output in new buffer for debugging
                        ["<leader>ods"] = { "debug_session" }, -- Open raw session in new buffer for debugging
                    },
                    session_picker = {
                        rename_session = { "<C-r>" }, -- Rename selected session in the session picker
                        delete_session = { "<C-d>" }, -- Delete selected session in the session picker
                        new_session = { "<C-s>" }, -- Create and switch to a new session in the session picker
                    },
                    timeline_picker = {
                        undo = { "<C-u>", mode = { "i", "n" } }, -- Undo to selected message in timeline picker
                        fork = { "<C-f>", mode = { "i", "n" } }, -- Fork from selected message in timeline picker
                    },
                    history_picker = {
                        delete_entry = { "<C-d>", mode = { "i", "n" } }, -- Delete selected entry in the history picker
                        clear_all = { "<C-X>", mode = { "i", "n" } }, -- Clear all entries in the history picker
                    },
                    model_picker = {
                        toggle_favorite = { "<C-f>", mode = { "i", "n" } },
                    },
                    mcp_picker = {
                        toggle_connection = { "<C-t>", mode = { "i", "n" } }, -- Toggle MCP server connection in the MCP picker
                    },
                },
                ui = {
                    enable_treesitter_markdown = true, -- Use Treesitter for markdown rendering in the output window (default: true).
                    position = "right", -- 'right' (default), 'left' or 'current'. Position of the UI split. 'current' uses the current window for the output.
                    input_position = "bottom", -- 'bottom' (default) or 'top'. Position of the input window
                    window_width = 0.40, -- Width as percentage of editor width
                    zoom_width = 0.8, -- Zoom width as percentage of editor width
                    display_model = true, -- Display model name on top winbar
                    display_context_size = true, -- Display context size in the footer
                    display_cost = true, -- Display cost in the footer
                    window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder", -- Highlight group for the opencode window
                    persist_state = true, -- Keep buffers when toggling/closing UI so window state restores quickly
                    icons = {
                        preset = "nerdfonts", -- 'nerdfonts' | 'text'. Choose UI icon style (default: 'nerdfonts')
                        overrides = {}, -- Optional per-key overrides, see section below
                    },
                    questions = {
                        use_vim_ui_select = false, -- If true, render questions/prompts with vim.ui.select instead of showing them inline in the output buffer.
                    },
                    output = {
                        filetype = "opencode_output", -- Filetype assigned to the output buffer (default: 'opencode_output')
                        tools = {
                            show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
                            show_reasoning_output = true, -- Show reasoning/thinking steps output (default: true)
                        },
                        rendering = {
                            markdown_debounce_ms = 250, -- Debounce time for markdown rendering on new data (default: 250ms)
                            on_data_rendered = nil, -- Called when new data is rendered; set to false to disable default RenderMarkdown/Markview behavior
                        },
                    },
                    input = {
                        min_height = 0.10, -- min height of prompt input as percentage of window height
                        max_height = 0.25, -- max height of prompt input as percentage of window height
                        text = {
                            wrap = false, -- Wraps text inside input window
                        },
                        -- Auto-hide input window when prompt is submitted or focus switches to output window
                        auto_hide = false,
                    },
                    picker = {
                        snacks_layout = nil, -- `layout` opts to pass to Snacks.picker.pick({ layout = ... })
                    },
                    completion = {
                        file_sources = {
                            enabled = true,
                            preferred_cli_tool = "server", -- 'fd','fdfind','rg','git','server' if nil, it will use the best available tool, 'server' uses opencode cli to get file list (works cross platform) and supports folders
                            ignore_patterns = {
                                "^%.git/",
                                "^%.svn/",
                                "^%.hg/",
                                "node_modules/",
                                "%.pyc$",
                                "%.o$",
                                "%.obj$",
                                "%.exe$",
                                "%.dll$",
                                "%.so$",
                                "%.dylib$",
                                "%.class$",
                                "%.jar$",
                                "%.war$",
                                "%.ear$",
                                "target/",
                                "build/",
                                "dist/",
                                "out/",
                                "deps/",
                                "%.tmp$",
                                "%.temp$",
                                "%.log$",
                                "%.cache$",
                            },
                            max_files = 10,
                            max_display_length = 50, -- Maximum length for file path display in completion, truncates from left with "..."
                        },
                    },
                },
                context = {
                    enabled = true, -- Enable automatic context capturing
                    cursor_data = {
                        enabled = false, -- Include cursor position and line content in the context
                        context_lines = 5, -- Number of lines before and after cursor to include in context
                    },
                    diagnostics = {
                        info = false, -- Include diagnostics info in the context (default to false
                        warning = true, -- Include diagnostics warnings in the context
                        error = true, -- Include diagnostics errors in the context
                        only_closest = false, -- If true, only diagnostics for cursor/selection
                    },
                    current_file = {
                        enabled = true, -- Include current file path and content in the context
                        show_full_path = true,
                    },
                    files = {
                        enabled = true,
                        show_full_path = true,
                    },
                    selection = {
                        enabled = true, -- Include selected text in the context
                    },
                    buffer = {
                        enabled = false, -- Disable entire buffer context by default, only used in quick chat
                    },
                    git_diff = {
                        enabled = false,
                    },
                },
                logging = {
                    enabled = false,
                    level = "warn", -- debug, info, warn, error
                    outfile = nil,
                },
                debug = {
                    enabled = false, -- Enable debug messages in the output window
                    capture_streamed_events = false,
                    show_ids = true,
                    quick_chat = {
                        keep_session = false, -- Keep quick_chat sessions for inspection, this can pollute your sessions list
                        set_active_session = false,
                    },
                },
                prompt_guard = nil, -- Optional function that returns boolean to control when prompts can be sent (see Prompt Guard section)

                -- User Hooks for custom behavior at certain events
                hooks = {
                    on_file_edited = nil, -- Called after a file is edited by opencode.
                    on_session_loaded = nil, -- Called after a session is loaded.
                    on_done_thinking = nil, -- Called when opencode finishes thinking (all jobs complete).
                    on_permission_requested = nil, -- Called when a permission request is issued.
                },
                quick_chat = {
                    default_model = nil, -- works better with a fast model like gpt-4.1
                    default_agent = nil, -- Uses the current mode when nil
                    instructions = nil, -- Use built-in instructions if nil
                },
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    anti_conceal = { enabled = false },
                    file_types = { "markdown", "opencode_output" },
                },
                ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
            },
            -- Optional, for file mentions and commands completion, pick only one
            "saghen/blink.cmp",
            -- 'hrsh7th/nvim-cmp',

            -- Optional, for file mentions picker, pick only one
            "folke/snacks.nvim",
            -- 'nvim-telescope/telescope.nvim',
            -- 'ibhagwan/fzf-lua',
            -- 'nvim_mini/mini.nvim',
        },
    },
    {
        "nickjvandyke/opencode.nvim",
        enabled = false,
        version = "*", -- Latest stable release
        dependencies = {
            {
                -- `snacks.nvim` integration is recommended, but optional
                ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
                "folke/snacks.nvim",
                optional = true,
                opts = {
                    input = {}, -- Enhances `ask()`
                    picker = { -- Enhances `select()`
                        actions = {
                            opencode_send = function(...)
                                return require("opencode").snacks_picker_send(...)
                            end,
                        },
                        win = {
                            input = {
                                keys = {
                                    ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                                },
                            },
                        },
                    },
                },
            },
        },
        config = function()
            -- @type opencode.Opts
            vim.g.opencode_opts = {
                -- Your configuration, if any; goto definition on the type or field for details
            }

            vim.o.autoread = true -- Required for `opts.events.reload`

            -- Recommended/example keymaps
            vim.keymap.set({ "n", "x" }, "<C-a>", function()
                require("opencode").ask("@this: ", { submit = true })
            end, { desc = "Ask opencode…" })
            vim.keymap.set({ "n", "x" }, "<C-x>", function()
                require("opencode").select()
            end, { desc = "Execute opencode action…" })
            vim.keymap.set({ "n", "t" }, "<C-.>", function()
                require("opencode").toggle()
            end, { desc = "Toggle opencode" })

            vim.keymap.set({ "n", "x" }, "go", function()
                return require("opencode").operator("@this ")
            end, { desc = "Add range to opencode", expr = true })
            vim.keymap.set("n", "goo", function()
                return require("opencode").operator("@this ") .. "_"
            end, { desc = "Add line to opencode", expr = true })

            vim.keymap.set("n", "<S-C-u>", function()
                require("opencode").command("session.half.page.up")
            end, { desc = "Scroll opencode up" })
            vim.keymap.set("n", "<S-C-d>", function()
                require("opencode").command("session.half.page.down")
            end, { desc = "Scroll opencode down" })

            -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
            vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
            vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
        end,
    },
})

--options
require("sushrit_lawliet.options")
--remaps
require("sushrit_lawliet.remaps")

-- put this after lazy setup
-- dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline")
-- dofile(vim.g.base46_cache .. "dap")
-- dofile(vim.g.base46_cache .. "hop")
--
-- -- To load all integrations at once
--  for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
--    dofile(vim.g.base46_cache .. v)
--  end
