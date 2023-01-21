local keymap = vim.keymap.set
-- local saga = require("lspsaga")

--this should be removed in the future
local M = {}

function M.custom_colors()
	local C = require("catppuccin.palettes").get_palette()
	return {
		--float window normal bakcground color
		normal_bg = C.base,
		--title background color
		title_bg = C.green,
		red = "#e95678",
		magenta = C.maroon,
		orange = C.peach,
		yellow = C.yellow,
		green = C.green,
		cyan = C.sky,
		blue = C.blue,
		purple = C.mauve,
		white = C.text,
		black = C.crust,
	}
end

function M.custom_kind()
	local C = require("catppuccin.palettes").get_palette()
	return {
		File = { " ", C.text },
		Module = { " ", C.blue },
		Namespace = { " ", C.peach },
		Package = { " ", C.mauve },
		Class = { " ", C.mauve },
		Method = { " ", C.mauve },
		Property = { " ", C.sky },
		Field = { " ", C.teal },
		Constructor = { " ", C.blue },
		Enum = { "了", C.green },
		Interface = { " ", C.peach },
		Function = { " ", C.mauve },
		Variable = { " ", C.blue },
		Constant = { " ", C.sky },
		String = { " ", C.green },
		Number = { " ", C.green },
		Boolean = { " ", C.peach },
		Array = { " ", C.blue },
		Object = { " ", C.peach },
		Key = { " ", C.red },
		Null = { " ", C.red },
		EnumMember = { " ", C.green },
		Struct = { " ", C.mauve },
		Event = { " ", C.mauve },
		Operator = { " ", C.green },
		TypeParameter = { " ", C.green },
		TypeAlias = { " ", C.green },
		Parameter = { " ", C.blue },
		StaticMethod = { "ﴂ ", C.peach },
		Macro = { " ", C.red },
	}
end

function M.get()
	return {
		DiagnosticError = { fg = C.red },
		DiagnosticWarning = { fg = C.yellow },
		DiagnosticInformation = { fg = C.blue },
		DiagnosticHint = { fg = C.rosewater },
		LspFloatWinNormal = { bg = C.crust },
		LspFloatWinBorder = { fg = C.blue },
		LspSagaBorderTitle = { fg = C.flamingo },
		LspSagaHoverBorder = { fg = C.blue },
		LspSagaRenameBorder = { fg = C.teal },
		LspSagaDefPreviewBorder = { fg = C.teal },
		LspSagaCodeActionBorder = { fg = C.blue },
		LspSagaFinderSelection = { fg = C.surface1 },
		LspSagaCodeActionTitle = { fg = C.blue },
		LspSagaCodeActionContent = { fg = C.lavender },
		LspSagaSignatureHelpBorder = { fg = C.red },
		ReferencesCount = { fg = C.lavender },
		DefinitionCount = { fg = C.lavender },
		DefinitionIcon = { fg = C.blue },
		ReferencesIcon = { fg = C.blue },
		TargetWord = { fg = C.flamingo },
	}
end

require('lspsaga').setup({
	ui = {
		theme = "round",
		colors = M.custom_colors(),
		kind = M.custom_kind(),
		--toggle these in the future when the bugs stop
		--colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
        --kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
	}
})
--
-- saga.init_lsp_saga()

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "<leader>gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code Actions --
-- local action = require("lspsaga.codeaction")

-- code action
-- vim.keymap.set("n", "<leader>ca", action.code_action, { silent = true })
-- vim.keymap.set("v", "<leader>ca", function()
-- 	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
-- 	action.range_code_action()
-- end, { silent = true })

keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Show buffer diagnostic
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
-- Diagnostic jump with filter like Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end)


-- Outline
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
keymap("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Callhierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
