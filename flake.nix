{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs = {
    nixpkgs,
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
          ];
          env = {

          };
        };
      }
    );
}
