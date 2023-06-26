-- Center the cursor on the screen when moving up or down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- same but with search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over highlight without losing clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- search in selection in visual mode
vim.keymap.set("v", "<leader>/", "<esc>/\\%V")

-- line navigations
vim.keymap.set({ "n", "v" }, "gh", "<Home>")
vim.keymap.set({ "n", "v" }, "gl", "<End>")

-- replace current word
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Telescope

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics)
vim.keymap.set("n", "<leader>fD", ":lua require'telescope.builtin'.diagnostics{ bufnr = 0 }<cr>")
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope command_history<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>")
vim.keymap.set("n", "<leader>fu", "<cmd>UrlView<cr>")
vim.keymap.set("n", "<leader>fk", "<cmd>command_center<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Autosession search<cr>")
vim.keymap.set("n", "<leader>fv", "<cmd>Telescope neoclip<cr>")
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>")

-- Spectre for Find and Replace
vim.keymap.set("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>")
vim.keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
vim.keymap.set({ "n", "v" }, "<leader>s", "<esc>:lua require('spectre').open_visual()<CR>")
-- GLow Preview
vim.keymap.set("n", "<leader>p", ":Glow<CR>")

-- undotree
vim.keymap.set("n", "<leader>z", ":UndotreeToggle<CR>")

-- Zen Mode
vim.keymap.set("n", "<space>z", ":ZenMode<CR>")
vim.keymap.set("n", "<space>n", ":NoNeckPain<CR>")

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

vim.keymap.set("n", "J", ":MoveLine(1)<CR>", opts)
vim.keymap.set("n", "K", ":MoveLine(-1)<CR>", opts)
-- vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
-- vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)

-- Visual-mode commands
vim.keymap.set("v", "J", ":MoveBlock(1)<CR>", opts)
vim.keymap.set("v", "K", ":MoveBlock(-1)<CR>", opts)
-- vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
-- vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

-- DAP-UI --
vim.keymap.set("n", "<leader>cd", ":lua require'dapui'.toggle()<CR>")

vim.keymap.set("n", "<leader>de", ":Dirbuf<CR>")

--hlslens
local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

vim.keymap.set("n", "<Leader>e", "<cmd>IconPickerInsert emoji<cr>", opts)

---lspsaga---
local keymap = vim.keymap.set

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

-- Session Management
keymap("n", "<C-s>", "<cmd>SessionSave<CR>", { silent = true })

local function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim','help' }, filetype) then
        vim.cmd('h '..vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({ 'man' }, filetype) then
        vim.cmd('Man '..vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
        require('crates').show_popup()
    else
        vim.lsp.buf.hover()
    end
end

local crates = require('crates')
local opts = { silent = true }

vim.keymap.set('n', '<leader>ck', show_documentation, { silent = true })
vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts)
vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts)
vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts)
vim.keymap.set('n', '<leader>ct', crates.toggle, opts)
vim.keymap.set('n', '<leader>cr', crates.reload, opts)

vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')
