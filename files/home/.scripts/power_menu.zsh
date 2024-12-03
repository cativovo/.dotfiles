#!/bin/zsh

show_power_menu() {
	local shutdown=' Shutdown'
	local reboot=' Reboot'
	local lock=' Lock'
	local suspend='󰤄 Suspend'
	local logout='󰍃 Logout'
	local chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -i -p 'Power Menu')

	case ${chosen} in
		$shutdown)
			shutdown now
			;;
		$reboot)
			reboot
			;;
		$lock)
		  xset dpms force standby
			;;
		$suspend)
			systemctl suspend
			;;
		$logout)
			i3-msg exit
			;;
	esac
}

show_power_menu
