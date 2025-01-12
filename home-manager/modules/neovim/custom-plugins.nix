{ pkgs, buildVimPlugin, git }:
let
  version = "0.9.2";
  src = pkgs.fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "refs/tags/v${version}";
    hash = "sha256-uvMB3oU6uxERfkXiweeFS0cCIOgO/ogy7GoYAlXUPDs=";
  };
  libExt = if pkgs.stdenv.hostPlatform.isDarwin then "dylib" else "so";
  blink-fuzzy-lib = pkgs.rustPlatform.buildRustPackage {
    inherit version src;
    pname = "blink-fuzzy-lib";

    useFetchCargoVendor = true;
    cargoHash = "sha256-ISCrUaIWNn+SfNzrAXKqeBbQyEnuqs3F8GAEl90kK7I=";

    nativeBuildInputs = [ git ];

    env = {
      # TODO: remove this if plugin stops using nightly rust
      RUSTC_BOOTSTRAP = true;
    };
  };
in
{
  #
  # General
  #

  blink-cmp = buildVimPlugin rec {
    name = "blink-cmp";
    pname = "${name}";
    version = "0.9.2";
    preInstall = ''
      mkdir -p target/release
      ln -s ${blink-fuzzy-lib}/lib/libblink_cmp_fuzzy.${libExt} target/release/libblink_cmp_fuzzy.${libExt}
    '';
    passthru = {
      updateScript = pkgs.nix-update-script {
        attrPath = "vimPlugins.blink-cmp.blink-fuzzy-lib";
      };

      # needed for the update script
      inherit blink-fuzzy-lib;
    };
    src = pkgs.fetchFromGitHub {
      owner = "Saghen";
      repo = "blink.cmp";
      rev = "v${version}";
      sha256 = "sha256-uvMB3oU6uxERfkXiweeFS0cCIOgO/ogy7GoYAlXUPDs=";
    };
  };

  blink-cmp-emoji = buildVimPlugin rec {
    name = "blink-cmp-emoji";
    pname = "${name}";
    version = "81e6c080d1e64c9ef548534c51147fd8063481c8";
    src = pkgs.fetchFromGitHub {
      owner = "moyiz";
      repo = "blink-emoji.nvim";
      rev = "${version}";
      sha256 = "sha256-xzBMFc1BwCNEWJGFWQbXSuxZ4WsiTs2gbFdPW+nSBc4=";
    };
    nvimSkipModule = ["blink-emoji"];
  };

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
}
