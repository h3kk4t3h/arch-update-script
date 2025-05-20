#!/usr/bin/env bash
set -euo pipefail
trap 'log "Unexpected error"; exit 1' ERR

log() { printf '%s %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$*"; }
have() { command -v "$1" &>/dev/null; }
update_mgr() { local name=$1; shift; if have "$1"; then log "Updating $name..."; "$@" || log "⚠️  $name update failed"; else log "ℹ️  $name not found; skipping."; fi; }

main() {
    (( EUID == 0 )) || { log "Must run as root"; exit 1; }

    update_mgr "pacman" pacman -Syu --noconfirm
    update_mgr "yay (AUR)" sudo -u "$SUDO_USER" yay -Syu --noconfirm
    update_mgr "pipx packages" sudo -u "$SUDO_USER" pipx upgrade-all
    update_mgr "Flatpak" flatpak update -y
    update_mgr "Snap" snap refresh
    update_mgr "npm globals" npm update -g

    log "Updating HyDE repo..."
    if [[ -d "$HOME/HyDE" ]]; then
        git -C "$HOME/HyDE" pull
    else
        git clone --depth=1 https://github.com/HyDE-Project/HyDE "$HOME/HyDE"
    fi

    if [[ -x "$HOME/HyDE/Scripts/install.sh" ]]; then
        log "Running HyDE installer (-r)..."
        bash "$HOME/HyDE/Scripts/install.sh" -r
    else
        log "⚠️  HyDE installer not found; skipping."
    fi

    log "🎉 All updates completed."
}

main "$@"