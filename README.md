# Debian KDE Hypr‑Style (Trixie)

[🇷🇺 Читать по‑русски](./README.ru.md)

![License](https://img.shields.io/badge/License-MIT-informational)
![Debian](https://img.shields.io/badge/Debian-Trixie%20(Testing)-red)
![KDE Plasma](https://img.shields.io/badge/KDE-Plasma%206-blue)
![Wayland](https://img.shields.io/badge/Display-Wayland-success)

Minimal, Hyprland‑inspired **KDE Plasma** setup for **Debian Testing (Trixie)** —
transparent Konsole, tiling‑like window management via **Bismuth**, **Latte Dock**, dark aesthetics —
while staying 100% on **apt**.

**Repo:** https://github.com/nexrithal/debian-kde-hyprland-style

---

## ✨ Features

- Minimal KDE layout (Latte Dock bottom; slim panel optional)
- Tiling‑like window management via **KWin Bismuth**
- Transparent **Konsole** + **Yakuake** (dropdown terminal)
- Blur/opacity effects preconfigured
- Dark icons (Papirus); optional themes fetch: **Sweet**, **Catppuccin**, **Tokyo Night**
- Backup & restore friendly installer

## 📸 Screenshots


## ✅ Requirements

- **Debian Testing (Trixie)** ISO **including non‑free firmware**
- **KDE Plasma** desktop (Plasma 6 recommended)
- Wayland session is recommended (select **Plasma (Wayland)** on login)
- User with `sudo` for package installs

## 🚀 Quick Start

```bash
# 0) Get the repo
git clone https://github.com/nexrithal/debian-kde-hyprland-style.git
cd debian-kde-hyprland-style

# 1) Update system (recommended)
sudo apt update && sudo apt full-upgrade -y

# 2) Install required packages
sudo apt install -y latte-dock konsole yakuake kwin-bismuth papirus-icon-theme git curl wget unzip jq

# 3) Run installer
chmod +x install.sh
./install.sh

# 4) Log out and log back in (choose Plasma (Wayland) on the login screen)
```

## 🧰 What the installer does

- Backs up your configs to `~/.config-backup-kde-<timestamp>`
- Deploys configs for:
  - **Konsole** (transparent profile, set as default)
  - **Yakuake** (dropdown terminal)
  - **KWin** with **Bismuth** enabled
  - **Plasma** globals (Dark scheme, Papirus icons)
  - **Latte Dock** layout + autostart
- Optionally fetches themes (**Sweet**, **Catppuccin**, **Tokyo Night**) from their Git repos

## ⌨️ Hotkeys

- **Bismuth**: uses its defaults (configure in *System Settings → Shortcuts → KWin Scripts → Bismuth*).
  Common scheme you can set:
  - Move/resize tiles: `Meta + Arrow keys`
  - Monocle/tiling toggle: custom (e.g. `Meta + M`)
  - Focus next/prev window: `Meta + J/K`
- **Yakuake**: toggle with `F12` (default)

## 🔁 Update

```bash
cd debian-kde-hyprland-style
git pull
./install.sh
```

## 🧯 Rollback

- Previous configs are saved under `~/.config-backup-kde-<timestamp>`.
- Copy files back to `~/.config` and `~/.local/share/...` as needed, then re‑login.

## 🛠 Troubleshooting

- **No blur/transparency?** Enable in *System Settings → Desktop Effects → Blur*; use Wayland session.
- **kwriteconfig not found?** Ensure KDE is installed; the script tries `kwriteconfig6` then `kwriteconfig5`.
- **Papirus missing?** Install system‑wide: `sudo apt install papirus-icon-theme`.

## 📄 License

This repository is released under the **MIT License**. See [`LICENSE`](./LICENSE).

> **Note on themes**: external themes (Sweet, Catppuccin, Tokyo Night) are **not bundled** and have their own licenses.
The installer only offers to fetch them from their original repositories.
