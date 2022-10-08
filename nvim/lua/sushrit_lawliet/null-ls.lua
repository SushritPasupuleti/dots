require("null-ls").setup({
	sources = {
		--Formatters Start--
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown" },
		}),
		--Formatters End--
		--Diagnotics Start--
		-- require("null-ls").builtins.diagnostics.eslint,
		--Diagnostics End--
		----Completion Start----
		-- require("null-ls").builtins.completion.spell,
		----Completion End----
		----Code Actions Start----
		-- require("null-ls").builtins.code_actions.eslint,
		----Code Actions End----
	},
})

-- For v8
vim.cmd('map <Leader>lf :lua vim.lsp.buf.format()<CR>')

-- For < v8
-- vim.cmd("map <Leader>lf :lua vim.lsp.buf.formatting()<CR>")
