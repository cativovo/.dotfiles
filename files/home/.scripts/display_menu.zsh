#!/bin/zsh

show_display_menu() {
	PATH="$HOME/.local/bin:$PATH"
	local chosen=$(autorandr --list | rofi -dmenu -i -p "Display Profiles")

	if [[ -z "$chosen" ]]; then
		return
	fi

	autorandr --load $chosen
	i3-msg restart
}

show_display_menu
