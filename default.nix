let
  nixos = import <nixpkgs/nixos> {
    configuration = { ... }: {
      imports = [
        ./sd-image.nix
      ];
    };
  };
in
nixos.config.system.build.sdImage // {
  inherit (nixos) pkgs system config;
}
