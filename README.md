# Arch Update Script

A simple Bash script to automate system updates on Arch Linux.  
It covers:

- `pacman` (core system packages)
- `yay` (AUR helper)
- `pipx` (Python packages)
- `flatpak` (Flatpak apps)
- `snap` (Snap packages)
- `npm` (Node.js global packages)
- `HyDE` (clones and updates the HyDE repo)

---

## Prerequisites

- Arch Linux
- `bash`
- `sudo` & root access
- Optional CLIs you want to update:
  - `yay` for AUR
  - `pipx` for Python
  - `flatpak`
  - `snap`
  - `npm`
- `git` for cloning/updating HyDE

---

## Installation

1. Clone or copy this repo to your machine:
   ```sh
   git clone https://github.com/yourusername/arch_update_script.git
   cd arch_update_script
   ```
2. Make the script executable:
   ```sh
   chmod +x update.sh
   ```

---

## Usage

Run as `sudo` to perform all updates in one go:

```sh
sudo ./update.sh
```

Or, set an alias in your shell config (e.g., `.bashrc` or `.zshrc`):

```sh
alias update='sudo /path/to/arch_update_script/update.sh'
```

---

## Scheduling (Optional)

To automate weekly updates, place a symlink in `/etc/cron.weekly`:

```sh
sudo ln -s /home/<user>/arch_update_script/update.sh /etc/cron.weekly/arch-update
```

## License

This project is released under the MIT License.

Feel free to fork and customize!
