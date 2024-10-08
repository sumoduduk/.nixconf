{
  pkgs,
  nvim-config,
  ...
}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    #   p.bash
    #   p.comment
    #   p.css
    #   p.dockerfile
    #   p.gitattributes
    #   p.gitignore
    #   p.go
    #   p.gomod
    #   p.gowork
    #   p.javascript
    #   p.jq
    #   p.json5
    #   p.json
    #   p.lua
    #   p.make
    #   p.markdown
    #   p.markdown_inline
    #   p.nix
    #   p.python
    #   p.rust
    #   p.toml
    #   p.typescript
    #   p.tsx
    #   p.html
    #   p.graphql
    #   p.vim
    #   p.yaml
    p.swift
  ]);

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in {
  home.packages = with pkgs; [
    lua-language-server
    rust-analyzer-unwrapped
    black
    isort
    tailwindcss-language-server
    nodePackages.typescript-language-server
    nodePackages.prettier
    pylint
    pyright
    stylua
    swift-format
    typescript
    nil
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc.enable = false;
    withNodeJs = true;
    withPython3 = true;
    vimdiffAlias = true;
    vimAlias = true;
    viAlias = true;

    plugins = [
      treesitterWithGrammars
    ];
  };

  home.file."./.config/nvim/" = {
    source = nvim-config;
    recursive = true;
  };

  # linking mason

  home.file."./.local/share/nvim/mason/bin/typescript-language-server" = {
    source = pkgs.nodePackages.typescript-language-server;
  };

  home.file."./.local/share/nvim/mason/bin/black" = {
    source = pkgs.black;
  };

  home.file."./.local/share/nvim/mason/bin/isort" = {
    source = pkgs.isort;
  };

  home.file."./.local/share/nvim/mason/bin/stylua" = {
    source = pkgs.stylua;
  };

  home.file."./.local/share/nvim/mason/bin/swift-format" = {
    source = pkgs.swift-format;
  };

  home.file."./.config/nvim/lua/calista/core/init.lua" = {
    text =
      (builtins.readFile "${nvim-config}/lua/calista/core/init.lua")
      + ''
        vim.opt.runtimepath:append("${treesitter-parsers}")
          })
      '';
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config

  home.file."./.local/share/nvim/lazy/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}
