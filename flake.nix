{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
  };

  outputs = { ... }@inputs: let 
    myLib = import ./myLib/default.nix { inherit inputs; };
  in
    with myLib;  {
      nixosConfigurations = {
        desktop = mkSystem ./hosts/desktop/configuration.nix;
        nh2 = mkSystem ./hosts/nh2/configuration.nix;
      };

      homeConfigurations = {
        "jh@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;
        "nh2@nh" = mkHome "x86_64-linux" ./hosts/nh2/home.nix;
      }; 
      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
  };
     






#      nh = nixpkgs.lib.nixosSystem {
    #    system = "x86_64-linux";
    #    specialArgs = { inherit inputs; };
    #    modules = [
    #      ./hosts/vm1/configuration.nix
#	  ./nixosModules
#
#          # make home-manager as a module of nixos
#          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
#          home-manager.nixosModules.home-manager
#          {
#            home-manager.useGlobalPkgs = true;
#            home-manager.useUserPackages = true;
#
#            home-manager.users.nh = import ./hosts/vm1/home.nix;
#            home-manager.extraSpecialArgs = { inherit inputs; };
#
#            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
#          }
#        ];
#      };
#      nh2 = nixpkgs.lib.nixosSystem {
#        system = "x86_64-linux";
#        specialArgs = { inherit inputs; };
#        modules = [
#          ./hosts/vm2/configuration.nix
#	  ./nixosModules
#
#          # make home-manager as a module of nixos
#          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
#          home-manager.nixosModules.home-manager
#          {
#            home-manager.useGlobalPkgs = true;
#            home-manager.useUserPackages = true;
#
#            home-manager.users.nh2 = import ./hosts/vm2/home.nix;
#            home-manager.extraSpecialArgs = { inherit inputs; };
#
#            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
#          }
#        ];
#      };
#    };
#  };
 # outputs = { self, nixpkgs, ... }@inputs: {
 #   # The host with the hostname `nh` will use this configuration
 #   nixosConfigurations.nh = nixpkgs.lib.nixosSystem {
 #     system = "x86_64-linux";
 #     # specialArgs = { inherit inputs; };
 #     modules = [
 #       ./configuration.nix
 #        {
 #       # Set all inputs parameters as special arguments for all submodules        
 #       # so you can directly use all dependencies in inputs in submodules
 #       # Functionally equivalent to specialArgs = { inherit inputs; };
 #         _module.args = { inherit inputs; };
 #        }
 #     ];
 #   };
 # };
}
