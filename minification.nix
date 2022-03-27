{ config, pkgs, lib, ... }:

with lib;
{
  # no GUI environment
  environment.noXlibs = mkDefault true;

  # don't build documentation
  documentation.info.enable = mkDefault false;
  documentation.man.enable = mkDefault false;

  # don't include a 'command not found' helper
  programs.command-not-found.enable = mkDefault false;

  # disable firewall (needs iptables)
  networking.firewall.enable = mkDefault false;

  # disable polkit
  security.polkit.enable = mkDefault false;

  # disable audit
  security.audit.enable = mkDefault false;

  # disable udisks
  services.udisks2.enable = mkDefault false;

  # disable containers
  boot.enableContainers = mkDefault false;

  # build less locales
  # This isn't perfect, but let's expect the user specifies an UTF-8 defaultLocale
  i18n.supportedLocales = [ (config.i18n.defaultLocale + "/UTF-8") ];
}
