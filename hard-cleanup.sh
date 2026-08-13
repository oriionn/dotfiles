#!/usr/bin/env bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Erreur : vous devez éxecuter le script en root"
    exit 1
fi

current_system="$(readlink -f /run/current-system)"
system_profile="$(readlink -f /nix/var/nix/profiles/system)"

if [[ "$current_system" != "$system_profile" ]]; then
    echo "Nettoyage annulé : la génération active n'est pas la génération courante."
    echo "Redémarre sur la génération courante avant d'effectuer un hard cleanup."
    exit 1
fi

echo "ATTENTION : l'éxecution de cette commande va supprimer toutes les anciennes générations."
echo

read -r -p "Saisis exactement « oui » pour continuer : " confirmation

if [[ "$confirmation" != "oui" ]]; then
    echo "Nettoyage annulé."
    exit 0
fi

echo
echo "Suppression des anciennes générations..."
nix-collect-garbage -d

echo
echo "Mise à jour des entrées de systemd-boot..."
/run/current-system/bin/switch-to-configuration boot

echo
echo "Hard cleanup fini."
