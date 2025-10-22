sudo mkdir -p /etc/ly/
sudo cp etc/ly/config.ini /etc/ly/config.ini

mkdir -p ~/.config/hypr/
cp config/hypr/* ~/.config/hypr/

mkdir -p ~/.config/waybar/
cp config/waybar/* ~/.config/waybar/

mkdir -p ~/.config/rofi
cp config/rofi/* ~/.config/rofi/

mkdir -p ~/.config/zed
cp config/zed/* ~/.config/zed/

mkdir -p ~/.config/swaync
cp config/swaync/* ~/.config/swaync

cp config/rofimoji.rc ~/.config/rofimoji.rc

mkdir -p ~/.local/share/applications/
cp applications/* ~/.local/share/applications/
