{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "senyo";
  home.homeDirectory = "/home/senyo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05";
  
  # Allow non-free packages
  nixpkgs.config = {
    allowUnfree = true;
  };
  
  # Enable Home Manager to work better on non-NixOS Linux distros
  targets.genericLinux.enable = true;

  # Enable Home Manager to configure fonts
  fonts.fontconfig.enable = true;
  
  # Packages (in alphabetical order)
  home.packages = with pkgs; [
    atuin
    bat
    broot
    caffeine-ng
    curl
    dconf
    direnv
    dogdns
    git
    gnome.gnome-tweaks
    helix
    just
    lsd
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    netcat-gnu
    oh-my-zsh
    openresolv
    sd
    socat
    starship
    unixtools.netstat
    vim
    websocat
    wireguard-tools
    wl-clipboard
    zellij
    zoxide
    zsh
  ] ++ [
    delve
    go_1_21
    gopls
    go-tools
    kubectl
    teleport_12
  ];

  # ===== Gnome Terminal =====
  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    profile = {
      # Gruvbox Dark
      ef772e3d-74c4-42be-9fce-c208c04b18b8 = {
        default = true;
        visibleName = "Gruvbox Dark";
        showScrollbar = false;
        transparencyPercent = 10;
        font = "FiraCode Nerd Font 9";
        cursorBlinkMode = "off";
        cursorShape = "ibeam";
        colors = {
          foregroundColor = "#EBDBB2";
          backgroundColor = "#282828";
          palette = [
            # Colours 1 to 9
            "#282828"    # Black (Host)
            "#CC241D"    # Red (Syntax string)
            "#98971A"    # Green (Command)
            "#D79921"    # Yellow (Command second)
            "#458588"    # Blue (Path)
            "#B16286"    # Magenta (Syntax var)
            "#689D6A"    # Cyan (Prompt)
            "#A89984"    # White
            # Colours 9 to 16
            "#928374"    # Bright Black
            "#FB4934"    # Bright Red (Command error)
            "#B8BB26"    # Bright Green (Exec)
            "#FABD2F"    # Bright Yellow
            "#83A598"    # Bright Blue (Folder)
            "#D3869B"    # Bright Magenta
            "#8EC07C"    # Bright Cyan
            "#EBDBB2"    # Bright White
          ];
        };
      };
    };
  };

  # ===== Direnv =====
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # ===== Atuin =====
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = false;
      search_mode = "fuzzy";
    };
  };

  # ===== Starship =====
  programs.starship = {
    enable = true;
  };

  # ===== Zoxide =====
  programs.zoxide = {
    enable = true;
  };

  # ===== Zellij =====
  programs.zellij = {
    enable = true;
    settings = {
      copy_command = "wl-copy";
    };
  };

  home.file."${config.xdg.configHome}/zellij/layouts/default.kdl".text = ''
    layout {
      pane size=1 borderless=true {
        plugin location="zellij:tab-bar"
      }
    
      pane split_direction="horizontal" {
        pane split_direction="vertical" {
            pane
            pane
        }
        pane
      }
    
      pane size=2 borderless=true {
        plugin location="zellij:status-bar"
      }
    }
  '';

  # ===== Zsh =====
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = ''
      source "$HOME/.cargo/env"
      source /home/senyo/.config/broot/launcher/bash/br
      export FLYCTL_INSTALL="/home/senyo/.fly"
      export PATH="$FLYCTL_INSTALL/bin:$PATH"
      export TELEPORT_LOGIN="root"
    '';
    shellAliases = {
      ls = "lsd";
      cat = "bat";
      zj = "zellij";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
  };

  # ===== Helix =====
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}

