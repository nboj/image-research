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
            python312
            python312Packages.pip
            python312Packages.virtualenv
            python312Packages.pynvim
            python312Packages.jupyter-client
            python312Packages.cairosvg
            python312Packages.pillow
            python312Packages.ipykernel
            python312Packages.pyperclip
            python312Packages.scikit-image
            python312Packages.nbformat
            python312Packages.jupytext
            python312Packages.opencv-python
            python312Packages.google
            rustc
            cargo
            pkg-config
            git
            git-lfs
            pkgs.rocmPackages.rocm-comgr
            pkgs.rocmPackages.rpp
            pkgs.rocmPackages.clr
            pkgs.rocmPackages.hipcc
            pkgs.rocmPackages.rocm-smi
              pkgs.rocmPackages.rocprofiler
pkgs.rocmPackages.rocprofiler-register 
pkgs.rocmPackages.rccl
          ];
          env = {
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
              pkgs.stdenv.cc.cc
              pkgs.zstd
              # ROCm/HIP runtime libs (includes libamdhip64.so.7)
              pkgs.rocmPackages.rocm-runtime
              pkgs.rocmPackages.clr
              pkgs.rocmPackages.rocm-core
              pkgs.rocmPackages.rocminfo
              pkgs.rocmPackages.rpp
              pkgs.rocmPackages.hipcc
              pkgs.rocmPackages.rocm-smi
              pkgs.rocmPackages.rocm-comgr
              pkgs.rocmPackages.rocprofiler
pkgs.rocmPackages.rocprofiler-register 
pkgs.rocmPackages.rccl
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
