{ pkgs, inputs, outputs, lib, ... }:

{
  imports = [ outputs.homeManagerModules.default ];
  home.username = "nh";
  home.homeDirectory = lib.mkDefault "/home/nh";

  home.packages = with pkgs; [
    neofetch
    zip
    xz
    unzip
    p7zip

    ripgrep # recursively searches directories for a regex pattern
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    
    qemu
    virt-manager
    bridge-utils
    
   cowsay
   file
    nix-output-monitor
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

  ];

  programs.git = {
    enable = true;
    userName = "Jeremy Hage";
    userEmail = "jeremy.hage@gmail.com";
    extraConfig = {
      init = {
	defaultBranch = "main";
      };
    };
  };

  myHomeManager = {
    bundles.general.enable = true;
  };

    programs.starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
    programs.bash = {
      enable = true;
      enableCompletion = true;
      # TODO add your custom bashrc here
      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      '';

      # set some aliases, feel free to add more or remove some
      shellAliases = {
       # k = "kubectl";
       # urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
       # urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      };
    };

   programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-mocha";
      };
      themes = {
        # https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
        catppuccin-mocha = {
          src = inputs.catppuccin-bat;
          file = "./themes/Catppuccin Mocha.tmTheme";
        };
      };
    };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Tomorrow Night",
      }
    ''; 
  };

    programs.tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

  

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
