#!/usr/bin/env zsh
source "${0:A:h}/zsh-bat.plugin.zsh"
local THEME=$(_zsh_bat_get_theme)
if [[ $THEME ]]; then
    col -bx | bat --theme=$THEME -l man -p
else
    col -bx | bat -l man -p
fi
