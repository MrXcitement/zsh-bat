# zsh-bat.plugin.zsh --- an oh-my-zsh plugin for the 'bat' cli
# Mike Barker
# March 30th 2023

if [[ ! $(whence bat) ]]; then
    print "zsh bat plugin: 'bat' not found. Please install 'bat' to use this plugin."
    return 1
fi

function xterm_background_brightness() {
    local BG_COLOR
    local RED
    local GREEN
    local BLUE

    BG_COLOR=$(xtermcontrol --get-bg 2>/dev/null)
    if [[ $BG_COLOR[0,3] == 'rgb' ]]; then
        RED=$(( 16#$BG_COLOR[5,8] ))
        GREEN=$(( 16#$BG_COLOR[10,13] ))
        BLUE=$(( 16#$BG_COLOR[15,18] ))
        if (( $RED > 32767 )) || (( $GREEN > 32767 )) || (( $BLUE > 32767 )); then
            print "light"
        else
            print "dark"
        fi
    fi
}

function bat() {
    local THEME

    args=("$@")
    if ! (($args[(I)--list*])) && ! (($args[(I)--theme*])); then
        case $(xterm_background_brightness) in
            "dark")
                THEME=${BAT_THEME_DARK:-"Monokai Extended"}
                ;;
            "light")
                THEME=${BAT_THEME_LIGHT:-"Monokai Extended Light"}
                ;;
        esac
        THEME=${BAT_THEME:-$THEME}
    fi

    if [[ ! -z "$THEME" ]]; then
        BAT_THEME=$THEME command bat $@
    else
        command bat $@
    fi
}

alias cat=bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
