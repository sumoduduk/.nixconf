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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    #    pkgs.hello
    pkgs.ripgrep
    pkgs.nodejs_22
    pkgs.python3
    pkgs.zig
    pkgs.gcc
    pkgs.fzf
    pkgs.gnumake
    pkgs.hyprpaper
    pkgs.unzip
    pkgs.btop
    pkgs.bat
    pkgs.termscp
    pkgs.alejandra
    pkgs.wl-clipboard
    pkgs.luajitPackages.luarocks
    pkgs.papirus-icon-theme
    pkgs.noto-fonts
    pkgs.symbola
    pkgs.steam-run

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
  };

  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        cls = "clear";
        project = "cd ${homeDir}/File/projects";
        rustproject = "cd ${homeDir}/File/projects/rust_project";
        pythproject = "cd ${homeDir}/File/projects/python_project";
        webproject = "cd ${homeDir}/File/projects/js_project";
        vaultobsidian = "cd ${homeDir}/File/notes/obsidian_vault";
        nixconf = "cd ${homeDir}/.nixconf";
        getgit = "nvim ${homeDir}/File/projects/game";
        flakeupdate = "nixconf && sudo nix flake update";
        flakerebuild = "sudo nixos-rebuild switch --flake .";
        homerebuild = "home-manager switch --flake .";
        vimconf = "cd ${homeDir}/.config/nvim";
      };
      oh-my-zsh = {
        enable = true;
        theme = "dpoggi";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        font.size = 12;
        font.normal = {
          family = "FiraCodeNerdFontPropo";
          style = "Regular";
        };
        window = {
          opacity = 0.93;
          dynamic_padding = true;
          blur = true;
        };
        selection.save_to_clipboard = true;
        keyboard.bindings = [
          {
            key = "v";
            mods = "Control";
            action = "Paste";
          }
          {
            key = "t";
            mods = "Control";
            action = "CreateNewWindow";
          }
        ];
        colors = {
          selection = {
            text = "#11111B";
            background = "#F5E0DC";
          };
          cursor = {
            text = "#11111B";
            cursor = "#F5E0DC";
          };
          primary = {
            foreground = "#CDD6F4";
            background = "#212528";
          };
        };
      };
    };

    yazi = {
      enable = true;
    };

    lazygit = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
      vimdiffAlias = true;
      vimAlias = true;
      viAlias = true;
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
