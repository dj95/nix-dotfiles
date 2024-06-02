final: prev: {
  gherkin-lint = prev.pkgs.buildNpmPackage rec {
    pname = "gherkin-lint";
    version = "4.2.4";

    src = final.pkgs.fetchFromGitHub {
      owner = "gherkin-lint";
      repo = "gherkin-lint";
      rev = "v${version}";
      sha256 = "sha256-6sifuZxFiUMtXbrqpNu9vKB+wbudpf6WO/moCxITNeQ=";
    };

    npmDepsHash = "sha256-ercFMWrxBYf6NRc2MFwRYxarcV3V57KJ/7PvqpJpH2M=";
  };
}
