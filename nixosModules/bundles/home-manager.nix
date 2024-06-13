{
  lib,
  config,
  inputs,
  outputs,
  myLib,
  pkgs,
  ...
}: let
  cfg = config.myNixOS;
in {
  options.myNixOS = {
    userName = lib.mkOption {
      default = "jh";
      description = ''
        username
      '';
    };

    userConfig = lib.mkOption {
      default = ./../../hosts/desktop/home.nix;
      description = ''
        home-manager config path
      '';
    };

    userNixosSettings = lib.mkOption {
      default = {};
      description = ''
        NixOS user settings
      '';
    };
  };

  config = {
    programs.bash.enable = true;

    programs.hyprland = {
      enable = cfg.sharedSettings.hyprland.enable;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    services.xserver = lib.mkIf cfg.sharedSettings.hyprland.enable {
      displayManager = {
        defaultSession = "hyprland";
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
        inherit myLib;
        outputs = inputs.self.outputs;
      };
      users = {
        ${cfg.userName} = {...}: {
          imports = [
            (import cfg.userConfig)
            outputs.homeManagerModules.default
          ];
        };
      };
    };

    users.users.${cfg.userName} =
      {
        isNormalUser = true;
        initialPassword = "12345";
        description = cfg.userName;
        shell = pkgs.bash;
        extraGroups = ["libvirtd" "networkmanager" "wheel"];
      }
      // cfg.userNixosSettings;
  };
}
