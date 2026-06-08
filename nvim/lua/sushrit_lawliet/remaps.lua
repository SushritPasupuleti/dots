-- remaps.lua
-- Keymaps organized with which-key integration

local wk = require("which-key")

-- Register groups not already defined in init.lua's wk.add() call
wk.add({
    { "<leader>d", group = "debug" },
    { "<leader>h", group = "history" },
    { "<leader>r", group = "rename" },
    { "<leader>n", group = "notifications" },
})

-- ============================================================================
-- NAVIGATION
-- ============================================================================

-- Centered scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- Line start/end
vim.keymap.set({ "n", "v" }, "gh", "<Home>", { desc = "Go to line start" })
vim.keymap.set({ "n", "v" }, "gl", "<End>",  { desc = "Go to line end" })

-- Move lines/blocks (overrides J join-line and K man-lookup)
local silent = { noremap = true, silent = true }
vim.keymap.set("n", "J", ":MoveLine(1)<CR>",   silent)
vim.keymap.set("n", "K", ":MoveLine(-1)<CR>",  silent)
vim.keymap.set("v", "J", ":MoveBlock(1)<CR>",  silent)
vim.keymap.set("v", "K", ":MoveBlock(-1)<CR>", silent)

-- ============================================================================
-- CLIPBOARD
-- ============================================================================

