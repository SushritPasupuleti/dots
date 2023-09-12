local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
}

local assets = {
    left_separator = "",
    right_separator = "",
    mode_icon = " ",
    dir = "󰉖",
    file = "󰈙",
    lsp = {
        server = "󰅡",
        error = "",
        warning = "",
        info = "",
        hint = "",
    },
    git = {
        branch = " ",
        added = " ",
        changed = " ",
        removed = " ",
    },
}

local wpm = require("wpm")

require("lualine").setup({
    options = {
        icons_enabled = true,
        -- theme = "auto",
        theme = "catppuccin",
        -- component_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {
                "alpha",
            },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                icons_enabled = true,
                icon = {
                    assets.mode_icon,
                    align = "left",
                },
            },
        },
        lualine_b = {
            "branch",
            -- {
                -- require("pr_status").get_last_result_string() or "pr_status failed",
            -- },
            {
                "diff",

                symbols = { added = assets.git.added, modified = assets.git.changed, removed = assets.git.removed }, -- Changes the symbols used by the diff.
                source = nil,
            },
            "gtmstatus",
            {
                "diagnostics",
                sources = {
                    "nvim_diagnostic",
                    -- "nvim",
                },
            },
        },
        lualine_c = {
            -- "tabs",
            "filename",
            require("auto-session.lib").current_session_name,
        },
        lualine_x = { "filesize", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = { "filesize" },
        lualine_c = {
            {
                "filename",
                path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {
            {
                "diagnostics",
                sources = {
                    "nvim_diagnostic",
                },
            },
        },
    },
    tabline = {
        lualine_a = {
            -- "branch",
        },
        lualine_b = {
            "windows",
            -- "buffers",
            -- {
            -- 	"diff",
            -- 	-- colored = true,
            -- 	sym = { added = "+", modified = "~", removed = "-" },
            -- 	source = nil,
            -- },
            -- "buffers",
        },
        lualine_c = {},
        lualine_x = {
            wpm.wpm,
            wpm.historic_graph,
            {
                "diagnostics",
                sources = {
                    "nvim_diagnostic",
                    -- "nvim",
                },
            },
        },
        lualine_y = {
            "tabs",
        },
        lualine_z = {
            {
                "filename",
                path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
        },
    },
    winbar = {
        lualine_a = {
            {
                "filename",
                path = 1,
            },
        },
        lualine_b = {
            {
                "diagnostics",
                sources = {
                    "nvim_diagnostic",
                    -- "nvim",
                },
            },
            {
                "diff",

                symbols = { added = assets.git.added, modified = assets.git.changed, removed = assets.git.removed }, -- Changes the symbols used by the diff.
                source = nil,
            },
            "searchcount",
            -- require(lspsaga.symbol.winbar).get_bar(),
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_winbar = {
        lualine_a = {
            {
                "filename",
                path = 1,
            },
        },
        lualine_b = {
            {
                "diagnostics",
                sources = {
                    "nvim_diagnostic",
                    -- "nvim",
                },
            },
            {
                "diff",

                symbols = { added = assets.git.added, modified = assets.git.changed, removed = assets.git.removed }, -- Changes the symbols used by the diff.
                source = nil,
            },
            "searchcount",
            "selectioncount",
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        "toggleterm",
        "nvim-dap-ui",
        "lazy",
        "trouble",
        "quickfix",
        "man",
        "fzf",
    },
})

-- local clrs = require("catppuccin.palettes").get_palette()
-- local ctp_feline = require("catppuccin.groups.integrations.feline")
-- local U = require("catppuccin.utils.colors")
-- local mocha = require("catppuccin.palettes").get_palette "mocha"
--
-- ctp_feline.setup({
--     assets = {
--         -- left_separator = "",
--         -- right_separator = "",
--         right_separator = "",
--         left_separator = "",
--         mode_icon = "",
--         dir = "",
--         file = "",
--         lsp = {
--             -- server = "",
--             -- error = "",
--             -- warning = "",
--             -- info = "",
--             -- hint = "",
--         },
--         git = {
--             branch = "",
--             added = "",
--             changed = "",
--             removed = "",
--         },
--     },
--     sett = {
--         text = U.vary_color({ mocha = mocha.base }, clrs.surface0),
--         bkg = U.vary_color({ mocha = mocha.crust }, clrs.surface0),
--         diffs = clrs.mauve,
--         extras = clrs.overlay1,
--         curr_file = clrs.maroon,
--         curr_dir = clrs.flamingo,
--         show_modified = true, -- show if the file has been modified
--     },
--     mode_colors = {
--         ["n"] = { "NORMAL", clrs.lavender },
--         ["no"] = { "N-PENDING", clrs.lavender },
--         ["i"] = { "INSERT", clrs.green },
--         ["ic"] = { "INSERT", clrs.green },
--         ["t"] = { "TERMINAL", clrs.green },
--         ["v"] = { "VISUAL", clrs.flamingo },
--         ["V"] = { "V-LINE", clrs.flamingo },
--         ["�"] = { "V-BLOCK", clrs.flamingo },
--         ["R"] = { "REPLACE", clrs.maroon },
--         ["Rv"] = { "V-REPLACE", clrs.maroon },
--         ["s"] = { "SELECT", clrs.maroon },
--         ["S"] = { "S-LINE", clrs.maroon },
--         ["�"] = { "S-BLOCK", clrs.maroon },
--         ["c"] = { "COMMAND", clrs.peach },
--         ["cv"] = { "COMMAND", clrs.peach },
--         ["ce"] = { "COMMAND", clrs.peach },
--         ["r"] = { "PROMPT", clrs.teal },
--         ["rm"] = { "MORE", clrs.teal },
--         ["r?"] = { "CONFIRM", clrs.mauve },
--         ["!"] = { "SHELL", clrs.green },
--     },
-- })
--
-- local components = ctp_feline.get()
--
-- local feline = require("feline")
--
-- feline.setup({ components = components })
--
-- -- feline.winbar.setup({
-- --     components = ctp_feline.get_winbar(),
-- -- })
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "*",
--     callback = function()
--         package.loaded["feline"] = nil
--         package.loaded["catppuccin.groups.integrations.feline"] = nil
--         require("feline").setup {
--             components = require("catppuccin.groups.integrations.feline").get(),
--         }
--     end,
-- })
