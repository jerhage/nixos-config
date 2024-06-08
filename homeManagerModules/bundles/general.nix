{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {

  nixpkgs = {
    config = {
      allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };


  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nil
    nixd
    pistol
    file
    p7zip
    unzip
    zip
    stow
    neovim

    fzf
    eza
    fd
    zoxide
    bat
    ripgrep
    neofetch
    tree-sitter

    nh
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixconf";
  };
}
