{
  config,
  pkgs,
  ...
}: let
  homeDir = "/home/calista";
in {
  imports = [
    ./host
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home.username = "calista";
  home.homeDirectory = homeDir;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    #    pkgs.hello
    ripgrep
    nodejs_22
    python3
    zig
    gcc
    fzf
    gnumake
    hyprpaper
    unzip
    btop
    bat
    termscp
    alejandra
    wl-clipboard
    luajitPackages.luarocks
    papirus-icon-theme
    noto-fonts
    atac
    termscp
    pkg-config
    openssl
    geeqie
    hyprshot
    rofi
    bun
    bat
    wlogout

    #    pkgs.symbola
    #    pkgs.steam-run

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override {fonts = ["FiraCode" "DejaVuSansMono" "UbuntuMono"];})

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/calista/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    SSH_ASKPASS = "";
    RUST_PROJECT = "${homeDir}/File/projects/rust_project";
    VAULT_OBSIDIAN = "${homeDir}/File/notes/obsidian_vault";
    ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
    TIMER_FORMAT = "[%d]";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  programs = {
    yazi = {
      enable = true;
    };
    lazygit = {
      enable = true;
    };
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${homeDir}/Pictures/neon-lights-dark.jpg"
        ];
        wallpaper = [
          ",${homeDir}/Pictures/neon-lights-dark.jpg"
        ];
        splash = false;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
