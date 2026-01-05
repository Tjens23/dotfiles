{
  description = "NixOS for uni";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nix-alien.url = "github:thiagokokada/nix-alien";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-alien, ... }: {
    nixosConfigurations.sdu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.toby = import ./home.nix;
            extraSpecialArgs = { inherit nix-alien; };
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
