{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {

  imports = [inputs.nur.hmModules.nur];
  nixpkgs = {
    config = {
      allowUnfreePredicate = (pkgs) true;
      experimental-features = "nix-command flakes";
    };
  };

  #programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop  # replacement of htop/nmon
    ethtool
    nil
    nixd
    pistol
    file
    xz
    p7zip
    unzip
    zip
    stow
    neovim
    glow # markdown previewer in terminal

    ripgrep
    yq-go
    eza
    fzf
    fd
    
    qemu
    virt-manager
    bridge-utils

    zoxide
    bat
    neofetch
    tree-sitter

    nh
    nix-output-monitor
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixconf";
  };
}
