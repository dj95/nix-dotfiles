final: prev: {
  frizbee = prev.pkgs.buildGoModule rec {
    pname = "frizbee";
    version = "0.0.19";

    goPackage = "github.com/stacklok/frizbee";

    src = prev.pkgs.fetchFromGitHub {
      owner = "stacklok";
      repo = "frizbee";
      rev = "v${version}";
      sha256 = "sha256-oA7Z8MB3Jq+K5VIOEQL07u1u5lEoQF4FdPXbsxV8ASo=";
    };

    doCheck = false;

    vendorHash = "sha256-6hI2dh9Tk2dnIHxuWOMjLXMRNYsewYKc/atQx0NFah4=";

    # nativeBuildInputs = [ prev.pkgs.installShellFiles ];

    # postInstall = ''
    #   installShellCompletion completion/*
    # '';
  };
}
