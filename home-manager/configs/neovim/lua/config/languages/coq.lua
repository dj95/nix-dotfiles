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
--
-- COQ is just configured in this module. It is injected and
-- started in the config.languages.lsp module since it must be
-- added as a capability to the lsp client.

-- imports
local coq_3p = require "coq_3p"


-- initialize coq for the completion pop up for
vim.g.coq_settings = {
  auto_start = 'shut-up',
  xdg = true,
}


-- initialize coq third party plugs
coq_3p {
  {
    src = "repl",
    sh = "bash",
    shell = { p = "php", n = "node" },
    max_lines = 99,
    deadline = 500,
    unsafe = { "rm", "poweroff", "mv" }
  },
  {
    src = "nvimlua",
    short_name = "nLUA",
    conf_only = true,
  },
}
