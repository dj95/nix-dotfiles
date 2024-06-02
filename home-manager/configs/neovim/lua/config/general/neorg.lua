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
-- Section: general
-- Author: Daniel Jankowski
-- Date: 23.02.2022
--

local neorg = require("neorg")


neorg.setup{
  load = {
    ["core.defaults"] = {},
    ["core.keybinds"] = {},
    ["core.dirman"] = {
      config = {
        default_workspace = "work",
        workspaces = {
          work = "~/norg/work",
        },
      },
    },
    ["core.highlights"] = {
      config = {
        dim = {
          tags = {
            ranged_verbatim = {
              code_block = {
                reference = "Normal",
                percentage = 25,
                affect = "background",
              },
            },
          },
        },
      },
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.concealer"] = {
      config = {
        folds = true,
      },
    },
    ["core.integrations.treesitter"] = {
      config = {},
    },
    ["core.export"] = {
      config = {

      },
    },
    ["core.export.markdown"] = {
      config = {

      },
    },
  },
}
