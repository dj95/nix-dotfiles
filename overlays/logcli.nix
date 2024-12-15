final: prev: {
  logcli = prev.pkgs.buildGoModule rec {
    pname = "logcli";
    version = "3.1.1";

    goPackage = "github.com/grafana/loki";

    src = prev.pkgs.fetchFromGitHub {
      owner = "grafana";
      repo = "loki";
      rev = "v${version}";
      sha256 = "sha256-QOokLht/nIzQAzXQuJv5M4QTQD0Zhzf9+Q0ILl2Mds0=";
    };

    subPackages = [ "cmd/logcli" ];

    # grafana committed the vendor/ dir, so we should not set the hash
    vendorHash = null;
  };
}
