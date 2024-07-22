require("null-ls").setup({
    sources = {
        --Formatters Start--
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.formatting.prettier.with({
            filetypes = { "html", "json", "yaml", "markdown", "go", "python", "toml", "sql", "python" },
        }),
        --Formatters End--
        --Diagnotics Start--
        -- require("null-ls").builtins.diagnostics.eslint,
        --Diagnostics End--
        ----Completion Start----
        -- require("null-ls").builtins.completion.spell,
        ----Completion End----
        ----Code Actions Start----
        -- require("null-ls").builtins.code_actions.eslint,
        ----Code Actions End----
        -- Go Start
        require("null-ls").builtins.code_actions.gitsigns.with({
            config = {
                filter_actions = function(title)
                    return title:lower():match("blame") == nil -- filter out blame actions
                end,
            },
        }),
        require("null-ls").builtins.code_actions.gomodifytags,
        require("null-ls").builtins.code_actions.impl,
        require("null-ls").builtins.diagnostics.golangci_lint,
        -- Go End
        -- Python Start
        require("null-ls").builtins.formatting.black,
        --- Python End
        -- require("null-ls").builtins.code_actions.refactoring,
        require("null-ls").builtins.code_actions.shellcheck,
        require("null-ls").builtins.diagnostics.deadnix, -- Nix
        require("null-ls").builtins.code_actions.statix, -- Nix
        require("null-ls").builtins.diagnostics.actionlint,
        require("null-ls").builtins.diagnostics.bandit, -- Python
        require("null-ls").builtins.diagnostics.buf, -- Protobufs
        require("null-ls").builtins.diagnostics.checkmake, -- Make
        -- require("null-ls").builtins.diagnostics.chktex, -- LaTeX
        -- require("null-ls").builtins.diagnostics.curlylint, -- HTML Templating
        require("null-ls").builtins.diagnostics.dotenv_linter, -- .env
        require("null-ls").builtins.diagnostics.hadolint, -- Docker
        require("null-ls").builtins.diagnostics.luacheck, -- Lua
        require("null-ls").builtins.diagnostics.markdownlint, -- Markdown
        -- require("null-ls").builtins.diagnostics.protoc_gen_lint, -- Protobufs
        require("null-ls").builtins.diagnostics.shellcheck, -- Shell
        -- require("null-ls").builtins.diagnostics.sqlfluff.with({
        -- 	extra_args = { "--dialect", "postgres" },      -- change to your dialect
        -- }),
    },
})

-- For v8
vim.cmd("map <space>f :lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>")

-- For < v8
-- vim.cmd("map <Leader>lf :lua vim.lsp.buf.formatting()<CR>")
