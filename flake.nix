{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };
  inputs.hf-nix.url = "github:huggingface/hf-nix";
  #inputs.nixpkgs.follows = "hf-nix/nixpkgs";

  outputs = {
    nixpkgs,
    hf-nix,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            python313
            python313Packages.pip
            python313Packages.virtualenv
            python313Packages.pynvim
            python313Packages.jupyter-client
            python313Packages.notebook
            python313Packages.cairosvg
            python313Packages.pillow
            python313Packages.ipykernel
            python313Packages.pyperclip
            python313Packages.scikit-image
            python313Packages.nbformat
            python313Packages.jupytext
            python313Packages.opencv-python
            python313Packages.google
            rustc
            cargo
            pkg-config
  git
  git-lfs
          ];
          env = {
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
              pkgs.stdenv.cc.cc
              pkgs.zstd
              # Add any missing library needed
              # You can use the nix-index package to locate them, e.g. nix-locate -w --top-level --at-root /lib/libudev.so.1
            ];
            AM_I_DOCKER = false;
            BUILD_WITH_CUDA = true;
            PYO3_USE_ABI3_FORWARD_COMPATIBILITY = 1;
            TOKENIZERS_USE_RUSTUP = 0;
            RUSTUP_TOOLCHAIN = "stable";

            HF_HUB_ETAG_TIMEOUT = 120;
            HF_HUB_DOWNLOAD_TIMEOUT = 600;
            HF_HUB_DISABLE_TELEMETRY = 1;
          };
        };
      }
    );
}
