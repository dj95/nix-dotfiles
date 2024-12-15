--        ___                       ___           ___           ___
--       /\__\          ___        /\__\         /\  \         /\  \
--      /:/  /         /\  \      /::|  |       /::\  \       /::\  \
--     /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \
--    /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \
--    |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\
--    |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/
--    |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \
--     \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \
--      ~~~~         \/__/         /:/  /       |:|  |        \:\__\
--                                 \/__/         \|__|         \/__/
--
--
-- Section: languages
-- Author: Daniel Jankowski
-- Date: 25.09.2021
--

-- imports
local cmp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local vim = vim

-- create capabilities for cmp
local capabilities = cmp.default_capabilities()

-- setup single servers
lspconfig.bashls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.dockerls.setup({ capabilities = capabilities })
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.texlab.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
lspconfig.intelephense.setup({ capabilities = capabilities })
lspconfig.pylsp.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            files = {
                excludeDirs = { ".direnv", ".github" },
            },
        },
    }
})
lspconfig.ts_ls.setup({ capabilities = capabilities })
lspconfig.vimls.setup({ capabilities = capabilities })
lspconfig.lemminx.setup({ capabilities = capabilities })
lspconfig.terraformls.setup({ capabilities = capabilities })
lspconfig.typst_lsp.setup({ capabilities = capabilities })
lspconfig.vale_ls.setup({ capabilities = capabilities })
lspconfig.yamlls.setup({
    capabilities = capabilities,
    settings = {
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
        yaml = {
            keyOrdering = false,
        },
    },
})

-- pretty lsp hint signs
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type

    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
