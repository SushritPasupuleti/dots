require("nvim-treesitter.configs").setup({
	ensure_installed = {
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
		"help",
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
		"yaml",
		"elixir",
		"heex",
		"eex",
		"ocaml",
	},
	ignore_install = {
"help"
	},
	highlight = {
		-- enable = true,
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})
