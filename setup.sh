echo "Installation des dotfiles"

export NIX_CONFIG="experimental-features = nix-command flakes"

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
:
echo "Mise à jour du flake"
nix flake update --flake "$DOTFILES"

echo "Installation du flake"
sudo nixos-rebuild switch \
	--flake "$DOTFILES?submodules=1#laptop" 
