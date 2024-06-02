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
-- Date: 14.09.2022
--


local mdeval = require('mdeval')

mdeval.setup({
  require_confirmation = false,
  eval_options = {
    javascript = {
      command = {"node"},
      language_code = "javascript",
      exec_type = "interpreted",
      extension = "js",
    },
    php = {
      command = {"php"},
      language_code = "php",
      exec_type = "interpreted",
      extension = "php",
    },
    fish = {
      command = {"fish"},
      language_code = "fish",
      exec_type = "interpreted",
      extension = "fish",
    },
    go = {
      command = {"GO111MODULE=off", "go", "run"},
      language_code = "go",
      exec_type = "interpreted",
      extension = "go",
      default_header = [[package main]],
    },
  },
})
