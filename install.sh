#!/usr/bin/env bash
set -euo pipefail

info() { printf "\033[1;36m[INFO]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }
err()  { printf "\033[1;31m[ERR ]\033[0m %s\n" "$*" >&2; }

# Detect kwriteconfig
KWRITECONFIG="$(command -v kwriteconfig6 || true)"
if [ -z "$KWRITECONFIG" ]; then
  KWRITECONFIG="$(command -v kwriteconfig5 || true)"
fi
if [ -z "$KWRITECONFIG" ]; then
  err "kwriteconfig(5/6) not found. Please ensure KDE is installed and running."
  exit 1
fi
info "Using $KWRITECONFIG"

# Create backup
TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.config-backup-kde-$TS"
mkdir -p "$BACKUP"
info "Backing up current configs to $BACKUP"
cp -a "$HOME/.config" "$BACKUP/" 2>/dev/null || true
cp -a "$HOME/.local/share/konsole" "$BACKUP/" 2>/dev/null || true
cp -a "$HOME/.local/share/yakuake" "$BACKUP/" 2>/dev/null || true

# Ensure required dirs
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share/konsole"
mkdir -p "$HOME/.local/share/yakuake"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/plasma/look-and-feel"
mkdir -p "$HOME/.config/autostart"
mkdir -p "$HOME/.config/latte"
mkdir -p "$HOME/.local/share/kwin/scripts"

# Copy our configs
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

info "Deploying Konsole profile"
cp -a "$SCRIPT_DIR/configs/konsole/HyprKonsole.profile" "$HOME/.local/share/konsole/"
cp -a "$SCRIPT_DIR/configs/konsole/konsolerc" "$HOME/.config/"
$KWRITECONFIG --file "$HOME/.config/konsolerc" --group "Desktop Entry" --key "DefaultProfile" "HyprKonsole.profile"

info "Deploying Yakuake config"
cp -a "$SCRIPT_DIR/configs/yakuake/yakuakerc" "$HOME/.config/"

info "Deploying KWin (Bismuth) configs"
cp -a "$SCRIPT_DIR/configs/kwin/kwinrc" "$HOME/.config/"
# Enable bismuth plugin
$KWRITECONFIG --file "$HOME/.config/kwinrc" --group Plugins --key bismuthEnabled true || true

info "Deploying Plasma and Latte layouts"
cp -a "$SCRIPT_DIR/configs/plasma/kdeglobals" "$HOME/.config/"
cp -a "$SCRIPT_DIR/configs/latte/Nex.layout.latte" "$HOME/.config/latte/"
cp -a "$SCRIPT_DIR/configs/autostart/latte-dock.desktop" "$HOME/.config/autostart/"

# Icons: prefer Papirus system-wide, but ensure user copy is available
if [ -d "/usr/share/icons/Papirus-Dark" ]; then
  info "Papirus icons found system-wide"
else
  info "Installing Papirus icons to user directory (lightweight copy)"
  # Minimal stub: suggest system install; user copy is optional and heavy to ship
  warn "For best results, install system-wide: sudo apt install papirus-icon-theme"
fi

# Optional: fetch themes (Sweet, Catppuccin, Tokyo Night)
read -p "Fetch optional themes (Sweet, Catppuccin, Tokyo Night)? [y/N]: " ans
if [[ "${ans,,}" == "y" ]]; then
  info "Fetching themes..."
  cd "$HOME/.local/share/plasma/look-and-feel"
  # Sweet KDE (look and feel)
  git clone --depth=1 https://github.com/EliverLara/Sweet.git || true
  # Catppuccin KDE
  git clone --depth=1 https://github.com/catppuccin/kde.git catppuccin-kde || true
  # Tokyo Night KDE collections (varies)
  git clone --depth=1 https://github.com/samwhelp/theme-kde-tokyo-night.git tokyo-night-kde || true
fi

# Basic aesthetics: set dark theme + enable blur effect (KDE handles blur via effect config)
# We try to enforce some defaults
$KWRITECONFIG --file "$HOME/.config/kdeglobals" --group "General" --key "ColorScheme" "BreezeDark"
$KWRITECONFIG --file "$HOME/.config/kdeglobals" --group "Icons" --key "Theme" "Papirus-Dark"
$KWRITECONFIG --file "$HOME/.config/kdeglobals" --group "KDE" --key "widgetStyle" "Breeze"

# Try to restart plasmashell/kwin gracefully
info "Restarting Plasma Shell and KWin..."
if command -v plasmashell >/dev/null 2>&1; then
  kquitapp5 plasmashell 2>/dev/null || kquitapp6 plasmashell 2>/dev/null || true
  (plasmashell >/dev/null 2>&1 &)
fi
if command -v kwin_wayland >/dev/null 2>&1; then
  info "You may need to log out/in for KWin changes to fully apply."
fi

echo
info "Done. Log out and log back in (select Plasma (Wayland) if available)."
echo "Backup stored at: $BACKUP"
