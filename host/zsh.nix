{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      cls = "clear";
      project = "cd $HOME/File/projects";
      rustproject = "cd $RUST_PROJECT";
      pyproject = "cd $HOME/File/projects/python_project";
      webproject = "cd $HOME/File/projects/js_project";
      vaulobsidian = "cd $VAULT_OBSIDIAN";
      nixconf = "cd $HOME/.nixconf";
      getgit = "nvim $HOME/File/projects/game";
      flakeupdate = "nixconf && sudo nix flake update";
      flakerebuild = "sudo nixos-rebuild switch --flake .";
      homerebuild = "home-manager switch --flake .  --show-trace";
      vimconf = "cd $HOME/.nixconf/host/neovim/nvim";
      syncobsidian = "$RUST_PROJECT/tools-rust/obsidian_github_sync/result/bin/obsidian-github-sync $VAULT_OBSIDIAN";
    };
    oh-my-zsh = {
      enable = true;
      theme = "gianu";
      plugins = [
        "git"
        "rust"
        "timer"
      ];
    };
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode/zsh-vi-mode.plugins.zsh";
      }
    ];
  };
}
