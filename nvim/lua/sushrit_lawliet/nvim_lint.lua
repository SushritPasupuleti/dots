require("lint").linters_by_ft = {
	markdown = { "markdownlint" },
	lua = { "luacheck" },
	javascript = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
	javascriptreact = { "eslint" },
	nix = { "deadnix", "statix" },
	go = { "golangcilint" },
	python = { "bandit" },
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	dockerfile = { "hadolint" },
	make = { "checkmake" },
	["yaml.github-actions"] = { "actionlint" },
	proto = { "buf_lint" },
	env = { "dotenv_linter" },
}

-- Auto-lint on common events
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
