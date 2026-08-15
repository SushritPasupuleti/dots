# Extra packages installed only on macOS hosts (on top of shared-packages.nix).
{ pkgs }:
with pkgs; [
  air
  asitop
  borgbackup
  dockerfile-language-server-nodejs
  elixir_1_15
  elixir-ls
  evans
  glab
  kafkactl
  mongosh
  neofetch
  nerdfonts
  nixpkgs-fmt
  nodejs_18
  nodePackages_latest.eslint
  nodePackages.tailwindcss
  pgadmin4
  pgcli
  pipx
  putty
  python311
  python311Packages.pip
  snyk
  yq
  zig
]
