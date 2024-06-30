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
    ];

    sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };
}
