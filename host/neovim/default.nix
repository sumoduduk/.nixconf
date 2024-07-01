{pkgs, ...}: let
  nvimPath = "/home/calista/File/nvim";
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.markdown_inline
    p.nix
    p.python
    p.rust
    p.toml
    p.typescript
    p.tsx
    p.html
    p.graphql
    p.vim
    p.yaml
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
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
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
    source = nvimPath;
    recursive = true;
  };

  home.file."./.config/nvim/lua/calista/core/init.lua" = {
    text =
      (builtins.readFile "${nvimPath}/lua/calista/core/init.lua")
      + ''
        vim.opt.runtimepath:append("${treesitter-parsers}")
      '';
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/lazy/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}
