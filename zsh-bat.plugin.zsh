# zsh-bat.plugin.zsh --- an oh-my-zsh plugin for the 'bat' cli
# Mike Barker
# March 30th 2023


# if bat is not found, display message and return
if [[ ! $(whence bat) ]]; then
    print "zsh bat plugin: 'bat' not found. Please install 'bat' to use this plugin."
    return 1
fi

function _zsh_bat_get_background_brightness() {
    local BG_COLOR

    BG_COLOR=$(xtermcontrol --get-bg)
    if [[ $BG_COLOR[0,3] == 'rgb' ]]; then
        local RED=$(( 16#$BG_COLOR[5,8] ))
        local GREEN=$(( 16#$BG_COLOR[10,13] ))
        local BLUE=$(( 16#$BG_COLOR[15,18] ))
        if (( $RED > 32767 )) || (( $GREEN > 32767 )) || (( $BLUE > 32767 )); then
            print "light"
        else
            print "dark"
        fi
    fi
}

function _zsh_bat_get_theme() {
    local THEME
    case $(_zsh_bat_get_background_brightness) in
        "dark")
            THEME=${BAT_THEME_DARK:-"Monokai Extended"}
            ;;
        "light")
            THEME=${BAT_THEME_LIGHT:-"Monokai Extended Light"}
            ;;
    esac
    print ${BAT_THEME:-$THEME}
}

function bat() {
    local THEME

    args=("$@")
    if ! (($args[(I)--list*])) && ! (($args[(I)--theme*])); then
        THEME=$(_zsh_bat_get_theme $@)
    fi
    if [[ $THEME ]]; then
        command bat --theme=$THEME $@
    else
        command bat $@
    fi
}

alias cat=bat
export MANPAGER="${0:A:h}/zsh-bat-manpager.zsh"
