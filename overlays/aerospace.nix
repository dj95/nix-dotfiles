final: prev: {
  aerospace = prev.aerospace.overrideAttrs (drv: rec {
    version = "0.15.2";
    pname = "aerospace";

    src = prev.fetchFromGitHub {
      owner = "raisjn";
      repo = "aerospace";
      rev = "442d9fb429e2a6f0a9322e5375970f68a03f9d69";
      hash = "sha256-CC9uRViq1I6m7tKvXyPfMn/bDVXymKe7EhvzVUzibTE=";
    };

    buildInputs = with prev.pkgs; [
      swift
    ];
  });
}
