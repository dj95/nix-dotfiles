final: prev: {
  kubectx = prev.pkgs.buildGoModule {
    pname = "kubectx";
    version = "0.9.5";

    goPackage = "github.com/ahmetb/kubectx";

    src = prev.pkgs.fetchFromGitHub {
      owner = "ahmetb";
      repo = "kubectx";
      rev = "92e5b5f43b94b06bc38b0fbde1ee51e00079c39c";
      sha256 = "sha256-HVmtUhdMjbkyMpTgbsr5Mm286F9Q7zbc5rOxi7OBZEg=";
    };

    vendorHash = "sha256-3xetjviMuH+Nev12DB2WN2Wnmw1biIDAckUSGVRHQwM=";

    nativeBuildInputs = [ prev.pkgs.installShellFiles ];

    postInstall = ''
      installShellCompletion completion/*
    '';
  };
}
