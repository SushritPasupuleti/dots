-- nvim-treesitter main branch: no configs module, no nvim-treesitter.install module.
-- Parser installation is via the install API; highlighting via Neovim's vim.treesitter.

local parsers = {
	"bash",
	"c",
	"c_sharp",
	"cpp",
	"css",
	"dart",
	"dot",
	"fish",
	"go",
	"gitignore",
	"gitcommit",
	"html",
	"http",
	"java",
	"kotlin",
	"javascript",
	"json",
	"jsonc",
	"latex",
	"lua",
	"markdown",
	"markdown_inline",
	"php",
	"python",
	"rust",
	"sql",
	"toml",
	"typescript",
	"tsx",
	"vim",
	"vimdoc",
	"yaml",
	"elixir",
	"heex",
	"eex",
	"ocaml",
	"nix",
}

require("nvim-treesitter").install(parsers)

-- Enable treesitter highlighting for every buffer (new main branch no longer does this automatically)
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
