source /usr/share/cachyos-fish-config/cachyos-config.fish

# leyenda de los símbolos del prompt de starship -- bórrala cuando ya te la sepas de memoria
function _starship_legend
    set_color 58d1eb
    echo "  prompt: [!] modificado  [+] preparado (staged)  [?] nuevos sin trackear"
    echo "          [✘] borrado  [»] renombrado  [=] conflicto  [\$] stash"
    echo "          [⇡N] adelante del remoto  [⇣N] atrás  [⇕N] divergido"
    set_color normal
end

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # logos compactos ("_small") -- no se distorsionan al achicar la ventana
    # como pasaba con el logo grande de CachyOS. Uno al azar cada vez que abres.
    set -l logos CachyOS_small arch_small Fedora_small Gentoo_small Garuda_small \
        Kali_small NixOS_small manjaro_small macOS_small Haiku_small Debian_small opensuse_small

    if test (tput cols) -lt 30
        fastfetch --logo none
    else
        fastfetch --logo (random choice $logos)
    end
    _starship_legend
end

# opencode
fish_add_path /home/brayan/.opencode/bin
set -gx PATH $HOME/.npm-global/bin $PATH

# atuin: historial de shell buscable, con duración y código de salida por comando
atuin init fish | source

# zoxide: cd que aprende tus carpetas frecuentes -- usa "z <algo>" en vez de "cd <ruta larga>"
zoxide init fish | source

# fzf: Ctrl+T (archivos), Alt+C (cd difuso). Ctrl+R lo dejamos para atuin (arriba),
# que ya trae búsqueda de historial con duración y código de salida.
set -gx FZF_CTRL_R_COMMAND ''
fzf_key_bindings

# starship: prompt con rama/estado de git, etc.
starship init fish | source
