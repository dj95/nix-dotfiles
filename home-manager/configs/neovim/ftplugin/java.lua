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
-- Date: 22.11.2023
--

local vim = vim
local set = vim.o

set.shiftwidth = 2

local jdtls = require("jdtls")

local f = io.open(os.getenv("HOME") .. "/.config/lombokpath", "r")
local lombok_path = f:read("*a")
f.close()

local config = {
	cmd = {
        "/etc/profiles/per-user/daniel/bin/jdtls",
        "--jvm-arg=-javaagent:" .. lombok_path,
        "--add-modules=ALL-SYSTEM",
        "-data", os.getenv("HOME") .. "/.jdt-workspace"
    },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

jdtls.start_or_attach(config)
