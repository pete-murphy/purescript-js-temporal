{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    purescript-overlay.url = "github:thomashoneyman/purescript-overlay";
    purescript-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    purescript-overlay,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [purescript-overlay.overlays.default];
      pkgs = import nixpkgs {inherit system overlays;};
      scripts = pkgs.symlinkJoin {
        name = "scripts";
        paths = pkgs.lib.mapAttrsToList pkgs.writeShellScriptBin {
          run-install = ''
            spago install
          '';

          run-test = ''
            spago test
          '';

          run-check-format = ''
            purs-tidy check src test
          '';

          run-docs = ''
            spago docs -f html
          '';
        };
      };
      nodeWithTemporal =
        pkgs.runCommand "nodejs-temporal" {
          buildInputs = [pkgs.makeWrapper];
        } ''
          mkdir -p $out/bin
          for prog in ${pkgs.nodejs}/bin/*; do
            name=$(basename $prog)
            if [ "$name" = "node" ]; then
              makeWrapper $prog $out/bin/node --add-flags "--harmony-temporal"
            else
              ln -s $prog $out/bin/$name
            fi
          done
        '';
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          scripts

          # PureScript tools
          purs
          purs-tidy
          purs-backend-es
          spago
          # Node (wrapped to enable Temporal API)
          nodeWithTemporal
          # Nix
          alejandra
          # Scripting
          just
        ];
      };

      checks = {
        format =
          pkgs.runCommand "check-format"
          {
            buildInputs = with pkgs; [
              alejandra
            ];
          } ''
            ${pkgs.alejandra}/bin/alejandra --check ${./.}
            touch $out
          '';
      };
    });
}
