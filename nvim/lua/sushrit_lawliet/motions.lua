require("hop").setup()
-- place this in one of your configuration file(s)
vim.api.nvim_set_keymap(
	"",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
	{}
)

local keymap = vim.keymap.set

vim.api.nvim_set_keymap("", "<Leader>w", ":HopWordMW<CR>", {})
vim.api.nvim_set_keymap("", "<Leader>W", ":HopWord<CR>", {})
vim.api.nvim_set_keymap("", "<Leader>q", ":HopWordCurrentLine<CR>", {})
vim.api.nvim_set_keymap("", "<Leader>j", ":HopLineMW<CR>", {})
vim.api.nvim_set_keymap("", "<Leader>J", ":HopLine<CR>", {})
vim.api.nvim_set_keymap("", "<Leader>t", ":HopPattern<CR>", {})
