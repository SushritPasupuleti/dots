# nixos/

Nix configuration for all my machines: two real NixOS boxes and one macOS
laptop. Started NixOS-only, macOS was bolted on later, hence the slightly
odd shape.

> `hosts/darwin/` is a parked nix-darwin + home-manager experiment. It's not
> wired into anything below and can be ignored.

## Layout

```
nixos/
├── common.nix                    # NixOS module: shared services/config + package list
├── modules/
│   ├── shared-packages.nix       # packages installed on every host (any OS)
│   ├── linux-packages.nix        # extra packages, NixOS hosts only
│   └── darwin-packages.nix       # extra packages, macOS only
└── hosts/
    ├── nixy-zangetsu/            # real NixOS desktop (x86_64-linux, nvidia)
    ├── nixy-shinso/              # real NixOS box (minimal, no flake yet)
    ├── mac/                      # active macOS config (plain nix profile, no nix-darwin)
    └── darwin/                  # ignore -- unused nix-darwin experiment
```

## The shared module pattern

`modules/*.nix` are plain functions that return a package list -- they don't
depend on the NixOS module system, so the same file can be `import`ed from a
real NixOS module (`common.nix`) *or* spliced into a bare `pkgs.buildEnv`
list (`hosts/mac/flake.nix`). That's what makes sharing possible even though
the mac host isn't using nix-darwin/home-manager.

- `shared-packages.nix { pkgs, unstable ? pkgs }` -- CLI tools, language
  toolchains, k8s tools etc. wanted on literally every host.
- `linux-packages.nix { pkgs, unstable ? pkgs }` -- NixOS-only extras: GNOME,
  Hyprland, GUI apps that come from nix instead of a system package manager,
  and other Linux-only tooling.
- `darwin-packages.nix { pkgs }` -- macOS-only extras.

A few packages in `shared-packages.nix` are written as `unstable.foo` (e.g.
`unstable.lazygit`). `unstable` defaults to `pkgs` in the function signature,
so:

- On NixOS hosts, which pass a real nixpkgs-unstable input as `unstable`,
  those packages get pulled from the unstable channel.
- On the mac host, which has no unstable input, `unstable.foo` just resolves
  to `pkgs.foo` (stable).

Only non-OS-specific *packages* are shared this way. Non-package config
(`environment.sessionVariables`, `fonts.packages`, `programs.fish.enable`,
`services.*`, ...) stays in `common.nix` and isn't shared with mac, because
`hosts/mac/flake.nix` has no module system to receive it -- it's a bare
`pkgs.buildEnv`, not a NixOS/home-manager config. If that ever needs to
change, look at reviving `hosts/darwin/` (nix-darwin + home-manager) instead
of bolting config options onto the buildEnv approach.

## Adding or updating a package

1. Decide scope:
   - Wanted everywhere → `modules/shared-packages.nix`.
   - NixOS/Linux only → `modules/linux-packages.nix`.
   - macOS only → `modules/darwin-packages.nix`.
   - One specific host only (e.g. nvidia driver tweaks) → that host's
     `configuration.nix` directly, not a shared module.
2. Add the attribute name to the relevant list (alphabetical, one per line).
   Use `pkgs.foo` implicitly (the files already open `with pkgs;`), or
   `unstable.foo` for the shared list if you want it pinned to the unstable
   channel on hosts that provide one.
3. Sanity-check before applying anywhere:
   ```bash
   # from the repo root
   nix-instantiate --parse nixos/modules/shared-packages.nix   # syntax only

   # actually resolve the attribute names against real nixpkgs (slower, needs network
   # the first time). Use a bare path -- NOT `path:...` -- so Nix picks up the
   # whole git working tree and relative imports (../../modules/...) resolve.
   nix build "$(pwd)/nixos/hosts/mac#default" --dry-run
   nix eval  "$(pwd)/nixos/hosts/nixy-zangetsu#nixosConfigurations.nixy-zangetsu.config.system.build.toplevel.name"
   ```
   A typo'd attribute name shows up immediately as an "attribute missing"
   eval error rather than surviving until `nixos-rebuild`/`nix profile install`
   on the actual machine.
4. Apply on the relevant host(s) per the setup instructions below.

> Nix flakes refuse to `import` a relative path (`../../modules/...`) that
> escapes whatever directory it thinks is the flake's root, *unless* it can
> tell that directory is part of a git working tree, in which case it uses
> the whole repo. Always invoke `nix build` / `nix profile install` with a
> bare path (or from inside the repo with `.`), never the explicit `path:`
> URI scheme, or the shared-module imports will fail to resolve.

## Setup / usage per environment

### macOS (`hosts/mac/`)

This is a plain `pkgs.buildEnv` profile installed via `nix profile`, not
nix-darwin. It must be built straight out of a checkout of this repo (see
note above about relative imports), so don't copy `flake.nix` elsewhere.

```bash
# from the repo root
./nix-mac-setup.sh          # just prints the install/upgrade commands below

nix profile install "$(pwd)/nixos/hosts/mac"   # first install
nix profile upgrade 0                          # after pulling changes / editing packages
```

GUI apps (browsers, editors, etc.) aren't part of this profile on purpose --
those come from Homebrew on macOS. Only `darwin-packages.nix` +
`shared-packages.nix` end up installed.

### NixOS -- nixy-zangetsu

Desktop with GNOME + Hyprland + nvidia, fully on `common.nix` +
`modules/{shared,linux}-packages.nix`.

```bash
cd nixos/hosts/nixy-zangetsu   # setup.sh assumes it's run from here
sudo ./setup.sh                # backs up + symlinks configuration.nix,
                                # hardware-configuration.nix, common.nix and
                                # flake.nix into /etc/nixos
sudo nixos-rebuild switch
```

Re-run `sudo nixos-rebuild switch` any time after editing
`configuration.nix`, `common.nix`, or the shared modules -- no need to
re-run `setup.sh` again (it only needs to run once to set up the symlinks).

### NixOS -- nixy-shinso

Minimal host, currently **not** wired up to `common.nix` or the shared
modules -- its `configuration.nix` only imports `./hardware-configuration.nix`
and keeps its own small inline package list. If you want it to pick up the
shared packages, add `../../common.nix` (or directly the two
`modules/*-packages.nix` imports) to its `imports` list.

```bash
# from the repo root -- unlike nixy-zangetsu's setup.sh, this one expects
# to be run from the repo root, not from inside hosts/nixy-shinso/
sudo ./nixos/hosts/nixy-shinso/setup.sh
sudo nixos-rebuild switch
```

## Adding a new host

1. `mkdir nixos/hosts/<name>`, add a `configuration.nix` that imports
   `../../common.nix` (for a NixOS host) and its own `hardware-configuration.nix`.
2. Give it its own `flake.nix` (copy `hosts/nixy-zangetsu/flake.nix` as a
   template) with its own `nixosConfigurations.<name>`.
3. Write a `setup.sh` that symlinks its files into `/etc/nixos` -- copy
   `hosts/nixy-zangetsu/setup.sh` and adjust the hostname/paths. Note the two
   existing hosts disagree on whether `setup.sh` expects to be run from the
   repo root or from inside the host's own directory -- pick one and be
   consistent, or just always `cd` into the host directory first.
4. Only put host-unique packages/config directly in its `configuration.nix`;
   anything more broadly useful belongs in `modules/shared-packages.nix` or
   `modules/linux-packages.nix`.
