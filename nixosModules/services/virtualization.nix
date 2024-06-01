{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # virtualisation
  virtualisation.libvirtd.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
