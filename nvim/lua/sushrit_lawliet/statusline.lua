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

local wpm = require("wpm")

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
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
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "diff",
                -- colored = true,
                -- diff_color = {
                -- 	-- Same color values as the general color option can be used here.
                -- 	added = "DiffAdd", -- Changes the diff's added color
                -- 	modified = "DiffChange", -- Changes the diff's modified color
                -- 	removed = "DiffDelete", -- Changes the diff's removed color you
                -- },
                symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
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
				path=1,
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
            "diff",
            "searchcount",
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
				path=1,
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
            "diff",
            "searchcount",
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        "toggleterm",
        "nvim-dap-ui",
    },
})
