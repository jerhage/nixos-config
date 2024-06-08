{ config, pkgs, lib, inputs, outputs, myLib,... }: let
  cfg = config.myNixOS;
  
  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (myLib.filesIn ./bundles);

in {
    imports = [ 
    ./programs
    ./services/virtualization.nix
    inputs.home-manager.nixosModules.home-manager
    ]
    ++ bundles;

    options.myNixOS = {
      sharedSettings = {
        hyprland.enable = lib.mkEnableOption "enable hyprland";
      };
    };

    config = {
      nix.settings.experimental-features = ["nix-command" "flakes"];
      # programs.nix-ld.enable = true;
      nixpkgs.config.allowUnfree = true;
    };
}
