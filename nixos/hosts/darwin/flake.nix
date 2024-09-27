{
  description = "My Nix-Darwin configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
	nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
	home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
			pkgs.vim
			pkgs.git
			pkgs.fish
			pkgs.ripgrep
			pkgs.fd
			pkgs.tmux
			pkgs.delta
			pkgs.direnv
			pkgs.glow
			pkgs.htop
			pkgs.neofetch
			pkgs.starship
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      # Create /etc/zshrc that loads the nix-darwin environment.
      # programs.zsh.enable = true;  # default shell on catalina
      programs.fish.enable = true;
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.sushritp.home = "/Users/sushritp";
      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      system.defaults = {
        # dock.autohide = true;
        # dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        # finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "Probably running Production code in here. DnD";
        # screencapture.location = "~/Pictures/screenshots";
        # screensaver.askForPasswordDelay = 10;
      };

	  # Homebrew needs to be installed on its own!
      homebrew.enable = true;
	  # homebrew.casks = [ ];
	  # homebrew.brews = [ ];

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."ISIN-RLP-018" = nix-darwin.lib.darwinSystem {
	  system = "aarch64-darwin";
      modules = [ 
		configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sushritp = import ./home.nix;
        }		
	  ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."ISIN-RLP-018".pkgs;
  };
}
