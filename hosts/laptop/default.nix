{ username, ... }:

{
    imports = [
        ./hardware.nix
        ./share.nix
        ../../modules/nixos
    ];
    home-manager.users."${username}" = import ../../modules/home-manager;

    networking.hostName = "framework"; # hostname

    system.stateVersion = "26.05"; # NixOS version
    nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable NixOS experimental features
}
