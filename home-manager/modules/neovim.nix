{ config, pkgs, libs, ... }:
let
  vim-plug-repo = pkgs.fetchgit {
    url = "https://github.com/junegunn/vim-plug.git";
    rev = "fc2813ef4484c7a5c080021ceaa6d1f70390d920";
    sha256 = "k32+ClhsWgmusKK3/8C0WrpyC1SlvdKDkLqEfwJHVDs=";
  };
in {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    extraConfig = builtins.readFile ../configs/neovim/init.light.vim;
    plugins = with pkgs.vimPlugins; [
      #
      # General plugins
      #

      # add the matching paranthesis, bracket, brace...
      vim-surround
      auto-pairs
      vim-fugitive

      # move visual blocks
      vim-move

      # markdown rendering
      # shime/vim-livedown

      # go development
      vim-go

      # fuzzy file search
      fzf-vim
      telescope-nvim
      telescope-z-nvim
      plenary-nvim

      # snippets
      ultisnips
      vim-snippets

      #
      # Visuals
      #

      # airline support and tagbar
      vim-airline
      # vim-airline-themes
      tagbar

      # highlight indents
      indentLine

      # file browser
      nerdtree
      vim-nerdtree-syntax-highlight
      vim-devicons
      nvim-web-devicons

      # different syntax highlightnings
      vim-vue
      ansible-vim
      vim-twig
      vim-nix
      nvim-treesitter

      # display git status
      vim-gitgutter

      # zoom into one split like in tmux
      zoomwintab-vim

      #
      # Autocompletion
      #

      # install the completion engine
      nvim-lspconfig
      trouble-nvim
      lsp_signature-nvim
    ];
  };

  # configure neovim
  xdg.configFile."nvim/config/".source = ../configs/neovim/config;
  xdg.configFile."nvim/colors/".source = ../configs/neovim/colors;
  xdg.configFile."nvim/lua/".source = ../configs/neovim/lua;
  xdg.configFile."nvim/coc-settings.json".source = ../configs/neovim/coc-settings.json;
  home.file.".local/share/nvim/site/autoload/plug.vim".source = "${vim-plug-repo}/plug.vim";
}
