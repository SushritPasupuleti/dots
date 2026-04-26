--- Mason ---
vim.lsp.log.set_level("WARN")

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

require("mason").setup({
    PATH = "append",
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
require("mason-lspconfig").setup({
    -- ensure_installed = ...,
    -- automatic_installation = true,
})

--- LSP Config ---
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
}

-- Keymaps and per-buffer setup via LspAttach (replaces on_attach)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        local conform = require("conform")
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
        vim.keymap.set("n", "<space>f", conform.format, bufopts)

        if client then
            navic.attach(client, bufnr)
        end
        require("lsp_signature").on_attach(signature_setup, bufnr)
    end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- Hover and signature help float borders (replaces vim.lsp.with)
vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.diagnostic.config({
    float = { border = "single" },
})

-- Per-server configs using vim.lsp.config (new API)
vim.lsp.config("jsonls", {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config("yamlls", {
    capabilities = capabilities,
    settings = require("yaml-companion").setup({}),
})

vim.lsp.config("terraformls", {
    capabilities = capabilities,
    filetypes = { "terraform" },
    cmd = {
        "terraform-ls", "serve",
        "-log-file", vim.fs.dirname(require("vim.lsp.log").get_filename()) .. "/terraform-ls.log",
    },
})

-- Enable all servers (vim.lsp.enable replaces the setup loop)
vim.lsp.enable({
    "cssls",
    "dockerls",
    "gopls",
    "jsonls",
    "ts_ls",
    "pyright",
    "vimls",
    "yamlls",
    "tailwindcss",
    "sqlls",
    "html",
    "dotls",
    "ansiblels",
    "arduino_language_server",
    "kotlin_language_server",
    "lua_ls",
    "nil_ls",
    "terraformls",
    "graphql",
    "awk_ls",
    "ocamllsp",
    "omnisharp",
    "csharp_ls",
})
