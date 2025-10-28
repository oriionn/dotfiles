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

mkdir -p ~/.config/fastfetch
cp config/fastfetch/* ~/.config/fastfetch

mkdir -p ~/.config/ghostty
cp -r config/ghostty/* ~/.config/ghostty

mkdir -p ~/.config/arch-update
cp config/arch-update/* ~/.config/arch-update

mkdir -p ~/.config/nwg-waybar
cp config/nwg-bar/* ~/.config/nwg-bar

cp config/rofimoji.rc ~/.config/rofimoji.rc
cp config/hyfetch.json ~/.config/hyfetch.json

mkdir -p ~/.local/share/applications/
cp applications/* ~/.local/share/applications/

LINE='source ~/dotfiles/config/zshrc'
if ! grep -Fxq "$LINE" "$HOME/.zshrc"; then
  echo "$LINE" >>"$HOME/.zshrc"
fi
