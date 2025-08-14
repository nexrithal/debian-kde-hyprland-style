# Debian KDE Hypr‑Style (Trixie)

[🇬🇧 Read in English](./README.md)

![Лицензия](https://img.shields.io/badge/Лицензия-MIT-informational)
![Debian](https://img.shields.io/badge/Debian-Trixie%20(Testing)-red)
![KDE Plasma](https://img.shields.io/badge/KDE-Plasma%206-blue)
![Wayland](https://img.shields.io/badge/Display-Wayland-success)

Минималистичный сетап **KDE Plasma** на **Debian Testing (Trixie)** с вайбом Hyprland:
прозрачный **Konsole**, плиточная раскладка через **Bismuth**, **Latte Dock**, тёмная эстетика —
и всё это остаётся на **apt**.

**Репозиторий:** https://github.com/nexrithal/debian-kde-hyprland-style

---

## ✨ Что внутри

- Минимальная раскладка KDE (Latte Dock снизу; верхняя панель — опционально)
- «Почти как Hyprland» — плитки через **KWin Bismuth**
- Прозрачный **Konsole** + **Yakuake** (выпадающий терминал)
- Настроенные эффекты размытия/прозрачности
- Тёмные иконки (Papirus); опциональная загрузка тем: **Sweet**, **Catppuccin**, **Tokyo Night**
- Инсталлятор с бэкапом и возможностью отката

## 📸 Скриншоты


## ✅ Требования

- **Debian Testing (Trixie)** ISO **с non‑free firmware**
- Рабочий стол **KDE Plasma** (рекомендуется Plasma 6)
- Рекомендована сессия Wayland (на экране входа выбрать **Plasma (Wayland)**)
- Пользователь с правами `sudo` для установки пакетов

## 🚀 Установка

```bash
# 0) Клонировать репозиторий
git clone https://github.com/nexrithal/debian-kde-hyprland-style.git
cd debian-kde-hyprland-style

# 1) Обновить систему (рекомендуется)
sudo apt update && sudo apt full-upgrade -y

# 2) Установить необходимые пакеты
sudo apt install -y latte-dock konsole yakuake kwin-bismuth papirus-icon-theme git curl wget unzip jq

# 3) Запустить установку
chmod +x install.sh
./install.sh

# 4) Выйти из сессии и войти снова (на экране входа выбрать Plasma (Wayland))
```

## 🧰 Что делает инсталлятор

- Создаёт бэкап ваших конфигов в `~/.config-backup-kde-<timestamp>`
- Разворачивает конфиги для:
  - **Konsole** (прозрачный профиль и установка по умолчанию)
  - **Yakuake** (выпадающий терминал)
  - **KWin** с включённым **Bismuth**
  - **Plasma**: тёмная тема и иконки Papirus
  - **Latte Dock**: импорт макета + автозапуск
- Опционально подтягивает темы (**Sweet**, **Catppuccin**, **Tokyo Night**) из их Git‑репозиториев

## ⌨️ Горячие клавиши

- **Bismuth**: по умолчанию использует свои шорткаты (меняются в *Системные настройки → Комбинации клавиш → Скрипты KWin → Bismuth*).
  Рекомендуемая схема:
  - Управление плитками: `Meta + Стрелки`
  - Монокль/тайлинг: кастом (например, `Meta + M`)
  - Фокус окна: `Meta + J/K`
- **Yakuake**: сворачивание/разворачивание — `F12` (дефолт)

## 🔁 Обновление

```bash
cd debian-kde-hyprland-style
git pull
./install.sh
```

## 🧯 Откат

- Предыдущие конфиги сохранены в `~/.config-backup-kde-<timestamp>`.
- Верните нужные файлы в `~/.config` и `~/.local/share/...`, затем перелогиньтесь.

## 🛠 Решение проблем

- **Нет размытия/прозрачности?** Включите в *Системные настройки → Эффекты рабочего стола → Размытие*; используйте сессию Wayland.
- **Не найден kwriteconfig?** Убедитесь, что KDE установлен; скрипт ищет `kwriteconfig6`, затем `kwriteconfig5`.
- **Нет Papirus?** Поставьте системно: `sudo apt install papirus-icon-theme`.

## 📄 Лицензия

Репозиторий распространяется по **MIT License**. См. [`LICENSE`](./LICENSE).

> **Примечание о темах**: внешние темы (Sweet, Catppuccin, Tokyo Night) **не включены** и имеют собственные лицензии.
Инсталлятор лишь предлагает загрузить их из оригинальных репозиториев.
