#!/bin/zsh

show_display_menu() {
	local profiles="$(autorandr --list)\nhorizontal\nvertical\ncommon"
	local chosen=$(echo $profiles | rofi -dmenu -i -p "Display Profiles")

	if [[ -z "$chosen" ]]; then
		return
	fi

	autorandr --load $chosen
	i3-msg restart
}

show_display_menu
