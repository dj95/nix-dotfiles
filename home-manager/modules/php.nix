{
  config,
  pkgs,
  libs,
  ...
}:
let
  php80 = pkgs.php80.buildEnv {
    extensions =
      { enabled, all }:
      enabled
      ++ [
        all.opcache
        all.xsl
      ];
    extraConfig = ''
      memory_limit = 64G
      date.timezone = Europe/Berlin
    '';
  };
in
{
  home.packages = with pkgs; [
    php82
    php82Extensions.opcache
    php82Extensions.xsl
    php82Packages.composer
  ];
}
