{
  pkgs,
  system,
  inputs,
  config,
  lib,
  myLib,
  ...
}: let
  cfg = config.myHomeManager;

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (myLib.filesIn ./bundles);
in {
  imports = [ 
    # ./nh.nix
    ./jq.nix
    ./alacritty.nix
    ./fd.nix
  ] ++ bundles;
}

