# nixdots

This repo now exposes a layered layout so common building blocks can be reused per host without copy/pasting whole files.

## Top-level

- `flake.nix` wires all inputs and defines a small `mkHost` helper so new hosts only need to describe their unique modules and Home Manager imports.
- `configuration.nix` simply imports the NixOS module tree under `modules/nixos`.
- `home.nix` in the same way imports the reusable Home Manager modules below `modules/home`.
- `hosts/` contains per-machine overrides plus their generated hardware profiles.

## Module tree

- `modules/nixos/core` holds boot, user, package, font, and global environment defaults.
- `modules/nixos/services` groups opt-in services such as audio, bluetooth, docker, and power tweaks.
- `modules/nixos/desktop` encapsulates display manager, GNOME, Wayland, and X11 settings.
- `modules/nixos/programs` pulls in application-level modules like Firefox, Steam, and GnuPG.
- `modules/home/core` keeps username, state version, and shared package/xdg options.
- `modules/home/programs` provides shell tooling, dev tooling, and optional extras (spicetify, etc.).
- `modules/home/desktop` contains GNOME- and Waybar-specific Home Manager tweaks, with additional per-WM modules imported only by the hosts that need them.

To add a new machine, drop its configuration into `hosts/<name>` and register it through `mkHost` inside `flake.nix`, composing the modules that make sense for that device.
