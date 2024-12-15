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
-- Section: shortcuts
-- Author: Daniel Jankowski
-- Date: 24.04.2022
--

local vim = vim
local g = vim.g
local map = vim.keymap.set

-- configure the leader key
g.mapleader = " "

-- easy buffer nav
map("n", "<C-j>", ":bp<CR>")
map("n", "<C-k>", ":bn<CR>")

-- telescope
map("n", "<leader>sp", require("telescope.builtin").live_grep)
map("n", "<leader><SPACE>", require("telescope.builtin").find_files)
map("n", "<leader>gL", require("telescope.builtin").git_bcommits)
map("n", "<leader>bb", require("telescope.builtin").buffers)
map("n", "<leader>cc", require("telescope.builtin").commands)
map("n", "<leader>fo", require("telescope.builtin").oldfiles)
map("v", "<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { noremap = true })

-- window splitting
map("n", "<C-w>z", ":ZoomWinTabToggle<CR>")
map("n", "<leader>wv", ":vsplit<CR>")
map("n", "<leader>wh", ":split<CR>")
map("n", "<leader>wc", ":close<CR>")

-- neogit
map("n", "<leader>gg", require("neogit").open)
map("n", "<leader>gb", require("gitsigns").toggle_current_line_blame)

-- norg
map("n", "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>")
map("n", "<leader>nj", ":Neorg journal<CR>")

-- adr
map("n", "<leader>na", function() require('adr').create_from_template() end)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		-- lsp
		map("n", "<leader>cx", function()
			require("trouble").toggle({ mode = "diagnostics" })
		end)
		map("n", "<leader>ct", function()
			require("trouble").toggle({ mode = "todo" })
		end)
		map("n", "<leader>ck", function()
			vim.lsp.buf.hover({ buffer = args.buf })
		end)
		map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
		map("n", "<leader>cf", function() require("conform").format() end)

		-- gotos
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "gy", vim.lsp.buf.declaration)
		map("n", "gi", require("telescope.builtin").lsp_implementations)
		map("n", "gr", require("telescope.builtin").lsp_references)
		map("n", "gR", "<cmd>Lspsaga rename<CR>")

		-- diagnostic
		map("n", "[e", ":Lspsaga diagnostic_jump_prev<CR>")
		map("n", "]e", ":Lspsaga diagnostic_jump_next<CR>")
	end,
})

-- ollama gen
map("n", "<leader>gp", ":Gen<CR>")
map("v", "<leader>gp", ":Gen<CR>")

-- neorg/mdeval
map("n", "<leader>cc", function()
	require("mdeval").eval_code_block()
end)

-- avante
map("n", "<leader>aa", function() require("avante.api").ask() end)
map("v", "<leader>aa", function() require("avante.api").ask() end)

-- learn things the hard way...
--
-- map("n", "<Up>", ':echomsg "use k"<CR>')
-- map("n", "<Down>", ':echomsg "use j"<CR>')
-- map("n", "<Left>", ':echomsg "use h"<CR>')
-- map("n", "<Right>", ':echomsg "use l"<CR>')
