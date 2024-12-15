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
-- Section: themes
-- Author: Daniel Jankowski
-- Date: 24.04.2022
--

local vim = vim
local lualine = require('lualine')
local lsp_progress = require('lsp-progress')
local colors = require('catppuccin.palettes').get_palette()
-- local colors = require 'rose-pine.palette' -- fetch colors with API

lsp_progress.setup({
    format = function(client_messages)
        -- icon: nf-fa-gear \uf013
        local sign = " LSP"
        if #client_messages > 0 then
            return sign .. " " .. table.concat(client_messages, " ")
        end
        if #vim.lsp.get_active_clients() > 0 then
            return ""
        end
        return ""
    end,
})

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand "%:p:h"
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

colors.bg = "#0e0801"
colors.bg_statusline = "#0e0801"
colors.foam_dawn = "#56949f"

local mode_color = {
    n = colors.blue,
    i = colors.green,
    v = colors.maroon,
    ['^V'] = colors.maroon,
    V = colors.maroon,
    c = colors.mauve,
    no = colors.sky,
    s = colors.peach,
    S = colors.peach,
    ['^S'] = colors.peach,
    ic = colors.yellow,
    R = colors.mauve,
    Rv = colors.mauve,
    cv = colors.maroon,
    ce = colors.maroon,
    r = colors.sky,
    rm = colors.sky,
    ['r?'] = colors.sky,
    ['!'] = colors.maroon,
    t = colors.maroon,
}

-- colors.bg = "#33362E"
-- colors.bg_statusline = colors.muted
-- colors.foam_dawn = "#56949f"

local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
            winbar = { "NvimTree" },
        },
        globalstatus = true,
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg_statusline, bg = colors.bg } },
            inactive = { c = { fg = colors.fg_statusline, bg = colors.bg } },
        },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {
            {
                function()
                    local col = vim.api.nvim_get_hl_by_name("LualineViModeStart", true)

                    if col.background ~= tonumber(mode_color[vim.fn.mode()]:sub(2), 16) then
                        vim.api.nvim_command("hi LualineViModeStart guibg=" .. mode_color[vim.fn.mode()])
                    end

                    return " "
                end,
                color = "LualineViModeStart",
                padding = { right = 0 },
            },
            {
                function()
                    local col = vim.api.nvim_get_hl_by_name("LualineViMode", true)

                    if col.foreground ~= tonumber(mode_color[vim.fn.mode()]:sub(2), 16) then
                        vim.api.nvim_command(
                            "hi LualineViMode guifg="
                            .. mode_color[vim.fn.mode()]
                            .. " guibg="
                            .. colors.bg
                            .. " gui=bold cterm=bold"
                        )
                    end

                    return require("lualine.utils.mode").get_mode()
                end,
                icons_enabled = true,
                color = "LualineViMode",
                fmt = string.upper,
                padding = { right = 1, left = 1 },
            },{
                'filename',
                path = 1,
                shorting_target = 40,
                color = { fg = colors.overlay2, gui = 'bold' },
            },
            {
                'diff',
                symbols = { added = '  ', modified = '  ', removed = '  ' },
                cond = conditions.check_git_workspace,
            },
            {
                -- invoke `progress` here.
                function()
                    return lsp_progress.progress()
                end,
            },
        },
        lualine_x = {
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' ', warn = ' ', info = ' ' },
                diagnostics_color = {
                    color_error = { fg = colors.red },
                    color_warn = { fg = colors.yellow },
                    color_info = { fg = colors.cyan },
                },
            },
            {
                'location',
                color = { fg = colors.overlay2 },
                padding = { left = 1, right = 1 },
            },
            {
                'progress',
                color = { fg = colors.overlay2 },
                padding = { left = 0, right = 1 },
            },
            {
                'filetype',
                colored = false,
                color = { fg = colors.overlay2 },
            },
            {
                function()
                    return vim.opt.shiftwidth:get()
                end,
                icon = "הּ",
                cond = conditions.buffer_not_empty,
                color = { fg = colors.overlay2 }
            },
            {
                'fileformat',
                fmt = string.upper,
                cond = conditions.buffer_not_empty,
                color = { fg = colors.overlay2 },
                padding = { right = 0, left = 1 },
            },
            {
                'o:encoding',
                fmt = string.upper,
                cond = conditions.buffer_not_empty,
                color = { fg = colors.overlay2 },
            },
            {
                'branch',
                cond = conditions.check_git_workspace,
                icon = '',
                color = { fg = colors.overlay2 },
            },
        },
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {
            {
                function()
                    return " "
                end,
                color = { bg = colors.foam },
                padding = { right = 0 },
            },
            {
                'filename',
                path = 1,
                shorting_target = 40,
                color = { fg = colors.muted },
            },
        },
        lualine_x = {},
    },
}

lualine.setup(config)
