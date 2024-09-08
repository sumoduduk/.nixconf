{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      bacon
      cargo
      rustc
      rustfmt
      clippy
    ];

    sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };
}
