{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # niri = {
    #   url = "github:sodiboo/niri-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # dgop = {
    #     url = "github:AvengeMedia/dgop";
    #     inputs.nixpkgs.follows = "nixpkgs";
    #   };

    #   dankMaterialShell = {
    #     url = "github:AvengeMedia/DankMaterialShell";
    #     inputs.nixpkgs.follows = "nixpkgs";
    #     inputs.dgop.follows = "dgop";
    #   };
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # Please replace my-nixos with your hostname
      nixosConfigurations.nixy-zangetsu = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          #inputs.niri.nixosModules.niri
          #inputs.dankMaterialShell.nixosModules.dankMaterialShell
          #inputs.dankMaterialShell.nixosModules.greeter
          # inputs.dankMaterialShell.nixosModules.dankMaterialShell.default
          # inputs.dankMaterialShell.nixosModules.dankMaterialShell.niri

          {
            nixpkgs.overlays = [
              (final: prev: {
                tuir = prev.tuir.overrideAttrs (_old: {
                  doCheck = false;
                });
                qtile = prev.python3Packages.qtile.overrideAttrs (_old: {
                  doCheck = false;
                });
                qtile-unwrapped = prev.qtile-unwrapped.overrideAttrs (_old: {
                  doCheck = false;
                });
              })
            ];
          }

          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./configuration.nix
        ];
      };
    };
}
