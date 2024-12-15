final: prev: {
  kustomize-quick-create = prev.pkgs.rustPlatform.buildRustPackage rec {
    version = "0.2.0";
    pname = "kustomize-quick-create";

    src = prev.fetchFromGitHub {
      owner = "dj95";
      repo = pname;
      rev = "027874bd76b2549dbfe9f13387ec71e781b1dcca";
      sha256 = "sha256-p/CrWxv30R4hPioySqRzt7mrljPjPLtEzOjq8pDG8JQ=";
    };

    cargoHash = "sha256-pHWpj8I+aQmbxpbhprxTH5Rh+q1/p9FSVAgoN9gwhZo=";
  };
}
