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

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dolphin-overlay.url = "github:rumboon/dolphin-overlay";
  };

  outputs = inputs @ {
    dolphin-overlay,
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
        inherit system specialArgs pkgs;

        modules = [
          ./hosts/${hostname}
          home-manager.nixosModules.home-manager
          lix-module.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;

              users.${username} = {
                home = {
                  inherit username stateVersion;
                  homeDirectory = "/home/${username}";
                };

                imports = [
                  ./home/${username}
                ];
              };
            };

            nixpkgs.overlays = [dolphin-overlay.overlays.default];
            system.stateVersion = stateVersion;
          }
        ];
      };
  in {
    nixosConfigurations = {
      amethyst = mkSystem {
        hostname = "amethyst";
        stateVersion = "24.05";
      };
      hephaestus = mkSystem {
        hostname = "hephaestus";
        stateVersion = "24.11";
      };
    };

    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        alejandra
      ];
    };
  };
}
