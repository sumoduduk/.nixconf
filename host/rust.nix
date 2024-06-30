{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      bacon
      cargo
      gcc
      rustc
      rustfmt
      rust-analyzer
      clippy
    ];

    sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };
}
