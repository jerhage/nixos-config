{...}: 
  {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Tomorrow Night",
      }
    ''; 
  };
}
