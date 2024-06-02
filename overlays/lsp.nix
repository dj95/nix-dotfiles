final: prev: {
  lemminx = prev.pkgs.stdenv.mkDerivation rec {
    pname = "lemminx";
    version = "0.26.1";

    src = prev.pkgs.fetchurl {
      url =
        if prev.pkgs.stdenv.isDarwin then
          "https://github.com/redhat-developer/vscode-xml/releases/download/${version}/lemminx-osx-x86_64.zip"
        else
          "https://github.com/redhat-developer/vscode-xml/releases/download/${version}/lemminx-linux.zip";
      sha256 =
        if prev.pkgs.stdenv.isDarwin then
          "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
        else
          "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    nativeBuildInputs =
      if prev.pkgs.stdenv.isDarwin then
        [ prev.pkgs.unzip ]
      else
        [
          prev.pkgs.unzip
          prev.pkgs.autoPatchelfHook
        ];
    buildInputs = [ prev.pkgs.zlib ];

    unpackPhase = ''
      unzip $src
    '';

    dontBuild = true;

    installPhase =
      if prev.pkgs.stdenv.isDarwin then
        ''
          mkdir -p $out/bin
          cp lemminx-osx-x86_64 $out/bin/lemminx
        ''
      else
        ''
          mkdir -p $out/bin
          cp lemminx-linux $out/bin/lemminx
        '';

    meta = with prev.lib; {
      homepage = "https://github.com/eclipse/lemminx";
      description = "XML Language server";
      longDescription = ''
        LemMinX is a XML language specific implementation of the Language Server Protocol and can be used
        with any editor that supports the protocol, to offer good support for the XML Language.
      '';
      license = prev.lib.licenses.epl20;
      maintainers = with maintainers; [ tshaynik ];
      platforms = platforms.linux ++ platforms.darwin;
    };
  };
}
