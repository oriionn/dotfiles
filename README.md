# My dotfiles
This repo is dedicated to the configurations I currently use on my desktop.

## Installation
1. Install NixOS with Minimal installation
2. Remove packages, allow unfree and system packages declaration
3. Clone the repository
```sh
git clone ssh://git@git.oriondev.fr:2222/orion/dotfiles.git ~/.dotfiles --recursive
```
4. Import in `configuration.nix`
```nix
imports = 
 [
     (...)
     /home/USER/.dotfiles/nixos/config.nix
 ]
```
5. Rebuild
```sh
nixos-rebuild switch
```

## Credits
- [walls](https://github.com/dharmx/walls)
- [Lucide Icons](https://lucide.dev/)
- [zDyant/HyprNova](https://github.com/zDyant/HyprNova/tree/master) for the hypridle/hyprlock config
