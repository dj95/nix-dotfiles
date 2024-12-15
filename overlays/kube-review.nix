final: prev: {
  kube-review = prev.pkgs.buildGoModule rec {
    pname = "kube-review";
    version = "0.3.0";

    goPackage = "github.com/anderseknert/kube-review";

    src = prev.pkgs.fetchFromGitHub {
      owner = "anderseknert";
      repo = "${pname}";
      rev = "v${version}";
      sha256 = "sha256-DueH+aFXgU1y9hCvepn4km+ZxayGwXCf1ytLhLeSzz0=";
    };

    vendorHash = "sha256-L84xfUkLBgYzhOj/jFSOSmYzS86W5ruV+yE50XY0E2Q=";
  };
}
