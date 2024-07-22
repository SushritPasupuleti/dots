local enable_conceal = false

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- cmdline = {
	-- 	view = "cmdline",
	-- 	format = {
	-- 		cmdline = { conceal = enable_conceal },
	-- 		search_down = { conceal = enable_conceal },
	-- 		search_up = { conceal = enable_conceal },
	-- 		filter = { conceal = enable_conceal },
	-- 		lua = { conceal = enable_conceal },
	-- 		help = { conceal = enable_conceal },
	-- 		input = { conceal = enable_conceal },
	-- 	},
	-- },
	-- you can enable a preset for easier configuration
	-- presets = {
	-- 	bottom_search = true,        -- use a classic bottom cmdline for search
	-- 	command_palette = true,      -- position the cmdline and popupmenu together
	-- 	long_message_to_split = true, -- long messages will be sent to a split
	-- 	inc_rename = false,           -- enables an input dialog for inc-rename.nvim
	-- 	lsp_doc_border = false,       -- add a border to hover docs and signature help
	-- },
	-- views = {
	-- 	cmdline_popup = {
	-- 		border = {
	-- 			style = "none",
	-- 			padding = { 2, 3 },
	-- 		},
	-- 		filter_options = {},
	-- 		win_options = {
	-- 			-- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
	-- 			winhighlight = {
	-- 				NormalFloat = "TelescopePromptNormal",
	-- 				FloatBorder = "DiagnosticInfo",
	-- 			},
	-- 		},
	-- 	},
	-- 	-- cmdline_popup = {
	-- 	-- 	position = {
	-- 	-- 		row = 5,
	-- 	-- 		col = "50%",
	-- 	-- 	},
	-- 	-- 	size = {
	-- 	-- 		width = 60,
	-- 	-- 		height = "auto",
	-- 	-- 	},
	-- 	-- },
	-- 	popupmenu = {
	-- 		relative = "editor",
	-- 		position = {
	-- 			row = 20, --8
	-- 			col = "50%",
	-- 		},
	-- 		size = {
	-- 			width = 60,
	-- 			height = 10,
	-- 		},
	-- 		border = {
	-- 			style = "rounded",
	-- 			padding = { 0, 1 },
	-- 		},
	-- 		win_options = {
	-- 			winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
	-- 		},
	-- 	},
	-- },
})
