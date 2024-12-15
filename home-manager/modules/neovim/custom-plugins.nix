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

  lsp-progress-nvim = buildVimPlugin rec {
    name = "lsp-progress-nvim";
    pname = "${name}";
    version = "d5f4d28efe75ce636bfbe271eb45f39689765aab";
    src = pkgs.fetchFromGitHub {
      owner = "linrongbin16";
      repo = "lsp-progress.nvim";
      rev = "${version}";
      sha256 = "sha256-OafRT5AnxRTOh7MYofRFjti0+pobKQihymZs/kr5w0A=";
    };
  };

  magazine-nvim = buildVimPlugin rec {
    name = "magazine-nvim";
    pname = "${name}";
    version = "0.4.1";
    src = pkgs.fetchFromGitHub {
      owner = "iguanacucumber";
      repo = "magazine.nvim";
      rev = "${version}";
      sha256 = "sha256-qZsyQ6C8ODtJLT2XW5Mt2uD/WVrPSJzvGhnDeaAiqPA=";
    };
  };

  mag-cmp-lsp = buildVimPlugin rec {
    name = "mag-cmp-lsp";
    pname = "${name}";
    version = "0.1";
    src = pkgs.fetchFromGitHub {
      owner = "iguanacucumber";
      repo = "mag-nvim-lsp";
      rev = "${version}";
      sha256 = "sha256-O+b2ftrUgwpVw8VL2UwEyIOQmljjhP8v50I+w72EoFg=";
    };
  };

  mag-cmp-lua = buildVimPlugin rec {
    name = "mag-cmp-lua";
    pname = "${name}";
    version = "0.1";
    src = pkgs.fetchFromGitHub {
      owner = "iguanacucumber";
      repo = "mag-nvim-lua";
      rev = "${version}";
      sha256 = "sha256-752DI2iwuFQ+bjJKteLiXiMUJkOdq64VFbE+diMGFlo=";
    };
  };

  mag-cmp-buffer = buildVimPlugin rec {
    name = "mag-cmp-buffer";
    pname = "${name}";
    version = "0.1";
    src = pkgs.fetchFromGitHub {
      owner = "iguanacucumber";
      repo = "mag-buffer";
      rev = "${version}";
      sha256 = "sha256-gqKdlvzParKl+b5u1SkTqAPT11uls0MMC/f1s+TCRKU=";
    };
  };

  mag-cmp-cmdline = buildVimPlugin rec {
    name = "mag-cmp-cmdline";
    pname = "${name}";
    version = "0.1";
    src = pkgs.fetchFromGitHub {
      owner = "iguanacucumber";
      repo = "mag-cmdline";
      rev = "${version}";
      sha256 = "sha256-O0Lpe4yBhbGumJQSVeyl9NoJn4zLrE+OxdJOrFs7kEo=";
    };
  };

  markview-nvim = buildVimPlugin rec {
    name = "markview-nvim";
    pname = "${name}";
    version = "24.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "OXY2DEV";
      repo = "markview.nvim";
      rev = "v${version}";
      sha256 = "sha256-Bkwhg4RstOSRx+Jmjq5n2xjEkvyZ4Mx85lWn0YqRHxY=";
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
