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
  home.stateVersion = "22.11";
  
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
    _1password-gui
    atuin
    bat
    curl
    dconf
    dogdns
    git
    gnome.gnome-tweaks
    helix
    lsd
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    oh-my-zsh
    rustup
    starship
    vim
    vscode
    zellij
    zoxide
    zsh
  ] ++ [
    flyctl
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
  home.file."${config.xdg.configHome}/zellij/layouts/default.kdl".text = ''
    layout {
      pane size=1 borderless=true {
        plugin location="zellij:tab-bar"
      }
    
      pane split_direction="horizontal" {
        pane
        pane split_direction="vertical" {
            pane
            pane
        }
      }
    
      pane size=2 borderless=true {
        plugin location="zellij:status-bar"
      }
    }
  '';

  # ===== Zsh =====
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "lsd";
      cat = "bat";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
  };
}