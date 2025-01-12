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
-- Section: theme
-- Author: Daniel Jankowski
-- Date: 25.09.2021
--

local vim = vim
local lsp_progress = require('lsp-progress')

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

function _G._diagnostics_section()
	local results = {}

    local diagnostics_attrs = {
        { "Error", "E" },
        { "Warn", "W" },
        { "Hint", "H" },
        { "Info", "I" },
    }

	for _, attr in pairs(diagnostics_attrs) do
		local n = vim.diagnostic.get(0, { severity = attr[1] })
		if #n > 0 then
			table.insert(results, string.format(" %s %d", attr[2], #n))
		end
    end

	return table.concat(results)
end

vim.opt.laststatus = 3 -- Or 3 for global statusline
vim.opt.statusline = " %f %m %{%v:lua.require('lsp-progress').progress()%} %{%v:lua._diagnostics_section()%} %= %l:%c %P %Y "
