# My Emacs Config

Diese Repository enthält meine persönliche Emacs-Konfiguration und die dazugehörigen Systemd-Units für den Daemon-Betrieb.

## 🚀 Installation

Du kannst die Konfiguration entweder direkt klonen oder manuell kopieren.

### Option A: Direkt klonen (Empfohlen)
Wenn du noch keine bestehende Konfiguration hast:
```bash
git clone [https://github.com/simmihugs/my-emacs.git](https://github.com/simmihugs/my-emacs.git) ~/.config/emacs
````

### Option B: Manuell kopieren

Falls du die Dateien lieber selektiv verschieben möchtest:

```bash
cp -r . ~/.config/emacs
```

-----

## ⚙️ Systemd Service Setup

Um Emacs als Hintergrund-Dienst (Daemon) zu starten, damit Fenster blitzschnell via `emacsclient` öffnen, folge der Anleitung im Systemd-Verzeichnis:

👉 **[Anleitung zur Systemd-Installation](https://www.google.com/search?q=./systemd/README.md)**

Kurzfassung:

1.  Verzeichnis erstellen: `mkdir -p ~/.config/systemd/user/`
2.  Datei kopieren: `cp systemd/emacs.service ~/.config/systemd/user/`
3.  Aktivieren: `systemctl --user enable --now emacs.service`

-----

## ⌨️ Schneller Zugriff (Alias)

Füge dies deiner `.zshrc` oder `.bashrc` hinzu, um Emacs über das Terminal in der GUI zu öffnen:

```bash
alias e='emacsclient -n -c -a ""'
```

  * `-n`: Terminal wird nicht blockiert.
  * `-c`: Öffnet ein neues grafisches Fenster (Frame).
  * `-a ""`: Startet den Daemon automatisch, falls er nicht läuft.

<!-- end list -->

