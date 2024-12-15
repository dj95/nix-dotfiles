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
-- Date: 17.07.2023
--

-- imports
local lint = require("lint")

lint.linters.markdownlint.args = {
	"--disable",
	"MD013",
	"MD033",
	"MD036",
	"MD041",
	"--",
}

lint.linters.phpstan.args = {
	"analyze",
	"--level=9",
	"--error-format=json",
	"--no-progress",
}

lint.linters.staticcheck.stdin = false

lint.linters_by_ft = {
	dockerfile = { "hadolint" },
	go = { "golangcilint" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	markdown = { "markdownlint", "vale" },
	nix = { "nix" },
	php = { "phpstan" },
    python = { "ruff" },
	sh = { "shellcheck" },
    terraform = { "tflint" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	yaml = { "yamllint" },
}
