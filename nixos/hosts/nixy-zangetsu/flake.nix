{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

	niri = {
	  url = "github:sodiboo/niri-flake";
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixy-zangetsu = nixpkgs.lib.nixosSystem {
      modules = [
		inputs.niri.nixosModules.niri
		inputs.dankMaterialShell.nixosModules.dankMaterialShell
		inputs.dankMaterialShell.nixosModules.greeter
		# inputs.dankMaterialShell.nixosModules.dankMaterialShell.default
		# inputs.dankMaterialShell.nixosModules.dankMaterialShell.niri

        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
      ];
    };
  };
}
