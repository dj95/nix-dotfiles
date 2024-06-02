final: prev: {
  zellij = prev.zellij.overrideAttrs (drv: rec {
    version = "0.41.0";
    pname = "zellij";

    src = prev.fetchFromGitHub {
      owner = "zellij-org";
      repo = pname;
      rev = "1fda2e2c7399f22abed8dd5dd72fe6c367f075d2";
      sha256 = "sha256-MH3CEv6tuSYpym/sSgh/OXW4SF4bG3ZE3ocws9SmVqk=";
    };

    cargoDeps = drv.cargoDeps.overrideAttrs (
      prev.lib.const {
        inherit src;
        outputHash = "sha256-15DLRPd8OjUsbPbkHcTW9zSJSy2G4bb+FaFrzuW3SqE=";
      }
    );
  });
}
