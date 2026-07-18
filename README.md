# kitty — mi setup de terminal

Config de kitty + fish + fastfetch tal como quedaron configurados, para poder
levantar el mismo arsenal en otra máquina solo clonando este repo y copiando
los archivos a su lugar.

`skills/mis-preferencias-pc/SKILL.md` documenta el *por qué* de estas
decisiones (qué se probó y se rechazó, qué gustos son estables) — instalarla
en `~/.claude/skills/mis-preferencias-pc/` para que Claude Code la tenga
presente en cualquier sesión futura de configuración del sistema.

## Qué hay aquí

| Archivo | Va en | Qué hace |
|---|---|---|
| `kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | Tema (colores vivos estilo macOS), transparencia 0.72 + blur, tabs powerline, estela de cursor, flash de bell, aviso de escritorio cuando termina un comando largo (`notify_on_cmd_finish`), atajo `Windows+S` para split, `shell zsh` (zsh por defecto en toda ventana nueva de kitty) |
| `fish/config.fish` | `~/.config/fish/config.fish` | Conecta atuin, zoxide, fzf y starship; la leyenda de símbolos del prompt que se imprime al abrir terminal |
| `fish/conf.d/mascot_reaction.fish` | `~/.config/fish/conf.d/mascot_reaction.fish` | Reacción con carita cuando un comando tarda 5s+ (éxito/fallo, con duración) |
| `fastfetch/config.jsonc` | `~/.config/fastfetch/config.jsonc` | Fastfetch con logo aleatorio entre varios compactos ("_small", no se distorsionan al achicar la ventana), colores del mismo tema |
| `starship/starship.toml` | `~/.config/starship.toml` | Paleta de starship pisando los mismos colores de kitty (cian/azul/morado/etc.) — retiñe directory, git_branch, git_status, character, etc. sin tocar cada módulo |
| `zsh/.zshrc` | `~/.zshrc` | Mismo setup que fish pero para zsh (default de kitty desde el cambio de `shell zsh`, y lo que usan Cursor y otras apps que abren zsh sin preguntar): fastfetch con logo aleatorio + leyenda de prompt, zoxide, atuin, y starship — apaga Powerlevel10k (viene por defecto en CachyOS) para que no pise el prompt de starship, y ajusta `ZSH_AUTOSUGGEST_STRATEGY=(history completion)` para que sugiera carpetas/archivos que nunca visitaste (no solo los del historial) |

## Dependencias

Antes de copiar los archivos, instalar:

```
sudo pacman -S kitty fish fastfetch starship zoxide fzf atuin eza bat
```

`fish/config.fish` empieza con `source /usr/share/cachyos-fish-config/cachyos-config.fish`
(trae los alias de `eza`/`bat` y el saludo con fastfetch) — **eso es específico
de CachyOS**. En otra distro hay que quitar esa línea y agregar los alias de
`eza`/`bat` a mano, o adaptar.

## Cómo restaurar

```bash
git clone https://github.com/ChampiP/kitty.git ~/git-hub/kitty
mkdir -p ~/.config/kitty ~/.config/fish/conf.d ~/.config/fastfetch
cp ~/git-hub/kitty/kitty/kitty.conf        ~/.config/kitty/kitty.conf
cp ~/git-hub/kitty/fish/config.fish        ~/.config/fish/config.fish
cp ~/git-hub/kitty/fish/conf.d/mascot_reaction.fish ~/.config/fish/conf.d/mascot_reaction.fish
cp ~/git-hub/kitty/fastfetch/config.jsonc  ~/.config/fastfetch/config.jsonc
cp ~/git-hub/kitty/starship/starship.toml  ~/.config/starship.toml
cp ~/git-hub/kitty/zsh/.zshrc              ~/.zshrc

# importar historial viejo de fish a atuin (opcional, solo la primera vez)
atuin import fish
```

## Otros ajustes del escritorio (no viven en archivos de este repo)

Configurados en la misma sesión, pero son estado de sistema / KDE, no dotfiles
que se puedan copiar. Para reproducirlos en otra máquina:

```bash
# Portapapeles (Klipper): historial de 200, persistente entre reinicios
# -> editar ~/.config/klipperrc, agregar:
#    [General]
#    KeepClipboardContents=true
#    MaxClipItems=200
#    SyncClipboards=true
# luego: kquitapp6 plasmashell; kstart plasmashell

# fail2ban: banea IPs tras 5 intentos fallidos de SSH en 10 min (ban de 1h)
sudo pacman -S fail2ban
printf '[DEFAULT]\nbantime  = 1h\nfindtime = 10m\nmaxretry = 5\nbackend  = systemd\n\n[sshd]\nenabled = true\nport    = 22\n' | sudo tee /etc/fail2ban/jail.local
sudo systemctl enable --now fail2ban.service

# lazydocker: TUI para ver/manejar contenedores Docker sin escribir comandos largos
sudo pacman -S lazydocker

# Snapshots automáticos por tiempo con snapper (además de los que ya dispara
# snap-pac en cada pacman -S/-Syu)
sudo snapper -c root set-config TIMELINE_CREATE=yes TIMELINE_LIMIT_HOURLY=6 TIMELINE_LIMIT_DAILY=7 TIMELINE_LIMIT_WEEKLY=2 TIMELINE_LIMIT_MONTHLY=0
sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer

# KDE Connect: notificaciones/archivos compartidos con el celular (misma red)
sudo pacman -S kdeconnect
# luego emparejar desde la app del celular + System Settings -> KDE Connect
# nota: si el firewall bloquea el descubrimiento, abrir el rango de puertos:
sudo ufw allow 1714:1764/udp
sudo ufw allow 1714:1764/tcp
```

- El atajo de KDE para abrir kitty (`Alt+K`) — vive en `~/.config/kglobalshortcutsrc`,
  es config de todo el escritorio, no de kitty. Hay que rehacerlo desde
  System Settings → Atajos en la máquina nueva.
- Las notificaciones automáticas de tareas pendientes de ObsiNotes al iniciar
  sesión (`obsinotes-notify-login.service`) y los timers de sincronización con
  Notion/transcripción/kanban viven documentados en el propio repo de
  `ObsiNotes` (`~/git-hub/obsidian/ObsiNotes/AGENTS.md`), no aquí.
