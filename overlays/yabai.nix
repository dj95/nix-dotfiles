final: prev: {
  yabai = prev.yabai.overrideAttrs (drv: rec {
    version = "7.1.1";
    pname = "yabai";

    src = prev.fetchzip {
      url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
      sha256 = "sha256-LNOAT1vm6EEmcKdshMKjYWFfoRoRNbgZgjEpOTacWc8=";
    };
  });
}
