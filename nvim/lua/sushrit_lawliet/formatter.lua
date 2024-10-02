-- local util = require "formatter.util"
--
-- require("formatter").setup({
-- 	logging = false,
-- 	filetype = {
-- 		lua = {
-- 			require("formatter.filetypes.lua").stylua,
-- 		},
-- 		nix = {
-- 			require("formatter.filetypes.nix").nixfmt,
-- 		},
-- 		javascript = {
-- 			require("formatter.filetypes.javascript").prettier
-- 		},
-- 		typescript = {
-- 			require("formatter.filetypes.typescript").prettier
-- 		},
-- 		typescriptreact = {
-- 			require("formatter.filetypes.typescript").prettier
-- 		},
-- 		javascriptreact = {
-- 			require("formatter.filetypes.typescript").prettier
-- 		},
-- 	},
-- })

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "ruff", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "biome", "prettier", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        nix = { "nixfmt" },
        go = { "gofmt" },
        yaml = { "yq" },
        json = { "jq" },
        toml = { "tomllint" },
		buf = { "buf" },
		sh = { "shfmt" },
    },
})
