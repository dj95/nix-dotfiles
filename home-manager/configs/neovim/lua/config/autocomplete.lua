-- helper function for checking if an array contains a value
local function has_value (tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

-- initialize nvim-cmp for the completion pop up for
-- nvim-lsp
require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

-- add the cmp capabilities to the lsp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- define the language servers, that should be verified/installed
local lspservers = {
  "bash",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "html",
  "json",
  "latex",
  "lua",
  "php",
  "python",
  "terraform",
  "typescript",
  "vim",
  "yaml",
}

--  setup the different language servers
local function setup_servers()
  -- load the lspinstall module
  require'lspinstall'.setup()

  -- get the installed servers
  local servers = require'lspinstall'.installed_servers()

  -- iterate through the servers, that should be installed
  for _,lspserver in ipairs(lspservers) do
    -- if one server is not installed...
    if not has_value(servers, lspserver) then
      -- ...install it
      require'lspinstall'.install_server(lspserver)
    end
  end

  -- reload the servers in case they were fresh installed
  servers = require'lspinstall'.installed_servers()

  -- iterate through all installed servers
  for _, server in pairs(servers) do
    -- set them up with the cmp capabilities
    require'lspconfig'[server].setup{
      capabilities = capabilities,
    }
  end
end

-- setup the lsp servers
setup_servers()

-- initialize the trouble module
require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  mode = "lsp_workspace_diagnostics",
}

require'nvim-web-devicons'.setup {
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}

-- initialize the signature plugin to depict on which element
-- of the signature we currently edit and how the signature looks
-- like
require "lsp_signature".setup({
  bind = true,
  trigger_on_newline = false,
  handler_opts = {
    border = "none"
  }
})

-- initialzie and configure treesitter syntax highlightning
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

