{
  config,
  pkgs,
  libs,
  ...
}:
let
  llef = pkgs.fetchgit {
    url = "https://github.com/foundryzero/llef.git";
    rev = "2a79f990c48059cf69cbd2b9c8d10c3d8f03fbf1";
    sha256 = "sha256-eMVcAoGnWZy+mqPC1nQ4XLntrspUnr1DprII9lrIwAY=";
  };
in
{
  xdg.configFile."lldb".source = "${llef}";

  home.file.".lldbinit".text = ''
    command script import "${llef}/llef.py"
    settings set stop-disassembly-display never
    settings set target.x86-disassembly-flavor intel
  '';
}
