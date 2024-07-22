require("lint").linters_by_ft = {
	-- markdown = {'vale',}
	markdown = { "eslint" },
	lua = { "luacheck" },
	javascript = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
	javascriptreact = { "eslint" },
	nix = { "nix" },
}
