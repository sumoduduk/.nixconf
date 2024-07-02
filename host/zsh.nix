{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      cls = "clear";
      project = "cd $HOME/File/projects";
      rustproject = "cd $RUST_PROJECT";
      pythproject = "cd $HOME/File/projects/python_project";
      webproject = "cd $HOME/File/projects/js_project";
      vaultobsidian = "cd $VAULT_OBSIDIAN";
      nixconf = "cd $HOME/.nixconf";
      getgit = "nvim $HOME/File/projects/game";
      flakeupdate = "nixconf && sudo nix flake update";
      flakerebuild = "sudo nixos-rebuild switch --flake .";
      homerebuild = "home-manager switch --flake .  --show-trace";
      vimconf = "cd $HOME/File/nvim";
      syncobsidian = "$RUST_PROJECT/tools-rust/obsidian_github_sync/result/bin/obsidian-github-sync $VAULT_OBSIDIAN";
    };
    oh-my-zsh = {
      enable = true;
      theme = "dpoggi";
    };
  };
}
