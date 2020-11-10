{
  description = "";
  inputs = {
    nixpkgs.url = https://github.com/NixOS/nixpkgs/archive/60330b60655b3fa3a18624bdd7069855bb37af99.tar.gz;
  };
  outputs = { nixpkgs, nix, self, ... }@inputs : {
    defaultPackage.x86_64-linux =
      let pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; }; in
      (pkgs.callPackage ./nixGL.nix {
        nvidiaVersion = "455.28";
        nvidiaVersionFile = null;
        nvidiaHash = "03ysf61qrb272yqkn7bhn9d65lcfhmqc2c0dbh5prp5f2ndlkqg4";
        enable32bits = true;
      }).nixGLIntel; #nixGLNvidia
     # nixpkgs.stdenv.mkDerivation {
     #   builsInputs = [];
     #   { ## Nvidia informations.
     #     # Version of the system kernel module. Let it to null to enable auto-detection.
     #     nvidiaVersion ? null,
     #     # Hash of the Nvidia driver .run file. null is fine, but fixing a value here
     #     # will be more reproducible and more efficient.
     #     nvidiaHash ? null,
     #     # Alternatively, you can pass a path that points to a nvidia version file
     #     # and let nixGL extract the version from it. That file must be a copy of
     #     # /proc/driver/nvidia/version. Nix doesn't like zero-sized files (see
     #     # https://github.com/NixOS/nix/issues/3539 ).
     #     nvidiaVersionFile ? null,
     #     # Enable 32 bits driver
     #     # This is one by default, you can switch it to off if you want to reduce a
     #     # bit the size of nixGL closure.
     #     enable32bits ? true,
     #     # Make sure to enable config.allowUnfree to the instance of nixpkgs to be
     #     # able to access the nvidia drivers.
     #     pkgs ? import <nixpkgs> {
     #       config = { allowUnfree = true; };
     #     }
     #   }:
     #   pkgs.callPackage ./nixGL.nix {
     #     inherit
     #       nvidiaVersion
     #       nvidiaVersionFile
     #       nvidiaHash
     #       enable32bits
     #     ;
     #   };
     # };
  };
}
