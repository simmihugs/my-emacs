## 🖥️ Systemd Setup (User Mode)

To run Emacs as a background daemon that starts automatically when you log in, follow these steps:

### 1. Create the directory
Ensure the local systemd user directory exists:
```bash
mkdir -p ~/.config/systemd/user/
```

### 2. Copy the service file
Copy the service file from this repository to your local config:
```bash
cp emacs.service ~/.config/systemd/user/emacs.service
```

### 3. Enable and Start the service
Tell systemd to recognize the new file, enable it for auto-start on login, and start it immediately:
```bash
systemctl --user daemon-reload
systemctl --user enable emacs.service
systemctl --user start emacs.service
```

---

## ⌨️ Terminal Integration

To open files instantly in the GUI using the running daemon, add this alias to your `.zshrc` or `.bashrc`:

```bash
alias e='emacsclient -n -c -a ""'
```

**Usage:**
* `e <filename>`: Opens the file in a new Emacs GUI frame.
* `e`: Just opens a new empty Emacs GUI frame.

---

## 🛠️ Troubleshooting

If the GUI does not appear when calling `emacsclient`, ensure your `emacs.service` includes the `DISPLAY` environment variable:

```ini
[Service]
...
Environment=DISPLAY=:0
...
```
*(Use `WAYLAND_DISPLAY=wayland-0` instead if you are on a pure Wayland session).*

