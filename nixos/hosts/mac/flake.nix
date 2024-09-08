# flake.nix skeleton:

{
  description = "MacOS Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin }: {
    packages."aarch64-darwin".default =
      # let pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      let
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
      in pkgs.buildEnv {
        name = "home-packages";
        paths = with pkgs; [
          # general tools
          git
          gh
		  glab
          neovim
          vim
          tmux
          zellij
          ranger
          lazygit
          lazydocker
          delta
          neofetch
          starship
          nerdfonts
          # langs
          go
          golangci-lint
		  air # go live reload
		  # go-swag
          python311
          python311Packages.pip
		  pipx
		  poetry
          nodejs_18
          elixir_1_15
          elixir-ls
          ocaml
          opam
          ocamlPackages.findlib
          ocamlformat
          kotlin
          kotlin-native
          kotlin-language-server
          ktlint
          spring-boot-cli
          # dotnet-sdk_7
          # dotnet-runtime_7
          # dotnet-aspnetcore_7
          # grpc-tools
          grpcurl
		  evans
          grpcui
          # protobuf3_20
          # nodePackages.eas-cli
          nodePackages.tailwindcss
          nodePackages.pnpm
          nodePackages_latest.eslint
          bun # <--- use latest
          yarn
          gcc
          rustup
          # rust-analyzer
          sqlx-cli
          lua
          luajitPackages.luacheck
          stylua
          openjdk17
		  yaml-language-server
		  dockerfile-language-server-nodejs
		  nixpkgs-fmt
		  nil
          #utils
          lsof
          gum
          glow
          eza
          zoxide
          fzf
          fd
          ctags
          gnused
          ripgrep
          nixfmt-classic
          deadnix
          checkmake
          shellcheck
          sqlfluff
          dotenv-linter
          unzip
          fselect
          sioyek
          nixos-generators
          # etcher
          # wrk2
          bat
          btop
          htop
          # nvitop
          # python310Packages.gpustat
          python311Packages.pyspark
          sqlite
          # neofetch
          inxi
          timg
          # appeditor
          git-ignore
          #cli
          marp-cli
          # aws-sam-cli
          awscli2
          aws-iam-authenticator
          # terraform
          # terraform-ls
          # terraform-docs
          # k6
          pkg-config
          wget
          # urlview
          mqttui
          jq
          yq
          fx
          cloc
          fish
          fishPlugins.done
          fishPlugins.fzf-fish
          # Fancy Eye Candy
          pipes-rs
          cbonsai
          cmatrix
          # tools
          # spark
          docker
          # k3s
          ktunnel
          # apache-airflow
          airlift # local airflow with containers
          datree
          kind # local docker clusters
          kubectl
          kubectx
          k9s
          kubernetes-helm
          # minikube
          #github-desktop
          gnumake
		  putty
		  
		  # mongodb
		  mongosh
		  # mongodb-compass
		  # postgresql_16
		  pgcli
		  pgadmin4
		  kafkactl
        ];
      };
  };

  # prograns.fish.enable = true;
  # programs.java.enable = true;
}
