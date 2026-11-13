{ username, pkgs, ... }:

{
    users.users."${username}" = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "libvirtd" "i2c" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };
}
