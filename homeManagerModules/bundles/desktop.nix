{ pkgs, lib, ... }: {
  myHomeManager.starship.enable = lib.mkDefault true;
  myHomeManager.jq.enable = true;
  myHomeManager.wezterm.enable = true;
  myHomeManager.bash.enable = true;
  myHomeManager.firefox.enable = true;
  myHomeManager.bat.enable = true;
  myHomeManager.alacritty.enable = true;
  #myHomeManager.hyprland.enable = lib.mkDefault true;

  home.packages = with pkgs; [
    youtube-music
    mpv
    sway
     hyprpaper
     kitty
     libnotify
     mako
     qt5.qtwayland
     qt6.qtwayland
     swayidle
     swaylock-effects
     wlogout
     wl-clipboard
     wofi
     waybar
  ];
}
