{
    description = "libhax11";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.05";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }: 
        flake-utils.lib.eachDefaultSystem (system : let 
            pkgs = import nixpkgs { inherit system; };
        in {
            packages = {
                default = pkgs.stdenv.mkDerivation {
                    name = "libhax11";
                    src = ./.;

                    nativeBuildInputs = with pkgs; [
                      gcc
                    ];

                    buildInputs = with pkgs; [
                    glibc
                    glibc_multi
                    gcc_multi
                    xorg.gccmakedep
                    xorg.xorgproto
                    xorg.libXxf86vm
                    xorg.libX11
                    xorg.libXi
                    xorg.libXrandr
                    xorg.libXxf86vm
                    ];
                };
            };
        }
        );
}
