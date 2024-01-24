local icons = require("sushrit_lawliet.lspkind")

require("fzf-lua").setup({
	"telescope",
	winopts = {
		preview = {
			default = "bat",
		},
	},
	-- git = {
	-- 	status = {
	-- 		preview_pager = 'delta -w $FZF_PREVIEW_COLUMS'
	-- 	},
	-- 	commits = {
	-- 		preview_pager = 'delta -w $FZF_PREVIEW_COLUMS'
	-- 	},
	-- 	bcommits = {
	-- 		preview_pager = 'delta -w $FZF_PREVIEW_COLUMS'
	-- 	},
	-- },
	fzf_colors = {
		bg = { "bg", "Normal" },
		gutter = { "bg", "Normal" },
		info = { "fg", "Conditional" },
		scrollbar = { "bg", "Normal" },
		separator = { "fg", "Comment" },
	},
	git_diff = {
		pager = "delta --width $FZF_PREVIEW_COLUMNS",
	},
	lsp = {
		code_actions = {
			previewer = "codeaction_native",
			preview_pager =
			"delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
		},
		symbols = {
			symbol_icons = icons.symbol_kinds,
		},
	},
})
