final: prev: {
  mutagen = prev.pkgs.buildGoModule rec {
    pname = "mutagen";
    version = "0.17.6";

    goPackage = "github.com/mutagen-io/mutagen";

    src = prev.pkgs.fetchFromGitHub {
      owner = "mutagen-io";
      repo = "mutagen";
      rev = "v${version}";
      sha256 = "sha256-GkTMc+gS90M0Jx00nV8+QW/F2iBMmi/oNpwFun18yy4=";
    };

    agents = prev.pkgs.fetchzip {
      name = "mutagen-agents-${version}";
      # The package architecture does not matter since all packages contain identical mutagen-agents.tar.gz.
      url = "https://github.com/mutagen-io/mutagen/releases/download/v${version}/mutagen_linux_amd64_v${version}.tar.gz";
      stripRoot = false;
      postFetch = ''
        rm $out/mutagen # Keep only mutagen-agents.tar.gz.
      '';
      sha256 = "sha256-0Oh5k2tKhQzlL8E6vWEMDyZ1JGw329K5E7Y8kam2Sec=";
    };

    tags = [ "mutagencli" ];

    doCheck = false;

    subPackages = [
      "cmd/mutagen"
      "cmd/mutagen-agent"
    ];

    postInstall = ''
      install -d $out/libexec
      ln -s ${agents}/mutagen-agents.tar.gz $out/libexec/
    '';

    vendorHash = "sha256-Bd2fI2p/8JNoN3Q3sJFuF83YyXUi5j68udW6QnVMViM=";
  };

  mutagen-compose = prev.pkgs.buildGoModule rec {
    pname = "mutagen-compose";
    version = "0.17.6";

    goPackage = "github.com/mutagen-io/mutagen-compose";

    src = prev.pkgs.fetchFromGitHub {
      owner = "mutagen-io";
      repo = "mutagen-compose";
      rev = "v${version}";
      sha256 = "sha256-ZcfwpEfdoSMCGtw5Icj1hXbk5CRYS4LBtdaiX62E4I0=";
    };

    vendorHash = "sha256-XyWi06siSHOKZca0w4WLIFGM63wnF//2rRP4aH5rFAo=";

    tags = [ "mutagencompose" ];
  };
}
