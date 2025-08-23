vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = {     -- :h background
		light = "latte",
		dark = "mocha",
		-- dark = "latte",
	},
	show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
	transparent_background = true,
	term_colors = true,
	-- term_colors = false,
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
	integrations = {
		flash = true,
		fidget = true,
		cmp = {
			enabled = true,
			border = {
				completion = true,
				documentation = true,
			},
		},
		alpha = true,
		hop = true,
		gitsigns = true,
		nvimtree = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		treesitter = true,
		treesitter_context = true,
		lsp_trouble = true,
		lsp_saga = true,
		mason = true,
		notify = true,
		noice = true,
		which_key = true,
		harpoon = true,
		octo = true,
		neogit = true,
		dap = {
			enabled = true,
			enable_ui = true,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		markdown = true,
		semantic_tokens = true,
		navic = {
			enabled = true,
		},
		barbecue = {
			dim_dirname = true, -- directory name is dimmed by default
			bold_basename = true,
			dim_context = false,
			alt_background = false,
		},
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
			inlay_hints = {
				background = true,
			},
		},
	},
	custom_highlights = function(colors)
		return {
			-- Comment = { fg = colors.flamingo },
			-- TabLineSel = { bg = colors.pink },
			CmpBorder = { fg = colors.surface2 },
			CmpDocBorder = { fg = colors.surface2 },
			PmenuSel = { bg = colors.green, fg = colors.crust },
			Pmenu = { fg = colors.overlay0, bg = colors.crust },
			CmpPmenu = { fg = colors.overlay0, bg = colors.crust },
			CmpDoc = { fg = colors.overlay0, bg = colors.mantle },

			CmpItemAbbrDeprecated = { fg = colors.subtext1, bg = "NONE", strikethrough = true },
			CmpItemAbbrMatch = { fg = colors.blue, bg = "NONE", bold = true },
			CmpItemAbbrMatchFuzzy = { fg = colors.blue, bg = "NONE", bold = true },
			CmpItemMenu = { fg = colors.mauve, bg = "NONE", italic = true },
			--
			CmpItemKindField = { fg = colors.crust, bg = colors.red },
			CmpItemKindProperty = { fg = colors.crust, bg = colors.red },
			CmpItemKindEvent = { fg = colors.crust, bg = colors.red },
			--
			CmpItemKindText = { fg = colors.crust, bg = colors.green },
			CmpItemKindEnum = { fg = colors.crust, bg = colors.green },
			CmpItemKindKeyword = { fg = colors.crust, bg = colors.green },
			--
			CmpItemKindConstant = { fg = colors.crust, bg = colors.yellow },
			CmpItemKindConstructor = { fg = colors.crust, bg = colors.yellow },
			CmpItemKindReference = { fg = colors.crust, bg = colors.yellow },
			--
			CmpItemKindFunction = { fg = colors.crust, bg = colors.mauve },
			CmpItemKindStruct = { fg = colors.crust, bg = colors.mauve },
			CmpItemKindClass = { fg = colors.crust, bg = colors.mauve },
			CmpItemKindModule = { fg = colors.crust, bg = colors.mauve },
			CmpItemKindOperator = { fg = colors.crust, bg = colors.mauve },
			--
			CmpItemKindVariable = { fg = colors.crust, bg = colors.surface1 },
			CmpItemKindFile = { fg = colors.crust, bg = colors.surface1 },
			--
			CmpItemKindUnit = { fg = colors.crust, bg = colors.flamingo },
			CmpItemKindSnippet = { fg = colors.crust, bg = colors.flamingo },
			CmpItemKindFolder = { fg = colors.crust, bg = colors.flamingo },
			--
			CmpItemKindMethod = { fg = colors.crust, bg = colors.sapphire },
			CmpItemKindValue = { fg = colors.crust, bg = colors.sapphire },
			CmpItemKindEnumMember = { fg = colors.crust, bg = colors.sapphire },
			--
			CmpItemKindInterface = { fg = colors.crust, bg = colors.teal },
			CmpItemKindColor = { fg = colors.crust, bg = colors.teal },
			CmpItemKindTypeParameter = { fg = colors.crust, bg = colors.teal },
			--
			-- HoverBorder = { fg = colors.surface2, bg = "NONE" },
			HoverNormal = { fg = colors.surface2, bg = colors.mantle },
			-- ActionPreviewBorder = { fg = colors.crust, bg = colors.mantle },
			-- DiagnosticBorder = { fg = colors.crust, bg = colors.mantle },
			-- HoverBorder = { fg = colors.crust, bg = colors.mantle },
			-- RenameBorder = { fg = colors.surface2, bg = "NONE" },
			RenameNormal = { fg = colors.surface2, bg = colors.mantle },
			SagaNormal = { bg = colors.mantle },
			-- SagaBorder = { fg = colors.surface2, bg = "NONE" },
			-- FloatBorder = { fg = colors.surface2, bg = "NONE" },
			SagaTitle = { fg = colors.mauve, bg = "NONE" },
			-- SagaSelect = { fg = C.pink, style = { "bold" } },
			-- CodeActionText = { fg = colors.pink },
			-- CodeActionNumber = { fg = colors.pink },
			-- SagaBorder = { fg = C.surface2, bg = C.mantle },
			-- CodeActionBorder = { fg = C.surface2, bg = C.mantle },
		}
	end,
})

-- vim.cmd([[colorscheme catppuccin mocha]])
vim.cmd.colorscheme "catppuccin"
