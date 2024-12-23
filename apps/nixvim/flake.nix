{
  description = "Kerem's Neovim Flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    { flake-parts
    , nixvim
    , ...
    } @ inputs:
    let
      config = import ./settings.nix;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];

      imports = [ inputs.treefmt-nix.flakeModule ];

      perSystem =
        { pkgs
        , system
        , self
        , ...
        }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nvim = nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module = config;
            extraSpecialArgs = { };
          };
          _module.args.pkgs = import self.inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (final: _prev: {
                master = import inputs.nixpkgs-master {
                  system = final.system;
                  config.allowUnfree = true;
                };
              })
              (final: _prev: {
                stable = import inputs.nixpkgs-stable {
                  system = final.system;
                  config.allowUnfree = true;
                };
              })
              (final: prev: {
                vimPlugins = prev.vimPlugins.extend (vfinal: vprev: {
                  git-worktree-nvim = vprev.git-worktree-nvim.overrideAttrs (oldAttrs: {
                    src = prev.fetchFromGitHub {
                      owner = "polarmutex";
                      repo = "git-worktree.nvim";
                      rev = "bac72c240b6bf1662296c31546c6dad89b4b7a3c";
                      hash = "sha256-Uvcihnc/+v4svCrAO2ds0XvNmqO801ILWu8sbh/znf4=";
                    };
                  });
                  neotest-zig = vprev.neotest-zig.overrideAttrs (oldAttrs: {
                    src = prev.fetchFromGitHub {
                      owner = "lawrence-laz";
                      repo = "neotest-zig";
                      rev = "b0e72626135b703fe186a062f38a47ac739f1cdd";
                      hash = "sha256-1HXIssBemCB7asQE6L7XiqGQC0gzwqIXhSollk2DV2o=";
                    };
                  });
                  zk-nvim = vprev.zk-nvim.overrideAttrs (oldAttrs: {
                    src = prev.fetchFromGitHub {
                      owner = "alisonjenkins";
                      repo = "zk-nvim";
                      rev = "c9a073cb16b3514cdce5e1a84c6996989e79630f";
                      hash = "sha256-WhiwPsABFISzOlZuZYR7W2D2q4pD6VGqjIyqcrO05rc=";
                    };
                  });
                });
              })
            ];
            config.allowUnfree = true;
          };

          checks = {
            default = nixvimLib.check.mkTestDerivationFromNvim {
              inherit nvim;
              name = "A nixvim configuration";
            };
          };

          packages = {
            default = nvim;
            nvim = nvim;
          };

          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixpkgs-fmt.enable = true;
          };

          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [
                just
                nix-fast-build
              ];
            };
          };
        };
    };
}
