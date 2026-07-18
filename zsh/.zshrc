# autosugerencias: si no hay nada en el historial, cae a autocompletado normal
# (así también sugiere carpetas/archivos que nunca has visitado, no solo historial)
typeset -g ZSH_AUTOSUGGEST_STRATEGY=(history completion)

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# fastfetch con logo aleatorio -- igual que en fish
if [[ -o interactive ]]; then
  logos=(CachyOS_small arch_small Fedora_small Gentoo_small Garuda_small Kali_small NixOS_small manjaro_small macOS_small Haiku_small Debian_small opensuse_small)
  if [[ $(tput cols) -lt 30 ]]; then
    fastfetch --logo none
  else
    fastfetch --logo "${logos[$(( RANDOM % ${#logos[@]} + 1 ))]}"
  fi

  # leyenda de los símbolos del prompt de starship -- bórrala cuando ya te la sepas de memoria
  printf '\033[38;2;88;209;235m  prompt: [!] modificado  [+] preparado (staged)  [?] nuevos sin trackear\n'
  printf '          [✘] borrado  [»] renombrado  [=] conflicto  [$] stash\n'
  printf '          [⇡N] adelante del remoto  [⇣N] atrás  [⇕N] divergido\033[0m\n'
fi

# zoxide: cd que aprende tus carpetas frecuentes -- usa "z <algo>" en vez de "cd <ruta larga>"
eval "$(zoxide init zsh)"

# atuin: historial de shell buscable, con duración y código de salida por comando
eval "$(atuin init zsh)"

# apaga del todo powerlevel10k (sus hooks se re-imponían sobre el prompt de starship)
(( $+functions[prompt_powerlevel9k_teardown] )) && prompt_powerlevel9k_teardown

# starship: mismo prompt/tema que en fish, reemplaza a Powerlevel10k
eval "$(starship init zsh)"
