local clrs = require("catppuccin.palettes").get_palette()
local ctp_feline = require("catppuccin.groups.integrations.feline")
local U = require("catppuccin.utils.colors")
local mocha = require("catppuccin.palettes").get_palette("mocha")

ctp_feline.setup({
	assets = {
		-- left_separator = "",
		-- right_separator = "",
		right_separator = "",
		left_separator = "",
		mode_icon = "",
		dir = "",
		file = "",
		lsp = {
			-- server = "",
			-- error = "",
			-- warning = "",
			-- info = "",
			-- hint = "",
		},
		git = {
			branch = "",
			added = "",
			changed = "",
			removed = "",
		},
	},
	sett = {
		text = U.vary_color({ mocha = mocha.base }, clrs.surface0),
		bkg = U.vary_color({ mocha = mocha.crust }, clrs.surface0),
		diffs = clrs.mauve,
		extras = clrs.overlay1,
		curr_file = clrs.maroon,
		curr_dir = clrs.flamingo,
		show_modified = true, -- show if the file has been modified
	},
	mode_colors = {
		["n"] = { "NORMAL", clrs.lavender },
		["no"] = { "N-PENDING", clrs.lavender },
		["i"] = { "INSERT", clrs.green },
		["ic"] = { "INSERT", clrs.green },
		["t"] = { "TERMINAL", clrs.green },
		["v"] = { "VISUAL", clrs.flamingo },
		["V"] = { "V-LINE", clrs.flamingo },
		["�"] = { "V-BLOCK", clrs.flamingo },
		["R"] = { "REPLACE", clrs.maroon },
		["Rv"] = { "V-REPLACE", clrs.maroon },
		["s"] = { "SELECT", clrs.maroon },
		["S"] = { "S-LINE", clrs.maroon },
		["�"] = { "S-BLOCK", clrs.maroon },
		["c"] = { "COMMAND", clrs.peach },
		["cv"] = { "COMMAND", clrs.peach },
		["ce"] = { "COMMAND", clrs.peach },
		["r"] = { "PROMPT", clrs.teal },
		["rm"] = { "MORE", clrs.teal },
		["r?"] = { "CONFIRM", clrs.mauve },
		["!"] = { "SHELL", clrs.green },
	},
})

local components = ctp_feline.get()

local feline = require("feline")

feline.setup({ components = components })

-- feline.winbar.setup()
-- feline.winbar.setup({
--     components = ctp_feline.get_winbar(),
-- })

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		package.loaded["feline"] = nil
		package.loaded["catppuccin.groups.integrations.feline"] = nil
		require("feline").setup({
			components = require("catppuccin.groups.integrations.feline").get(),
		})
	end,
})
