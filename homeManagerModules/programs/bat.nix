{ inputs, ...}:{
  programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-mocha";
      };
      themes = {
        # https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
        catppuccin-mocha = {
          src = inputs.catppuccin-bat;
          file = "./themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
}
