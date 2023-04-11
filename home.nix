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
  
  # Allow home-manager to manage shell configuration
  # programs.bash.enable = true;
  # programs.zsh.enable = true;
  
  # Packages (in alphabetical order)
  home.packages = with pkgs; [
    _1password-gui
    alacritty
    atuin
    bat
    curl
    dogdns
    git
    gnome.gnome-tweaks
    helix
    rustup
    vscode
    zellij
    zsh
  ];

  # ===== Alacritty =====
  programs.alacritty = {
    enable = true;
  #   settings = {
  #     background_opacity = 0.9;
  #     window = {
  #       dimensions = {
  #         columns = 80;
  #         lines = 24;
  #       };
  #       decorations = none;
  #       startup_mode = Windowed;
  #     };
  #     colors = {
  #       primary = {
  #         background = "#282828";
  #         foreground = "#ebdbb2";
  #       };
  #       normal = {};
  #       bright = {};
  #     };
  #     cursor = {
  #       style = Beam;
  #       unfocused_hollow = false;
  #     };
  #   };
  };

  # ===== Atuin =====
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = false;
      search_mode = "fuzzy";
    };
  };
}
