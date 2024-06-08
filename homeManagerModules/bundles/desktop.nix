{ pkgs, lib, ... }: {
  myHomeManager.starship.enable = lib.mkDefault true;
  myHomeManager.jq.enable = true;
  myHomeManager.wezterm.enable = true;
  myHomeManager.bash.enable = true;
  myHomeManager.firefox.enable = true;
  myHomeManager.bat.enable = true;
  myHomeManager.alacritty.enable = true;

  home.packages = with pkgs; [
    youtube-music
    mpv
  ];
}
