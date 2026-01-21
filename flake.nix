{
  description = "gd-tools for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # 1. Package 'rdricpp' separately (since it's not in nixpkgs)
        rdricpp = pkgs.stdenv.mkDerivation {
          pname = "rdricpp";
          version = "master";

          src = pkgs.fetchzip {
            url = "https://codeberg.org/xieamoe/rdricpp/archive/main.tar.gz";
            # STEP 1: Run 'nix build', get the real hash from the error, and replace it here:
            sha256 = "sha256-xEiEcz/XNIxgK2kiNCcuQi7RWQLqg7W3IFmbkJ4px9k="; 
          };

          nativeBuildInputs = [ pkgs.cmake ];
        };

        # 2. Package 'gd-tools'
        gd-tools = pkgs.stdenv.mkDerivation {
          pname = "gd-tools";
          version = "1.5";

          src = pkgs.fetchzip {
            url = "https://codeberg.org/hashirama/gd-tools/archive/main.tar.gz";
            sha256 = "sha256-2LwWxLNwg9GPZcz/k4rgvVUo181pKvAHhrLxYZH1O6M=";
          };

          nativeBuildInputs = with pkgs; [ cmake pkg-config ];
          
          # We provide all libraries here so CMake finds them
          buildInputs = with pkgs; [ 
            marisa 
            libcpr 
            nlohmann_json 
            rdricpp 
            openssl
            catch2_3
          ];

          # We force GUIX mode, which disables automatic downloading
          cmakeFlags = [ "-DGUIX=ON" ];
        };

      in
      {
        packages.default = gd-tools;
        
        # Optional: Development shell if you want to hack on it later
        devShells.default = pkgs.mkShell {
          inputsFrom = [ gd-tools ];
        };
      }
    );
}
