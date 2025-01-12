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

local vim = vim
local blink = require("blink.cmp")

blink.setup({
    completion = {
        documentation = {
            auto_show = true
        },
        ghost_text = {
            enabled = true,
        },
    },
    fuzzy = {
        prebuilt_binaries = {
            download = false,
        }
    },
    keymap = {
         preset = 'default',
         ['<Up>'] = { 'select_prev', 'fallback' },
         ['<Down>'] = { 'select_next', 'fallback' },
         ['<Tab>'] = { 'select_and_accept', 'fallback' },
    },
    sources = {
        default = { 'lsp', 'path', 'emoji', 'buffer' },
        providers = {
            lsp = {
                name = 'LSP',
                module = 'blink.cmp.sources.lsp',
                score_offset = 10,
            },
            emoji = {
                module = "blink-emoji",
                name = "Emoji",
            }
        }
    }
})
