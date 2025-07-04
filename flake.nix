{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix";

    satellite = {
      url = "github:Supreeeme/xwayland-satellite?ref=v0.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    home-manager,
    lix-module,
    nixpkgs,
    nixvim,
    satellite,
    stylix,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
    ];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (
        system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
              };
            };
          }
      );
  in {
    nixosConfigurations = {
      "amethyst" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/amethyst/configuration.nix
          lix-module.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };
      "hephaestus" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/hephaestus/configuration.nix
          lix-module.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };
      "artemis" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/artemis/configuration.nix
            lix-module.nixosModules.default
            stylix.nixosModules.stylix
          ];
        };
    };

    formatter = forEachSupportedSystem ({pkgs}: pkgs.alejandra);
    devShells = forEachSupportedSystem ({pkgs}: {
      default = with pkgs;
        mkShell {
          buildInputs = [
            nil
            alejandra
          ];

          shellHook = ''
            fish
          '';
        };
    });
  };
}
