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
local conform = require("conform")

require("conform.formatters.eslint_d").cwd = require("conform.util").root_file({
  ".eslintrc.js",
  ".eslintrc.cjs",
})
require("conform.formatters.eslint_d").require_cwd = true

require('conform.formatters.markdownlint').args = {
  "--disable",
  "MD013",
  "MD033",
  "MD036",
  "MD041",
  "--",
}
require('conform.formatters.yamlfmt').args = {
  "-formatter",
  "include_document_start=true,retain_line_breaks=true",
  "-",
}

conform.setup({
  formatters_by_ft = {
    css = { "eslint_d" },
    go = { "gofmt" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    java = { "google-java-format" },
    json = { "jq" },
    latex = { "latexindent" },
    lua = { "stylua" },
    markdown = { "markdownlint" },
    nix = { "nixfmt" },
    php = { "php_cs_fixer" },
    python = { "ruff_fix", "ruff_format" },
    rust = { "rustfmt" },
    terraform = { "terraformfmt" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    typst = { "typstfmt" },
    xml = { "xmlformat" },
    yaml = { "yamlfmt" },
  },
})
