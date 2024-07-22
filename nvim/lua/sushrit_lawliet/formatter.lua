local util = require "formatter.util"

require("formatter").setup({
	logging = false,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		nix = {
			require("formatter.filetypes.nix").nixfmt,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier
		},
		typescriptreact = {
			require("formatter.filetypes.typescript").prettier
		},
		javascriptreact = {
			require("formatter.filetypes.typescript").prettier
		},
	},
})
