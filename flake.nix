{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

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
  };

  outputs = inputs @ {
    home-manager,
    hyprland,
    lix-module,
    nixpkgs,
    nixvim,
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
    };

    formatter = forEachSupportedSystem ({pkgs}: pkgs.alejandra);
    devShells = forEachSupportedSystem ({pkgs}: {
      default = with pkgs;
        mkShell {
          buildInputs = [
            nixd
            alejandra
          ];

          shellHook = ''
            zsh
          '';
        };
    });
  };
}
