# nixdots

This repo uses a small shared base plus explicit per-host imports. Common modules should only contain settings that every active machine should inherit; desktops, gaming, media services, remote-access services, and other heavier choices are selected by each host.

## Top-level

- `flake.nix` wires all inputs and defines a small `mkHost` helper so hosts can describe their NixOS modules and Home Manager imports.
- `configuration.nix` imports only the shared NixOS base: core settings, baseline services, and baseline programs.
- `home.nix` imports only shared Home Manager core/program modules plus local scripts.
- `hosts/` contains per-machine overrides plus their generated hardware profiles.
- Active system outputs are `desktop`, `desktop-hyprland`, `L14`, and `L14-hyprland`.

## Module tree

- `modules/nixos/core` holds boot, user, package, font, and global environment defaults.
- `modules/nixos/services/default.nix` imports only baseline services such as audio, bluetooth, networking, passkeys, keyring, and power defaults.
- `modules/nixos/services` also contains host-selected services such as Flatpak, printing, SSH, Tailscale, Docker, desktop media, and GPU control.
- `modules/nixos/desktop` encapsulates display manager, GNOME, X11, and compositor setup, but hosts opt into it explicitly.
- `modules/nixos/desktop/niri.nix` uses the native NixOS `programs.niri` module from nixpkgs.
- `modules/nixos/desktop/hyprland.nix` is a separate Hyprland stack with its own portal setup.
- `modules/nixos/programs/default.nix` imports only baseline application modules like Firefox and GnuPG.
- `modules/nixos/programs` also contains host-selected modules such as Steam, OBS, and gaming session helpers.
- `modules/home/core` keeps username, state version, and shared package/xdg options.
- `modules/home/programs` provides shell tooling, dev tooling, and optional extras (spicetify, etc.).
- `modules/home/desktop` contains compositor-specific Home Manager config and is imported per output from `flake.nix`.
- DankMaterialShell (`dms`) is the shell for both Niri and Hyprland; Waybar and swaync are no longer part of the desktop setup.

To add a new machine, drop its configuration into `hosts/<name>` and register it through `mkHost` inside `flake.nix`, composing the modules that make sense for that device.
