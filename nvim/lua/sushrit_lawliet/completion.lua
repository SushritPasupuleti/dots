require("blink.cmp").setup({
    keymap = {
        preset = "enter",
        ["<Tab>"] = {
            "snippet_forward",
            function() -- sidekick next edit suggestion
                return require("sidekick").nes_jump_or_apply()
            end,
            "fallback",
        },
    },

    completion = {
        menu = { border = "solid" },
        documentation = {
            auto_show = true,
            window = { border = "solid" },
        },
    },

    snippets = { preset = "default" }, -- native vim.snippet + friendly-snippets

    sources = {
        default = { "lsp", "path", "snippets", "buffer", "crates" },
        providers = {
            crates = {
                name = "crates",
                module = "blink.compat.source",
            },
        },
    },

    cmdline = {
        sources = { "buffer", "cmdline", "path" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
})