vim.keymap.set("x",          "<leader>p", [["_dP]],  { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]],   { desc = "Yank to system clipboard" })
vim.keymap.set("n",          "<leader>Y", [["+Y]],   { desc = "Yank line to system clipboard" })

-- ============================================================================
-- SEARCH  (hlslens enhanced)
-- ============================================================================

local hlsopts = { noremap = true, silent = true }

vim.keymap.set("n", "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    vim.tbl_extend("force", hlsopts, { desc = "Next result" }))
vim.keymap.set("n", "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    vim.tbl_extend("force", hlsopts, { desc = "Prev result" }))
vim.keymap.set("n", "*",
    [[*<Cmd>lua require('hlslens').start()<CR>]],
    vim.tbl_extend("force", hlsopts, { desc = "Search word forward" }))
vim.keymap.set("n", "#",
    [[#<Cmd>lua require('hlslens').start()<CR>]],
    vim.tbl_extend("force", hlsopts, { desc = "Search word backward" }))
vim.keymap.set("n", "g*",
    [[g*<Cmd>lua require('hlslens').start()<CR>]],
    vim.tbl_extend("force", hlsopts, { desc = "Search (no boundary) fwd" }))
vim.keymap.set("n", "g#",
    [[g#<Cmd>lua require('hlslens').start()<CR>]],
    vim.tbl_extend("force", hlsopts, { desc = "Search (no boundary) bwd" }))

vim.keymap.set("n", "<leader>l", "<Cmd>noh<CR>", vim.tbl_extend("force", hlsopts, { desc = "Clear search highlight" }))
vim.keymap.set("v", "<leader>/", "<esc>/\\%V",   { desc = "Search in selection" })

-- ============================================================================
-- FILE / FIND  (<leader>f)
-- ============================================================================

local search = require("search")

vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",                                                   { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                                 { desc = "Fuzzy find in buffer" })
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics,                                        { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>fD", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,         { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>fe", "<cmd>Dirbuf<CR>",                                                              { desc = "File explorer" })
vim.keymap.set("n", "<leader>ff", search.open,                                                                     { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",                                                 { desc = "Live grep" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>",      { desc = "Find hidden files" })
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope import<cr>",                                                    { desc = "Find imports" })
vim.keymap.set("n", "<leader>fk", "<cmd>command_center<cr>",                                                      { desc = "Command center" })
vim.keymap.set("n", "<leader>fs", "<cmd>Autosession search<cr>",                                                  { desc = "Search sessions" })
vim.keymap.set("n", "<leader>fT", "<cmd>FloatermToggle<CR>",                                                      { noremap = true, silent = true, desc = "Toggle floaterm" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>",                                                       { desc = "TODOs" })
vim.keymap.set("n", "<leader>fu", "<cmd>UrlView<cr>",                                                             { desc = "View URLs" })
vim.keymap.set("n", "<leader>fv", "<cmd>Telescope neoclip<cr>",                                                   { desc = "Clipboard history" })
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope ast_grep<cr>",                                                  { desc = "AST grep" })
vim.keymap.set("n", "<leader>fy", "<cmd>Telescope yaml_schema<cr>",                                               { desc = "YAML schema" })

vim.keymap.set("n", "<M-f>f", "<cmd>FzfLua files<cr>", { desc = "fzf: find files" })

-- ============================================================================
-- SEARCH / REPLACE  Spectre  (<leader>s)
-- ============================================================================

-- NOTE: <leader>s is the "search" group — avoid binding <leader>s directly
vim.keymap.set("n",          "<leader>S",  function() require("spectre").open() end,                              { desc = "Spectre: open" })
vim.keymap.set("n",          "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, { desc = "Spectre: search word" })
vim.keymap.set({ "n", "v" }, "<leader>sv", function() require("spectre").open_visual() end,                      { desc = "Spectre: search visual" })

-- ============================================================================
-- GIT  (<leader>g)
-- ============================================================================

-- NOTE: fixed — original had "<silent> <leader>gg" with <silent> as part of LHS
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>",                  { silent = true, desc = "LazyGit" })
vim.keymap.set("n", "<leader>gf", ":LazyGitFilter<CR>",            { silent = true, desc = "LazyGit filter" })
vim.keymap.set("n", "<leader>gc", ":LazyGitFilterCurrentFile<CR>", { silent = true, desc = "LazyGit filter current file" })

-- ============================================================================
-- HISTORY  (<leader>h, <leader>z)
-- ============================================================================

vim.keymap.set("n", "<leader>hh", function() require("memento").toggle() end,        { desc = "Memento: toggle" })
vim.keymap.set("n", "<leader>hc", function() require("memento").clear_history() end, { desc = "Memento: clear history" })
vim.keymap.set("n", "<leader>z",  ":UndotreeToggle<CR>",                             { desc = "Toggle undotree" })

-- ============================================================================
-- LSP / CODE  (<leader>c, <leader>r, g-prefixed, bracket jumps)
-- ============================================================================

-- Lspsaga
-- NOTE: removed duplicate <leader>gd peek_definition — keeping goto_definition
vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga lsp_finder<CR>",      { silent = true, desc = "LSP finder" })
vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", { silent = true, desc = "Goto definition" })
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>",          { silent = true, desc = "Rename symbol" })
vim.keymap.set("n", "<leader>k",  "<cmd>Lspsaga hover_doc<CR>",       { silent = true, desc = "Hover doc" })
vim.keymap.set("n", "<leader>O",  "<cmd>Lspsaga outline<CR>",                         { desc = "Symbol outline" })
vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>",                  { desc = "Incoming calls" })
vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>",                  { desc = "Outgoing calls" })

-- Code actions
vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, { desc = "Code actions" })

-- Docstring generation (moved from <leader>dd to avoid debug-group confusion)
vim.keymap.set("n", "<leader>cD", function() require("neogen").generate() end, { noremap = true, silent = true, desc = "Generate docstring" })

-- Diagnostics (show)
vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>",   { silent = true, desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true, desc = "Cursor diagnostics" })
vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>",                   { desc = "Buffer diagnostics" })

-- Diagnostic jump
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, desc = "Prev diagnostic" })
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })
vim.keymap.set("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })

-- Glance
vim.keymap.set("n", "gD", "<CMD>Glance definitions<CR>",      { desc = "Glance definitions" })
vim.keymap.set("n", "gR", "<CMD>Glance references<CR>",       { desc = "Glance references" })
vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>", { desc = "Glance type definitions" })
vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>",  { desc = "Glance implementations" })

-- ============================================================================
-- CRATES (Rust)  (<leader>c)
-- ============================================================================

local function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end

local crates = require("crates")
local crate_opts = { silent = true }

vim.keymap.set("n", "<leader>ck", show_documentation,             vim.tbl_extend("force", crate_opts, { desc = "Show docs / crate info" }))
vim.keymap.set("n", "<leader>cv", crates.show_versions_popup,     vim.tbl_extend("force", crate_opts, { desc = "Crate versions" }))
vim.keymap.set("n", "<leader>cf", crates.show_features_popup,     vim.tbl_extend("force", crate_opts, { desc = "Crate features" }))
-- NOTE: removed conflicting DAP-UI toggle that was also on <leader>cd
vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, vim.tbl_extend("force", crate_opts, { desc = "Crate dependencies" }))
vim.keymap.set("n", "<leader>ct", crates.toggle,                  vim.tbl_extend("force", crate_opts, { desc = "Toggle crates" }))
vim.keymap.set("n", "<leader>cr", crates.reload,                  vim.tbl_extend("force", crate_opts, { desc = "Reload crates" }))

-- ============================================================================
-- UI TOGGLES
-- ============================================================================

vim.keymap.set("n", "<space>z", ":ZenMode<CR>",                                            { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<space>n", ":NoNeckPain<CR>",                                         { desc = "Toggle NoNeckPain" })
vim.keymap.set("n", "<space>F", "<cmd>Format<CR>",                                         { noremap = true, silent = true, desc = "Format file" })
vim.keymap.set("n", "<space>l", "<cmd>lua require('lint').try_lint()<CR>",                 { noremap = true, silent = true, desc = "Lint file" })
vim.keymap.set("n", "<leader>p", ":Glow<CR>",                                              { desc = "Markdown preview" })
vim.keymap.set("n", "<Leader>e", "<cmd>IconPickerInsert emoji<cr>",                        { noremap = true, silent = true, desc = "Insert emoji" })

-- ============================================================================
-- NOTIFICATIONS  (<leader>n)
-- ============================================================================

vim.keymap.set("n", "<leader>nn", require("notify").dismiss, { noremap = true, silent = true, desc = "Dismiss notifications" })
vim.keymap.set("n", ";",          require("notify").dismiss, { noremap = true, silent = true, desc = "Dismiss notifications" })

-- ============================================================================
-- SESSION
-- ============================================================================

vim.keymap.set("n", "<C-s>", "<cmd>SessionSave<CR>", { silent = true, desc = "Save session" })

-- ============================================================================
-- TERMINAL  (Lspsaga floaterm)
-- ============================================================================

-- NOTE: removed duplicate <A-d> open_floaterm — keeping lazygit version
vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>",       { silent = true, desc = "Open lazygit floaterm" })
vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true, desc = "Close floaterm" })

-- ============================================================================
-- DEBUG / DAP  (<leader>d)
-- ============================================================================

local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, ui = pcall(require, "dapui")

if not (dap_ok and dap_ui_ok) then
    require("notify")("nvim-dap or dap-ui not installed!", "warning")
else
    vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

    vim.keymap.set("n", "<leader>ds", function()
        dap.continue()
        ui.toggle({})
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
    end, { desc = "Start debug session" })

    vim.keymap.set("n", "<leader>dc", dap.continue,                    { desc = "Continue" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,           { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dn", dap.step_over,                   { desc = "Step over" })
    vim.keymap.set("n", "<leader>di", dap.step_into,                   { desc = "Step into" })
    vim.keymap.set("n", "<leader>do", dap.step_out,                    { desc = "Step out" })
    vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover, { desc = "Inspect variable" })
    vim.keymap.set("n", "<leader>dC", function()
        dap.clear_breakpoints()
        require("notify")("Breakpoints cleared", "warn")
    end, { desc = "Clear breakpoints" })
    -- NOTE: removed conflicting Dirbuf <leader>de — Dirbuf moved to <leader>fe
    vim.keymap.set("n", "<leader>de", function()
        dap.clear_breakpoints()
        ui.toggle({})
        dap.terminate()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
        require("notify")("Debugger session ended", "warn")
    end, { desc = "End debug session" })
end

-- ============================================================================
-- OPENCODE  (<leader>o)
-- ============================================================================

vim.keymap.set({ "n", "t" }, "<leader>og", function() require("opencode").toggle() end,                          { desc = "Toggle" })
vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end,                    { desc = "Ask" })
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,                          { desc = "Select action" })
vim.keymap.set({ "n", "x" }, "<leader>oo", function() return require("opencode").operator("@this ") end,         { desc = "Add range", expr = true })
vim.keymap.set("n",          "<leader>ol", function() return require("opencode").operator("@this ") .. "_" end,  { desc = "Add line", expr = true })
vim.keymap.set("n",          "<leader>on", function() require("opencode").command("session.new") end,            { desc = "New session" })
vim.keymap.set("n",          "<leader>oS", function() require("opencode").command("session.select") end,         { desc = "Select session" })
vim.keymap.set("n",          "<leader>oi", function() require("opencode").command("session.interrupt") end,      { desc = "Interrupt" })
vim.keymap.set("n",          "<leader>oc", function() require("opencode").command("session.compact") end,        { desc = "Compact session" })
vim.keymap.set("n",          "<leader>ou", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll up" })
vim.keymap.set("n",          "<leader>od", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll down" })
vim.keymap.set("n",          "<leader>oz", function() require("opencode").command("session.undo") end,           { desc = "Undo action" })
vim.keymap.set("n",          "<leader>or", function() require("opencode").command("session.redo") end,           { desc = "Redo action" })
vim.keymap.set("n",          "<leader>oA", function() require("opencode").command("agent.cycle") end,            { desc = "Cycle agent" })

