final: prev: {
  mutagen = prev.pkgs.buildGoModule rec {
    pname = "mutagen";
    version = "0.17.5";

    goPackage = "github.com/mutagen-io/mutagen-compose";

    src = prev.pkgs.fetchFromGitHub {
      owner = "mutagen-io";
      repo = "mutagen";
      rev = "v${version}";
      sha256 = "sha256-K5Lf6V4wZscOWRvZz5hfUelB5L3XPDLoPIkL7PISe+c=";
    };

    agents = prev.pkgs.fetchzip {
      name = "mutagen-agents-${version}";
      # The package architecture does not matter since all packages contain identical mutagen-agents.tar.gz.
      url = "https://github.com/mutagen-io/mutagen/releases/download/v${version}/mutagen_linux_amd64_v${version}.tar.gz";
      stripRoot = false;
      postFetch = ''
        rm $out/mutagen # Keep only mutagen-agents.tar.gz.
      '';
      sha256 = "sha256-Uzfd1fZJ+x8m6/A2r0WJSiF2OW30WYiPkPQtdaqh4Qc=";
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

    vendorHash = "sha256-/hF4d6k1Wj5/SxmDhxkaoJ2ULywhehJ5vPpV5kpihkY=";
  };

  mutagen-compose = prev.pkgs.buildGoModule rec {
    pname = "mutagen-compose";
    version = "0.17.5";

    goPackage = "github.com/mutagen-io/mutagen-compose";

    src = prev.pkgs.fetchFromGitHub {
      owner = "mutagen-io";
      repo = "mutagen-compose";
      rev = "v${version}";
      sha256 = "sha256-EkUaxk+zCm1ta1/vjClZHki/MghLvUkCeiW7hST7WEc=";
    };

    vendorHash = "sha256-siLS53YVQfCwqyuvXXvHFtlpr3RQy2GP2/ZV+Tv/Lqc=";

    tags = [ "mutagencompose" ];
  };
}
