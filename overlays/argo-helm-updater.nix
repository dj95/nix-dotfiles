final: prev: {
  argo-helm-updater = prev.pkgs.rustPlatform.buildRustPackage rec {
    version = "0.3.0";
    pname = "argo-helm-updater";

    src = prev.fetchFromGitHub {
      owner = "dj95";
      repo = pname;
      rev = "7e4b7e687e1cba57ceaeb9a79f9541a3ccf246b7";
      sha256 = "sha256-kYIPSFDQeAqcYQiGlc4o/EqZlTKgyojOUjY5mYOVgPE=";
    };

    cargoShaHash = "sha256-aVMUcuGVROA3KdMr3bNtsHz7lSNe7iDmozdr1O8mjzU=";

    nativeBuildInputs = [
      prev.pkgs.pkg-config
      prev.pkgs.libiconv
      prev.pkgs.openssl
    ];

    buildInputs =
      [ ]
      ++ prev.pkgs.lib.optionals prev.pkgs.stdenv.isDarwin [
        prev.pkgs.darwin.apple_sdk.frameworks.Cocoa
        prev.pkgs.darwin.apple_sdk.frameworks.CoreGraphics
        prev.pkgs.darwin.apple_sdk.frameworks.Foundation
        prev.pkgs.darwin.apple_sdk.frameworks.IOKit
        prev.pkgs.darwin.apple_sdk.frameworks.Kernel
        prev.pkgs.darwin.apple_sdk.frameworks.OpenGL
        prev.pkgs.darwin.apple_sdk.frameworks.Security
        prev.pkgs.openssl
      ];

    PKG_CONFIG_PATH = "${prev.pkgs.openssl.dev}/lib/pkgconfig";
  };
}
