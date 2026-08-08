<h1 align="center">Arch Linux Hyprland Dotfiles</h1>
<h3 align="center">Unified dark purple config for Arch Linux</h3>

<p align="center">
  <img src="https://img.shields.io/badge/WM-Hyprland-blue?style=flat-square" />
  <img src="https://img.shields.io/badge/Shell-Zsh-89e051?style=flat-square" />
  <img src="https://img.shields.io/badge/Theme-Dark%20Purple-7F70FF?style=flat-square" />
</p>

---

<details open>
<summary>English</summary>

## Overview
This repository contains my personal **Hyprland** configuration for Arch Linux, built around a consistent dark‑purple palette. Every component — the window manager, status bar, launcher, notifications, and code editor — adheres to the same colour scheme, delivering a cohesive and polished desktop experience.

## Screenshots

| Waybar | Rofi | SwayNC |
|:---:|:---:|:---:|
|![Waybar](screenshots/waybar.png)|![Rofi](screenshots/rofi.png)|![SwayNC](screenshots/swaync.png)|

| VSCode | Fastfetch | Terminal (nvim + btop + cmatrix) |
|:---:|:---:|:---:|
|![VSCode](screenshots/vscode.png)|![Fastfetch](screenshots/fastfetch.png)|![Terminal](screenshots/terminal_tiling.png)|

## Features
- **Window Manager:** Hyprland – smooth animations, blur, transparency, dynamic workspaces.
- **Status Bar:** Waybar with custom modules (keyboard layout, GPU temperature, package updates, night‑mode toggle, etc.).
- **Launcher:** Rofi – application and window switcher, fully themed.
- **Notifications:** SwayNC – notification daemon and control center.
- **OSD:** SwayOSD – volume and brightness pop‑ups.
- **Logout Menu:** Wlogout – clean session management interface.
- **Terminal:** Kitty – pure purple colour scheme, Nerd Font icons.
- **Code Editor:** Neovim – Lazy.nvim, LSP, completion, transparent purple theme (no external plugin required for colours).
- **System Fetch:** Fastfetch – custom ASCII logo and module layout.
- **Theming:** Kvantum (Qt), custom GTK theme (icons & theme folders), matching VSCode theme (external, must be installed separately).
- **Cursor:** Bibata Modern Classic Total Purple.
- **Fonts:** JetBrainsMono Nerd Font, Iosevka Nerd Font.
- **Wallpaper & Recording:** Hyprpaper, GPU screen‑recording script.

## Dependencies
The following packages are required. Please install them using your preferred AUR helper (e.g., `yay`).

### Core
- `hyprland`
- `waybar`
- `rofi-lbonn-wayland` *(or standard `rofi`)*
- `swaync`
- `swayosd`
- `wlogout`
- `kitty`
- `fastfetch`
- `neovim` *(optional, but recommended)*
- `qt5ct` `qt6ct`
- `kvantum`
- `nwg-look` *(GTK theme switcher)*
- `papirus-icon-theme` / `colloid-icon-theme`
- `gammastep` *(for night‑mode toggle)*
- `pipewire` `wireplumber`

### GPU / Screen capture
- `gpu-screen-recorder` (Nvidia only; the script uses `nvidia-smi`)
- `grim` `slurp` `wl-clipboard`

### Utilities
- `pamixer`
- `checkupdates`
- `hyprpaper`
- `jq`
- `btop`, `cmatrix` *(optional, for the terminal screenshot)*

### Nerd Fonts
- `ttf-jetbrains-mono-nerd`
- `ttf-iosevka-nerd`

## Installation
1. **Back up** your current configuration files.
2. Clone this repository:
   ```bash
   git clone https://github.com/daynizm2000/arch-hyprland-dots.git ~/dotfiles
   ```
3. Copy (or symlink) the files:
   ```bash
   cp -r ~/dotfiles/.config/* ~/.config/
   cp -r ~/dotfiles/.local/share/icons ~/.local/share/
   cp -r ~/dotfiles/.local/share/themes ~/.local/share/
   cp ~/dotfiles/.zshrc ~/.zshrc
   cp ~/dotfiles/.p10k.zsh ~/.p10k.zsh
   ```
   > **If you use GNU Stow:** `cd ~/dotfiles && stow .` will symlink everything automatically.
4. **Apply the GTK theme** using `nwg-look` or by editing `~/.config/gtk-3.0/settings.ini` / `gtk-4.0/settings.ini`.
5. **Set the cursor:**
   ```bash
   hyprctl setcursor Bibata-Modern-Classic-TotalPurple 14
   ```
