{ pkgs, inputs, outputs, lib, ... }:

{
  imports = [ outputs.homeManagerModules.default ];
  home.username = "nh2";
  home.homeDirectory = lib.mkDefault "/home/nh2";

  myHomeManager = {
    bundles.general.enable = true;
    bundles.desktop.enable = true;
  };


  programs.git = {
    enable = true;
    userName = "Jeremy Hage";
    userEmail = "jeremy.hage@gmail.com";
    extraConfig = {
      init = {
	defaultBranch = "main";
      };
    };
  };




    programs.tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

  

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
