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

      # Taking all modules in ./features and adding enables to them
  programs =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./programs);

in {
    imports = [ 
    ./services/virtualization.nix
    inputs.home-manager.nixosModules.home-manager
    ]
    ++ programs
    ++ bundles;

    options.myNixOS = {
      sharedSettings = {
        hyprland = {
          enable = lib.mkEnableOption "enable hyprland";
	  default = true;
	};
      };
    };

    config = {
      nix.settings.experimental-features = ["nix-command" "flakes"];
      # programs.nix-ld.enable = true;
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate = (pkg: true);
    };
}
