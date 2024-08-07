-- Copilot on Apple Silicon Depends on Node 17.x or lower, so install node 16 LTS and point to it here for Copilot use exclusively.
-- vim.g.copilot_node_command = "/Users/sushrit_lawliet/.nvm/versions/node/v16.17.1/bin/node"

local filetypes = {
	markdown = true, -- overrides default
	terraform = false, -- disallow specific filetype
	typescript = true,
	javascript = true,
	typescriptreact = true,
	javascriptreact = true,
	kotlin = true,
	java = true,
	rust = true,
	go = true,
	python = true,
	lua = true,
	vim = true,
	css = true,
	html = true,
	json = true,
	yaml = true,
	cs = true,
	xml = true,
	mdx = true,
}

vim.g.copilot_filetypes = filetypes

require("copilot").setup({
    filetypes = filetypes,
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept = "<S-Tab>",
            accept_word = false,
            accept_line = "<A-S-Tab>",
            accept_snippet = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
	copilot_node_command = 'node',
})
