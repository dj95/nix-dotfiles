final: prev: {
  crossplane-cli = prev.pkgs.buildGoModule rec {
    pname = "crossplane-cli";
    version = "1.16.0";

    goPackage = "github.com/crossplane/crossplane";

    src = prev.pkgs.fetchFromGitHub {
      owner = "crossplane";
      repo = "crossplane";
      rev = "v${version}";
      sha256 = "sha256-1067l3DM6/kW6d35+9nfMdFtu8jIzw/QJaHFKzOTbSc=";
    };

    subPackages = [ "cmd/crank" ];

    postInstall = ''
      mv $out/bin/crank $out/bin/crossplane
    '';

    vendorHash = "sha256-Ccc7hEsHkHw2P5cgMB06VVlHur5DCPclaEMoFCwoSrA=";
  };
}
