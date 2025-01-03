{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

  };

  outputs = { nixpkgs, home-manager, stylix, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.amethyst = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./devices/amethyst/configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              monitors = {
                hyprland = [
                  "DP-3, 2560x1440@144, 0x0, 1, vrr, 1"
                  "DP-2, 2560x1440@60, -2560x0, 1"
                ];
                mainHeight = 1440;
              };
            };

            home-manager.users.velkee = import ./home-manager/home.nix;
          }
        ];
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
