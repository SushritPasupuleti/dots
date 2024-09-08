--- Mason ---

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
    -- "bashls",
    "cssls",
    "dockerls",
    -- "eslint",
    "gopls",
    "jsonls",
    "tsserver",
    "pyright",
    "vimls",
    "yamlls",
    -- "lemminx",
    "tailwindcss",
    -- "taplo",
    "sqlls",
    "html",
    "dotls",
    "cssls",
    "ansiblels",
    "arduino_language_server",
    "kotlin_language_server",
    -- "lua-language-server",
    -- "elixirls",
    "omnisharp",
    -- "csharp-language-server",
    -- "rust_analyzer",
    -- "sumneko_lua", --deprecated
    "lua_ls",
    -- "nginx-language-server",
    -- "nextls", -- for elixir
    "nil_ls", -- for nix
    -- "rnix",
	-- "nil",
	"nixpkgs-fmt",
    "tailwindcss",
    "terraformls",
    -- "tflint",
    "graphql",
    -- "denols",
    "awk_ls",
    -- "buf",
    "ocamllsp",
    "htmx",
}

local other_servers = {
    -- "eslint",
    -- "js-debug-adapter",
    -- "prettier",
}

local mason_ensure_installed = servers

-- table.insert(mason_ensure_installed, table.concat(other_servers, ", "))

require("mason").setup({
    PATH = "append",
})
require("mason-lspconfig").setup({
    -- ensure_installed = mason_ensure_installed,
    -- automatic_installation = true,
})

--- LSP Config ---
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local navic = require("nvim-navic")
local signature_setup = {
    bind = true,
    handler_opts = {
        border = "single",
    },
    -- hint_inline = function()
    -- 	return 'right_align'
    -- end,
}

local nvim_lsp = require("lspconfig")
-- local servers = { 'tsserver', 'pyright', 'gopls' }

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gk", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
    navic.attach(client, bufnr)
    require("lsp_signature").on_attach(signature_setup, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Enable additional completion for HTML/JSON/CSS
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Add additional capabilities supported by UFO
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local yaml_cfg = require("yaml-companion").setup({
    -- Add any options here, or leave empty to use the default settings
    -- lspconfig = {
    --   cmd = {"yaml-language-server"}
    -- },
})

for _, lsp in ipairs(servers) do
    if lsp == "jsonls" then
        nvim_lsp.jsonls.setup({
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern(".git"),
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })
	if lsp == "yamlls" then
		nvim_lsp.yamlls.setup({
			on_attach = on_attach,
			root_dir = require("lspconfig.util").root_pattern(".git"),
			capabilities = capabilities,
			settings = yaml_cfg,
		})
	end
    else
        nvim_lsp[lsp].setup({
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern(".git"),
            capabilities = capabilities,
        })
    end
end

-- local rt = require("rust-tools")

local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

-- The path in windows is different
if this_os:find("Windows") then
    codelldb_path = package_path .. "adapter\\codelldb.exe"
    liblldb_path = package_path .. "lldb\\bin\\liblldb.dll"
else
    -- The liblldb extension is .so for linux and .dylib for macOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

-- rt.setup({
-- 	server = {
-- 		on_attach = function(_, bufnr)
-- 			-- Hover actions
-- 			vim.keymap.set("n", "<Leader>rch", rt.hover_actions.hover_actions, { buffer = bufnr })
-- 			-- Code action groups
-- 			vim.keymap.set("n", "<Leader>rca", rt.code_action_group.code_action_group, { buffer = bufnr })
-- 		end,
-- 		capabilities = capabilities,
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 				checkOnSave = {
-- 					command = "clippy",
-- 				},
-- 			},
-- 		},
-- 	},
-- 	tools = {
-- 		hover_actions = {
-- 			-- auto_focus = true,
-- 		},
-- 	},
-- 	dap = {
-- 		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
-- 	},
-- })

-- require("rust-tools").inlay_hints.enable()

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
    -- title = "FloatTitle",
    style = "minimal",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    focusable = true,
    relative = "cursor",
})

-- require('lspconfig').elixirls.setup {
--   cmd = { "elixir-ls" },
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
