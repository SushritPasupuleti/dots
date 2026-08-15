# flake.nix skeleton:

{
  description = "MacOS Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    television.url = "github:alexpasmantier/television";
  };

  outputs = { self, nixpkgs, darwin, television }: {
    packages."aarch64-darwin".default =
      # let pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      let
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
      in pkgs.buildEnv {
        name = "home-packages";
        paths =
          (import ../../modules/shared-packages.nix { inherit pkgs; })
          ++ (import ../../modules/darwin-packages.nix { inherit pkgs; })
          ++ [ television.packages."aarch64-darwin".default ];
      };
  };

  # prograns.fish.enable = true;
  # programs.java.enable = true;
}
