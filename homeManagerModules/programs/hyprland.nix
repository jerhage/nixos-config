{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
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
     libinput
    ];
}
