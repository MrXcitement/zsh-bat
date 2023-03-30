# zsh-bat

An [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) plugin for integration with the [bat](https://github.com/sharkdp/bat) pager.

This plugin provides a wrapper function for the `bat` command. The wrapper will use `xtermcontrol` if installed, to try to use a *dark* or *light* theme based on the current background color in the terminal.

## Prerequisites

You should have `bat` installed, this plugin will do nothing otherwise.
Install `xtermcontrol` and the plugin will attempt to pick a *dark* or *light* theme based on the background color of your terminal.

## Install

Create a new directory in `$ZSH_CUSTOM/plugins` called `zsh-bat` and clone this repo into that directory.
```
git clone https://github.com/mrxcitement/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
```

Add `zsh-bat` to your plugin list in `~/.zshrc`.

## Usage

This plugin will alias `cat` with `bat`. To run the real `cat` command, you can use `\cat`.
It also enables syntax highlighting for the `man` command.

To provide your own *dark* and/or *light* theme preference set one or both of the environment variables.
```
export BAT_THEME_DARK=OneHalfDark
export BAT_THEME_LIGHT=OneHalfLight
```

For help with `bat`, see [sharkdp/bat](https://github.com/sharkdp/bat).

## Troubleshooting

If the *dark* *light* mode detection is not working, your terminal may not support xterm OSC codes.
- Do you have the `xtermcontrol` program installed and in your path?
- What does `xtermcontrol --get-bg` command return?
    - The return value should be a string with the following format: rgb:rrrr/gggg/bbbb
- What does the function `xterm_background_brightness` return.
    - The return value should be a string of either *dark*, *light*, or an empty string. An empty string is returned if the background brightness can't be determined.
- The selected theme will be provided using the BAT_THEME environment variable.
    - To see what theme was selected run `bat --diagnostics | grep BAT_THEME'`
