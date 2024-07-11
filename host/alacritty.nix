{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 12;
      font.normal = {
        family = "FiraCodeNerdFontPropo";
        style = "Regular";
      };
      window = {
        opacity = 0.78;
        dynamic_padding = true;
        padding = {
          x = 1;
          y = 2;
        };
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
      # env.term = "xterm-256color";
    };
  };
}
