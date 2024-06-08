{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
  };

#  myHomeManager.impermanence.directories = [
#    ".mozilla"
#    ".cache/mozilla"
#  ];
}
