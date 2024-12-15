{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    cargo
    clippy
    rustc
    rust-analyzer
    rustfmt
    libmysqlclient
    mysql-client
    diesel-cli
    cargo-generate
    cargo-nextest
    cargo-wasi
    cargo-watch
    wasmtime
    wabt # webassembly binary toolkit
  ];
}
