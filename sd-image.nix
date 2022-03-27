{ pkgs, config, lib, ... }:

{
  nixpkgs.crossSystem = lib.systems.elaborate lib.systems.examples.raspberryPi;

  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix>
    ./minification.nix
    ./wifi.nix
  ];

  # prevent `modprobe: FATAL: Module ahci not found`
  boot.initrd.availableKernelModules = pkgs.lib.mkForce [
    "mmc_block"
  ];

  environment.systemPackages = with pkgs; [
    libraspberrypi
    libgpiod gpio-utils
    i2c-tools
    screen
    vim
    git
    bottom
    (python39.withPackages(ps: with ps;[
      adafruit-pureio
    ]))
  ];

  # needed for wlan0 to work (https://github.com/NixOS/nixpkgs/issues/115652)
  hardware.enableRedistributableFirmware = pkgs.lib.mkForce false;
  hardware.firmware = with pkgs; [
    raspberrypiWirelessFirmware
  ];

  networking.wireless.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };

  users = {
    extraGroups = {
      gpio = {};
    };
    extraUsers.pi = {
      isNormalUser = true;
      initialPassword = "raspberry";
      extraGroups = [ "wheel" "networkmanager" "dialout" "gpio" "i2c" ];
    };
  };
  services.getty.autologinUser = "pi";

  services.udev = {
    extraRules = ''
      KERNEL=="gpiochip0*", GROUP="gpio", MODE="0660"
    '';
  };

  system.stateVersion = "nixos-unstable";
}
