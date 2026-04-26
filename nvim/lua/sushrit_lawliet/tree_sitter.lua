require("nvim-treesitter.install").prefer_git = false

-- In the new main branch, there is no configs module.
-- Parser installation is triggered via :TSInstall or the install API.
-- Highlighting is handled natively by Neovim's vim.treesitter.

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
	-- "latex",
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
