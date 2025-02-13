{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    home-manager,
    lix-module,
    nixpkgs,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";
    username = "velkee";
    specialArgs = {
      inherit username;
      inherit inputs;
    };

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    mkSystem = {
      hostname,
      stateVersion,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        inherit pkgs;

        modules = [
          ./hosts
          ./hosts/${hostname}
          lix-module.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;

              users.${username} = {
                home = {
                  inherit stateVersion;
                  inherit username;
                  homeDirectory = "/home/${username}";
                };

                imports = [
                  ./home/${username}
                  ./home/${username}/${hostname}
                ];
              };
            };

            system.stateVersion = stateVersion;
          }
        ];
      };
  in {
    nixosConfigurations.amethyst = mkSystem {
      hostname = "amethyst";
      stateVersion = "24.05";
    };

    formatter.${system} = pkgs.alejandra;
  };
}
