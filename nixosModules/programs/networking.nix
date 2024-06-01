{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    hostname-debian
  ];
}
