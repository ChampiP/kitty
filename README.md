# kitty — mi setup de terminal

Config de kitty + fish + fastfetch tal como quedaron configurados, para poder
levantar el mismo arsenal en otra máquina solo clonando este repo y copiando
los archivos a su lugar.

## Qué hay aquí

| Archivo | Va en | Qué hace |
|---|---|---|
| `kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | Tema (colores vivos estilo macOS + fondo Catppuccin Mocha), tabs powerline, estela de cursor, flash de bell, aviso de escritorio cuando termina un comando largo (`notify_on_cmd_finish`), atajo `Windows+S` para split |
| `fish/config.fish` | `~/.config/fish/config.fish` | Conecta atuin, zoxide, fzf y starship; la leyenda de símbolos del prompt que se imprime al abrir terminal |
| `fish/conf.d/mascot_reaction.fish` | `~/.config/fish/conf.d/mascot_reaction.fish` | Reacción con carita cuando un comando tarda 5s+ (éxito/fallo, con duración) |
| `fastfetch/config.jsonc` | `~/.config/fastfetch/config.jsonc` | Fastfetch con logo aleatorio entre varios compactos ("_small", no se distorsionan al achicar la ventana), colores del mismo tema |
| `starship/starship.toml` | `~/.config/starship.toml` | Paleta de starship pisando los mismos colores de kitty (cian/azul/morado/etc.) — retiñe directory, git_branch, git_status, character, etc. sin tocar cada módulo |

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

# importar historial viejo de fish a atuin (opcional, solo la primera vez)
atuin import fish
```

## No incluido (queda pendiente configurar aparte)

- El atajo de KDE para abrir kitty (`Alt+K`) — vive en `~/.config/kglobalshortcutsrc`,
  es config de todo el escritorio, no de kitty. Hay que rehacerlo desde
  System Settings → Atajos en la máquina nueva.
