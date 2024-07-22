vim.opt.cmdheight = 0
vim.opt.number = true
-- I don't like relativenumber personally.
-- vim.opt.relativenumber
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.mouse = "a"
-- vim.opt.mouse ="c"
vim.opt.cursorline = true
-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")
-- vim.opt.cursorcolumn
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

vim.g.do_filetype_lua = 1
vim.opt.filetype = "on"

-- vim.api.nvim_set_hl(0, "Normal", { ctermbg = none, guibg = none })

--== LazyGit

vim.g.lazygit_floating_window_winblend = 5 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
-- vim.g.lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] -- customize lazygit popup window corner characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

-- Time tracking (needs system-side setup (https://github.com/git-time-metric/gtm))
vim.g.gtm_plugin_status_enabled = 1

-- Easy Motion
vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings

if vim.g.neovide then
	vim.notify("Loading Neovide Settings!", "info")
	
	-- vim.g.neovide_transparency=0.8
	-- vim.g.transparency=0.8
	-- vim.g.neovide_background_color="#1e1e2e"
	vim.g.neovide_floating_blur_amount_x = 4.0
	vim.g.neovide_floating_blur_amount_y = 4.0
	-- vim.g.neovide_input_use_logo = true	
end

-- Folds
-- UFO requires a large value for these settings
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
