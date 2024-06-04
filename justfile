update:
  nix-channel --update
  nix-shell '<home-manager>' -A install
  home-manager switch
