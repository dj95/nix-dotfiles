final: prev: {
  zellij = prev.zellij.overrideAttrs (drv: rec {
    version = "0.41.2";
    pname = "zellij";

    src = prev.fetchFromGitHub {
      owner = "zellij-org";
      repo = pname;
      rev = "v0.41.2";
      sha256 = "sha256-xdWfaXWmqFJuquE7n3moUjGuFqKB90OE6lqPuC3onOg=";
    };

    cargoDeps = drv.cargoDeps.overrideAttrs (
      prev.lib.const {
        inherit src;
        outputHash = "sha256-38hTOsa1a5vpR1i8GK1aq1b8qaJoCE74ewbUOnun+Qs=";
      }
    );

    buildInputs = [
      final.pkgs.openssl
      final.pkgs.curl
    ] ++ final.lib.optionals final.stdenv.isDarwin [
      final.pkgs.libiconv
      final.pkgs.darwin.apple_sdk.frameworks.DiskArbitration
      final.pkgs.darwin.apple_sdk.frameworks.Foundation
    ];
  });
}