6. **Install any missing fonts** (see the dependencies list above).
7. **For VSCode users:** Please read the [VSCode section](#vscode).
8. Reboot or restart your session.

## Customisation & Caveats
The following items require adjustment according to your specific hardware and preferences:

- **GPU temperature:** The Waybar script relies on `nvidia-smi`. If you use an AMD or Intel GPU, replace `~/.config/waybar/scripts/gpu.sh` or remove the module.
- **Keyboard layout:** `us,ru` with Alt+Shift switching. Modify the `input` section in `hyprland.conf` to match your own layouts.
- **Screen recording:** The provided script uses `gpu-screen-recorder`. You may substitute it with OBS or `wf-recorder` if preferred.
- **VSCode theme:** My settings reference `"dark-purple"` and the icon pack `"dark-purple-icons"`. These must be installed manually from the VSCode Marketplace.
- **Neovim LSP:** Servers (`clangd`, `pyright`, `bashls`) are installed automatically by Mason. Please ensure that `npm` and `unzip` are available on your system.
- **Zsh configuration:** If you do not use Zsh or Powerlevel10k, you may safely ignore `.zshrc` and `.p10k.zsh`.

## VSCode
Copy `vscode-settings/settings.json` into your own VSCode user settings (`~/.config/Code/User/settings.json` on Linux). This file configures:
- Font family and size
- Workbench colours aligned with the purple palette
- A list of recommended extensions (these must still be installed from the Marketplace)

Please remember to install the actual colour theme and icon pack as well.

## Troubleshooting
- **Waybar GPU → “ERR”:** Verify that `nvidia-smi` functions correctly and that the Nvidia drivers are loaded.
- **Rofi missing icons:** Install an icon theme (e.g., `colloid-icon-theme`) and set it in `~/.config/rofi/config.rasi`.
- **Notifications not appearing:** Ensure that the `swaync` daemon is running (`systemctl --user status swaync`).
- **Missing glyphs (squares):** Install the required Nerd Fonts and restart the affected applications.

---

<details>
<summary>Русский</summary>

## Обзор
Данный репозиторий содержит мою персональную конфигурацию **Hyprland** для Arch Linux, выполненную в единой тёмно-фиолетовой гамме. Все компоненты — оконный менеджер, панель, лаунчер, уведомления и редактор — придерживаются общей цветовой схемы, что обеспечивает целостное и аккуратное рабочее окружение.

## Скриншоты

| Waybar | Rofi | SwayNC |
|:---:|:---:|:---:|
|![Waybar](screenshots/waybar.png)|![Rofi](screenshots/rofi.png)|![SwayNC](screenshots/swaync.png)|

| VSCode | Fastfetch | Терминал (nvim + btop + cmatrix) |
|:---:|:---:|:---:|
|![VSCode](screenshots/vscode.png)|![Fastfetch](screenshots/fastfetch.png)|![Terminal](screenshots/terminal_tiling.png)|

## Возможности
- **Оконный менеджер:** Hyprland — анимации, размытие, прозрачность, динамические рабочие столы.
- **Панель:** Waybar с дополнительными модулями (раскладка клавиатуры, температура GPU, обновления пакетов, ночной режим и т. д.).
- **Лаунчер:** Rofi — переключение окон и запуск приложений, полностью стилизованный.
- **Уведомления:** SwayNC — демон уведомлений и центр управления.
- **OSD:** SwayOSD — индикаторы громкости и яркости.
- **Меню выхода:** Wlogout — лаконичный интерфейс для завершения сеанса.
- **Терминал:** Kitty — чистая фиолетовая цветовая схема, иконки Nerd Font.
- **Редактор кода:** Neovim — Lazy.nvim, LSP, автодополнение, прозрачная фиолетовая тема (без необходимости в сторонних плагинах для цветов).
- **Системная информация:** Fastfetch — кастомный ASCII‑логотип и расположение модулей.
- **Темизация:** Kvantum (Qt), пользовательская GTK‑тема (папки с иконками и темами), согласованная тема VSCode (устанавливается отдельно).
- **Курсор:** Bibata Modern Classic Total Purple.
- **Шрифты:** JetBrainsMono Nerd Font, Iosevka Nerd Font.
- **Обои и запись экрана:** Hyprpaper, скрипт записи экрана через GPU.

## Зависимости
Для работы потребуются следующие пакеты. Пожалуйста, установите их с помощью вашего AUR‑помощника (например, `yay`).

### Ядро
- `hyprland`
- `waybar`
- `rofi-lbonn-wayland` *(или стандартный `rofi`)*
- `swaync`
- `swayosd`
- `wlogout`
- `kitty`
- `fastfetch`
- `neovim` *(опционально, но рекомендуется)*
- `qt5ct` `qt6ct`
- `kvantum`
- `nwg-look` *(переключатель GTK‑тем)*
- `papirus-icon-theme` / `colloid-icon-theme`
- `gammastep` *(для ночного режима)*
- `pipewire` `wireplumber`

### GPU / Скриншоты и запись
- `gpu-screen-recorder` (только для Nvidia; скрипт использует `nvidia-smi`)
- `grim` `slurp` `wl-clipboard`

### Утилиты
- `pamixer`
- `checkupdates`
- `hyprpaper`
- `jq`
- `btop`, `cmatrix` *(по желанию)*

### Nerd Fonts
- `ttf-jetbrains-mono-nerd`
- `ttf-iosevka-nerd`

## Установка
1. **Создайте резервную копию** ваших текущих конфигурационных файлов.
2. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/daynizm2000/arch-hyprland-dots.git ~/dotfiles
   ```
3. Скопируйте (или создайте символьные ссылки):
   ```bash
   cp -r ~/dotfiles/.config/* ~/.config/
   cp -r ~/dotfiles/.local/share/icons ~/.local/share/
   cp -r ~/dotfiles/.local/share/themes ~/.local/share/
   cp ~/dotfiles/.zshrc ~/.zshrc
   cp ~/dotfiles/.p10k.zsh ~/.p10k.zsh
   ```
   > **Если вы используете GNU Stow:** `cd ~/dotfiles && stow .` автоматически создаст все необходимые симлинки.
4. **Примените GTK‑тему** с помощью `nwg-look` или вручную отредактировав файлы `~/.config/gtk-3.0/settings.ini` и `gtk-4.0/settings.ini`.
5. **Установите курсор:**
   ```bash
   hyprctl setcursor Bibata-Modern-Classic-TotalPurple 14
   ```
6. **Установите недостающие шрифты** (см. список зависимостей выше).
7. **Пользователям VSCode:** пожалуйста, ознакомьтесь с разделом [VSCode](#vscode-1).
8. Перезагрузите сеанс.

## Настройка под ваше оборудование
Следующие параметры необходимо изменить в соответствии с вашей системой и предпочтениями:

- **Температура GPU:** Скрипт для Waybar ожидает наличие `nvidia-smi`. При использовании видеокарт AMD или Intel замените `~/.config/waybar/scripts/gpu.sh` или уберите этот модуль.
- **Раскладка клавиатуры:** `us,ru` с переключением по Alt+Shift. Измените секцию `input` в `hyprland.conf` на свои языки.
- **Запись экрана:** По умолчанию применяется `gpu-screen-recorder`. При желании вы можете заменить его на `wf-recorder` или OBS.
- **Тема VSCode:** В настройках указана тема `"dark-purple"` и набор иконок `"dark-purple-icons"`. Их необходимо самостоятельно установить из маркетплейса.
- **Neovim LSP:** Серверы (`clangd`, `pyright`, `bashls`) устанавливаются автоматически через Mason. Убедитесь, что в системе присутствуют `npm` и `unzip`.
- **Zsh:** Если вы не пользуетесь Zsh или Powerlevel10k, файлы `.zshrc` и `.p10k.zsh` можно проигнорировать.

## VSCode
Скопируйте `vscode-settings/settings.json` в ваши пользовательские настройки VSCode (`~/.config/Code/User/settings.json` в Linux). В файле содержатся:
- Параметры шрифтов
- Цвета рабочей области, соответствующие фиолетовой палитре
- Список рекомендованных расширений (их всё равно нужно установить вручную из магазина)

Не забудьте также установить саму цветовую тему и набор иконок.

## Решение проблем
- **Waybar отображает “ERR” для GPU:** Проверьте, что утилита `nvidia-smi` работает корректно и драйверы Nvidia загружены.
- **В Rofi отсутствуют иконки:** Установите тему иконок (например, `colloid-icon-theme`) и пропишите её в `~/.config/rofi/config.rasi`.
- **Уведомления не появляются:** Удостоверьтесь, что демон `swaync` запущен (`systemctl --user status swaync`).
- **Квадраты вместо символов:** Установите необходимые Nerd Fonts и перезапустите приложения.
