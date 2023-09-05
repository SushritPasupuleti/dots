require("null-ls").setup({
	sources = {
		--Formatters Start--
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown", "go", "python" },
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
vim.cmd("map <space>f :lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>")

-- For < v8
-- vim.cmd("map <Leader>lf :lua vim.lsp.buf.formatting()<CR>")
