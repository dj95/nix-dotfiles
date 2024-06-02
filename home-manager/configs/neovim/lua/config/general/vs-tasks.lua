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
-- Section: vs-tasks
-- Author: Daniel Jankowski
-- Date: 25.06.2023
--


local vstask = require('vstask')
local toggleterm = require('toggleterm')

toggleterm.setup({
  shell = "fish"
})

vstask.setup({
  cache_json_conf = true,
  cache_strategy = "last",
  config_dir = ".vscode",
  telescope_keys = {
    split = '<CR>',
    current = '<C-p>'
  },
  terminal = "toggleterm",
  term_opts = {
    vertical = {
      direction ="vertical",
      size = "80"
    },
    horizontal = {
      direction ="horizontal",
      size = "10"
    },
  }

})
