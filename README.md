# My dotfiles
This repo is dedicated to the configurations I currently use on my desktop.

## Packages used
### Wayland Compositor (and his ecosystem)
- [hyprland](https://archlinux.org/packages/extra/x86_64/hyprland/)
- [hyprpaper](https://archlinux.org/packages/extra/x86_64/hyprpaper/)
- [xdg-desktop-portal-hyprland](https://archlinux.org/packages/extra/x86_64/xdg-desktop-portal-hyprland/)
- [hyprpolkitagent](https://archlinux.org/packages/extra/x86_64/hyprpolkitagent/)
- [hyprlock](https://archlinux.org/packages/extra/x86_64/hyprlock/)
- [hypridle](https://archlinux.org/packages/extra/x86_64/hypridle/)

### App launcher
- [rofi](https://archlinux.org/packages/extra/x86_64/rofi/)
- [rofi-calc](https://archlinux.org/packages/extra/x86_64/rofi-calc/)
- [rofimoji](https://archlinux.org/packages/extra/any/rofimoji/)

### Bar
- [waybar](https://archlinux.org/packages/extra/x86_64/waybar/)

### Display manager
- [ly](https://archlinux.org/packages/extra/x86_64/ly/)

### Notification Daemon
- [swaync](https://archlinux.org/packages/extra/x86_64/swaync/)

### Clipboard Manager
- [clipse](https://aur.archlinux.org/packages/clipse)
- [clipse-gui](https://aur.archlinux.org/packages/clipse-gui)

### Fetch
- [fastfetch](https://archlinux.org/packages/extra/x86_64/fastfetch/)
- [hyfetch](https://archlinux.org/packages/extra/x86_64/hyfetch/)

### Terminal
- [ghostty](https://archlinux.org/packages/extra/x86_64/ghostty/)
- [zsh](https://archlinux.org/packages/extra/x86_64/zsh/)
- [zinit](https://github.com/zdharma-continuum/zinit)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k#zinit)

### Utilities
- [zed](https://archlinux.org/packages/extra/x86_64/zed/)
- [udiskie](https://archlinux.org/packages/extra/any/udiskie/)
- [nwg-bar](https://archlinux.org/packages/extra/x86_64/nwg-bar/)
- [eza](https://archlinux.org/packages/extra/x86_64/eza/)
- [pkgfile](https://archlinux.org/packages/extra/x86_64/pkgfile/)
- [kdeconnect](https://archlinux.org/packages/extra/x86_64/kdeconnect/)
- [arch-update](https://aur.archlinux.org/packages/arch-update)

## Credits
- [walls](https://github.com/dharmx/walls)
- [Lucide Icons](https://lucide.dev/)
- [zDyant/HyprNova](https://github.com/zDyant/HyprNova/tree/master) for the hypridle/hyprlock config

## Installation
To install the dotfiles, there is only one script, which simply copies the configuration files, so you must install the packages yourself.

```sh
git submodule init
chmod +x setup.sh
./setup.sh
```

### Download applications
I have some binary in my dotfiles, like kDrive. You can download it with :
```sh
chmod +x download.sh
./download.sh
```
