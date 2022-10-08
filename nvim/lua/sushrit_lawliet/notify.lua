require("notify").setup({
	background_colour = "#000000",
})

local notify = require("notify")

vim.notify = notify

vim.api.nvim_set_keymap("n", "<leader>n", "", { callback = notify.dismiss })
