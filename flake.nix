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

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "velkee";
      specialArgs = {
        inherit username;
        inherit inputs;
      };

      mkSystem =
        {
          hostname,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;

          modules = [
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;

                users.${username} = import ./home/amethyst.nix;
              };
            }
          ];
        };
    in
    {

      nixosConfigurations.amethyst = mkSystem {
        hostname = "amethyst";
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
