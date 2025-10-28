sudo mkdir -p /etc/ly/
sudo cp -r etc/ly/config.ini /etc/ly/config.ini

mkdir -p ~/.config/hypr/
cp -r config/hypr/* ~/.config/hypr/

mkdir -p ~/.config/waybar/
cp -r config/waybar/* ~/.config/waybar/

mkdir -p ~/.config/rofi
cp -r config/rofi/* ~/.config/rofi/

mkdir -p ~/.config/zed
cp -r config/zed/* ~/.config/zed/

mkdir -p ~/.config/swaync
cp -r config/swaync/* ~/.config/swaync

mkdir -p ~/.config/fastfetch
cp -r config/fastfetch/* ~/.config/fastfetch

mkdir -p ~/.config/ghostty
cp -r config/ghostty/* ~/.config/ghostty

mkdir -p ~/.config/arch-update
cp -r config/arch-update/* ~/.config/arch-update

mkdir -p ~/.config/nwg-waybar
cp -r config/nwg-bar/* ~/.config/nwg-bar

cp config/rofimoji.rc ~/.config/rofimoji.rc
cp config/hyfetch.json ~/.config/hyfetch.json

mkdir -p ~/.local/share/applications/
cp -r applications/* ~/.local/share/applications/

LINE='source ~/dotfiles/config/zshrc'
if ! grep -Fxq "$LINE" "$HOME/.zshrc"; then
  echo "$LINE" >>"$HOME/.zshrc"
fi
