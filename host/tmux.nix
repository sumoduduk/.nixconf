{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "$TERM";

    # Rather than constraining window size to the maximum size of any client
    # connected to the *session*, constrain window size to the maximum size of any
    # client connected to *that window*. Much more reasonable.
    aggressiveResize = true;

    clock24 = true;

    # Allows for faster key repetition
    # escapeTime = 50;

    keyMode = "vi";
    # Overrides the hjkl and HJKL bindings for pane navigation and resizing in VI mode
    # customPaneNavigationAndResize = true;
    shortcut = "b";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      # gruvbox
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -ag terminal-overrides ",$TERM:Tc"
      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.tmux.conf

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r m resize-pane -Z


      bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
      bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

      unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode when dragging with mouse

      # remove delay for exiting insert mode with ESC in Neovim
      set -sg escape-time 10

      # auto window rename
      set -g automatic-rename
      set -g automatic-rename-format '#{pane_current_command}'

      set -g status-style bg=default
    '';
  };
}
