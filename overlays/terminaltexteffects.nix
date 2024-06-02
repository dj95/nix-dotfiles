final: prev: {
  terminaltexteffects = prev.pkgs.python3Packages.buildPythonPackage rec {
    version = "0.10.0";
    pname = "terminaltexteffects";
    pyproject = true;

    src = prev.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-8Ds64OCUs9ZB2XJQd5YCSt1/vf0+tK9lMhWv7HghPGs=";
    };

    dependencies = [ prev.pkgs.python3Packages.poetry-core ];
  };
}
