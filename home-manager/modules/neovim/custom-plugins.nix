{ pkgs, buildVimPlugin }:

{
  #
  # General
  #

  adr-nvim = buildVimPlugin rec {
    name = "adr-nvim";
    pname = "${name}";
    version = "9837939a49090994de8e0af1af822130039a1165";
    src = pkgs.fetchFromGitHub {
      owner = "dj95";
      repo = "adr-nvim";
      rev = "${version}";
      sha256 = "sha256-gCRUSY3nJ69yk/dIJeKKJJH2URyKulh1+dvykFBvbjY=";
    };
  };

  neogit = buildVimPlugin rec {
    name = "neogit";
    pname = "${name}";
    version = "70ad95be902ee69b56410a5cfc690dd03104edb3";
    src = pkgs.fetchFromGitHub {
      owner = "NeogitOrg";
      repo = "neogit";
      rev = "${version}";
      sha256 = "sha256-hkb33SOJJMqPXj8xJ1epZBDyH/OCX+MQom8jVPJEXyw=";
    };
  };

  lsp-progress-nvim = buildVimPlugin rec {
    name = "lsp-progress-nvim";
    pname = "${name}";
    version = "55a04895ea20c365b670051a3128265d43bdfa3d";
    src = pkgs.fetchFromGitHub {
      owner = "linrongbin16";
      repo = "lsp-progress.nvim";
      rev = "${version}";
      sha256 = "sha256-lemswtWOf6O96YkUnIFZIsuZPO4oUTNpZRItsl/GSnU=";
    };
  };

  origami-nvim = buildVimPlugin rec {
    name = "origami-nvim";
    pname = "${name}";
    version = "f0a8ac281ca13ff09d534118225a26076e7b91e0";
    src = pkgs.fetchFromGitHub {
      owner = "chrisgrieser";
      repo = "nvim-origami";
      rev = "${version}";
      sha256 = "sha256-iaOWe68MVjFBhDeBpHwEXvDWd0pHjnaeCkJKYmQehFk=";
    };
  };

  #
  # Languages
  #

  vim-kubernetes = buildVimPlugin rec {
    name = "vim-kubernetes";
    pname = "${name}";
    version = "d5fe1c319b994149b25c9bee1327dc8b3bebe4b7";
    src = pkgs.fetchFromGitHub {
      owner = "andrewstuart";
      repo = "vim-kubernetes";
      rev = "${version}";
      sha256 = "sha256-BtuGFF78+OtsJr/PdWOJK9vR+QkqCd4MTwq3DZAfmDo=";
    };
  };
}
