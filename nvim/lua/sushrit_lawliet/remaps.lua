-- Center the cursor on the screen when moving up or down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- same but with search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over highlight without losing clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- search in selection in visual mode
vim.keymap.set('v', '<leader>/', '<esc>/\\%V')

-- line navigations
vim.keymap.set({"n", "v"}, "gh", "<Home>")
vim.keymap.set({"n", "v"}, "gl", "<End>")

-- replace current word
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Telescope

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope command_history<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>")
vim.keymap.set("n", "<leader>fu", "<cmd>UrlView<cr>")
vim.keymap.set("n", "<leader>fk", "<cmd>command_center<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>SearchSession<cr>")
vim.keymap.set("n", "<leader>fv", "<cmd>Telescope neoclip<cr>")

-- Spectre for Find and Replace
vim.keymap.set("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>")
vim.keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
vim.keymap.set({"n","v"}, "<leader>s", "<esc>:lua require('spectre').open_visual()<CR>")
-- GLow Preview
vim.keymap.set("n", "<leader>p", ":Glow<CR>")

-- undotree
vim.keymap.set("n", "<leader>z", ":UndotreeToggle<CR>")

-- Zen Mode
vim.keymap.set("n", "<space>z", ":ZenMode<CR>")

-- setup mapping to call :LazyGit
vim.keymap.set("n", "<silent> <leader>gg", ":LazyGit<CR>")
vim.keymap.set("n", "<silent> <leader>gf", ":LazyGitFilter<CR>")
vim.keymap.set("n", "<silent> <leader>gc", ":LazyGitFilterCurrentFile<CR>")

-- Setup memento
vim.keymap.set("n", "<leader>hh", "<cmd>lua require('memento').toggle()<CR>")
vim.keymap.set("n", "<leader>hc", "<cmd>lua require('memento').clear_history()<CR>")

-- Normal-mode commands
-- vim.keymap.set("n", "<silent> J", ":MoveLine(1)<CR>")
-- vim.keymap.set("n", "<silent> K", ":MoveLine(-1)<CR>")
-- -- nnoremap <silent>  :MoveHChar(1)<CR>
-- -- nnoremap <silent> <A-h> :MoveHChar(-1)<CR>
--
-- -- Visual-mode commands
-- vim.keymap.set({"n", "v"}, "<silent> J", ":MoveBlock(1)<CR>")
-- vim.keymap.set({"n", "v"}, "<silent> K", ":MoveBlock(-1)<CR>")
-- -- vnoremap <silent> <A-l> :MoveHBlock(1)<CR>
-- -- vnoremap <silent> <A-h> :MoveHBlock(-1)<CR>

-- vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
-- vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
-- vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
-- vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'J', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', 'K', ':MoveLine(-1)<CR>', opts)
-- vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
-- vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)

-- Visual-mode commands
vim.keymap.set('v', 'J', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', 'K', ':MoveBlock(-1)<CR>', opts)
-- vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
-- vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
