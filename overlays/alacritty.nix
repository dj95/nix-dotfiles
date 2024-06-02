final: prev: {
  alacritty = prev.alacritty.overrideAttrs (drv: rec {
    version = "0.13.1";
    pname = "alacritty";

    src = prev.fetchFromGitHub {
      owner = "alacritty";
      repo = pname;
      rev = "fe2a3c566759c9926150181006bd56cb2293ae10";
      sha256 = "sha256-Nn/G7SkRuHXRSRgNjlmdX1G07sp7FPx8UyAn63Nivfg=";
    };

    cargoDeps = drv.cargoDeps.overrideAttrs (
      prev.lib.const {
        inherit src;
        outputHash = "sha256-WvOKsk9UGIMkGH6BRfWOKsVY985lhjy7M3ikafL16+4=";
      }
    );
  });
}
