# Reacción chiquita cuando un comando largo termina (ej. un agente de Claude Code
# o de OpenCode, un build, un script). No dice nada en comandos rápidos.
function __mascot_reaction --on-event fish_postexec
    set -l last_status $status
    set -l dur $CMD_DURATION

    if test -z "$dur"
        return
    end
    if test "$dur" -lt 5000
        return
    end

    set -l secs (math -s1 "$dur / 1000")

    if test $last_status -eq 0
        set -l face (random choice "(・ω・)ノ" "٩(◕‿◕)۶" "ʕ•ᴥ•ʔ" "(⌐■_■)" "(๑˃ᴗ˂)ﻭ")
        set_color cyan
        echo "  $face listo — "$secs"s"
    else
        set -l face (random choice "(╥﹏╥)" "(-_-;)" "ʕ•̀ᴥ•́ʔ" "(´•̥ ̯•̥`)")
        set_color red
        echo "  $face algo falló (código $last_status, "$secs"s)"
    end
    set_color normal
end
