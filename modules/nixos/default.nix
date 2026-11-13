{
    imports = [
        ./boot.nix
        ./networking.nix
        ./security.nix
        ./bluetooth.nix
        ./region.nix
        ./users.nix
        ./virtualisation.nix
        ./nix.nix
        ./userdirs.nix
        ./swap.nix
        ./hardware.nix

        # Folder
        ./services
        ./programs
        ./desktop
        ./packages
    ];
}
