{
  config,
  pkgs,
  libs,
  ...
}:
let
  # source my custom packaged vim plugins, that are not
  # available in the nixpkgs repo
  custom-plugins = pkgs.callPackage ./neovim/custom-plugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
  };

  # combine official vim plugins with the custom ones
  # to simplify the installation process
  plugins = pkgs.vimPlugins // custom-plugins;

  myVimPlugins = with plugins; [
    #
    # General plugins
    #

    # file manager
    oil-nvim

    # add the matching paranthesis, bracket, brace...
    nvim-autopairs

    # fuzzy file search
    telescope-nvim
    plenary-nvim
    telescope-fzf-native-nvim
    dressing-nvim

    # snippets
    friendly-snippets

    # notes
    adr-nvim

    #
    # Visuals
    #

    # custom tab and statusline
    lsp-progress-nvim

    # general snacks and improvements
    snacks-nvim

    # colorscheme
    gruvbox-nvim

    # faster motions
    leap-nvim
    vim-repeat

    # file browser
    nvim-web-devicons

    # different syntax highlightnings
    comment-nvim
    typst-vim
    fzf-lua
    markview-nvim
    hmts-nvim
    vim-just

    # tree-sitter with required grammars
    (nvim-treesitter.withPlugins (
      plugins: with plugins; [
        tree-sitter-bash
        tree-sitter-bibtex
        tree-sitter-c
        tree-sitter-cmake
        tree-sitter-cpp
        tree-sitter-css
        tree-sitter-dockerfile
        tree-sitter-fish
        tree-sitter-go
        tree-sitter-gomod
        tree-sitter-hcl
        tree-sitter-html
        tree-sitter-http
        tree-sitter-java
        tree-sitter-javascript
        tree-sitter-jsdoc
        tree-sitter-json
        tree-sitter-json5
        tree-sitter-jsonc
        tree-sitter-just
        tree-sitter-kdl
        tree-sitter-latex
        tree-sitter-lua
        tree-sitter-make
        tree-sitter-markdown
        tree-sitter-markdown-inline
        tree-sitter-nix
        tree-sitter-org
        tree-sitter-php
        tree-sitter-python
        tree-sitter-regex
        tree-sitter-rust
        tree-sitter-scss
        tree-sitter-swift
        tree-sitter-toml
        tree-sitter-tsx
        tree-sitter-twig
        tree-sitter-typescript
        tree-sitter-typst
        tree-sitter-vim
        tree-sitter-yaml
      ]
    ))

    # display git status
    gitsigns-nvim
    neogit
    diffview-nvim

    # zoom into one split like in tmux
    zoomwintab-vim

    #
    # Autocompletion
    #

    # configure the built in lsp
    nvim-lspconfig

    # cmp autocompletion
    blink-cmp
    blink-cmp-emoji
    lspsaga-nvim
    conform-nvim
    nvim-lint
    nvim-highlight-colors

    # java
    nvim-jdtls

    # show workspace diagnostics in a split
    trouble-nvim
    tiny-inline-diagnostic-nvim

    # todo comments
    todo-comments-nvim
  ];
in
{
  home.packages = with pkgs; [
    gh
    tree-sitter

    # language servers
    bash-language-server # bash
    llvm # clangd
    nodePackages.vscode-langservers-extracted # html, css, json
    nodePackages.dockerfile-language-server-nodejs # docker
    gopls # go
    jdt-language-server # java
    lombok # java
    texlab # latex
    tinymist # typst
    lua-language-server # lua
    rust-analyzer # rust
    nodePackages.intelephense # php
    python311Packages.python-lsp-server # python
    terraform-ls # terraform
    nodePackages.typescript-language-server # typescript
    nodePackages.vim-language-server # vim
    nodePackages.yaml-language-server # yaml
    lemminx # xml
    vale-ls # prose

    # linter and formatter
    nodePackages.eslint_d # typescript
    codespell
    hadolint # dockerfile
    stylua # lua
    google-java-format # java
    luajitPackages.luassert
    shellcheck # bash
    nodePackages.markdownlint-cli # markdown
    nodePackages.prettier # typescript
    python311Packages.black
    python311Packages.flake8
    libxml2 # xmllint
    kdl-fmt
    go-tools
    gherkin-lint
    tflint
    typstfmt
    ruff
    vale # prose
    xmlformat
    yamlfmt
    yamllint
  ];

  programs.neovim = {
    enable = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    extraConfig = ''
      let g:loaded_perl_provider = 0

      lua require('config')
    '';
    plugins = myVimPlugins;
  };

  # configure neovim
  xdg.configFile."nvim/after/".source = ../configs/neovim/after;
  xdg.configFile."nvim/ftplugin/".source = ../configs/neovim/ftplugin;
  xdg.configFile."nvim/lua/".source = ../configs/neovim/lua;
  xdg.configFile."lombokpath".text = "${pkgs.lombok}/share/java/lombok.jar";

  # configure linter
  xdg.configFile."yamllint/config".source = ../configs/linter/yamllint;
}
