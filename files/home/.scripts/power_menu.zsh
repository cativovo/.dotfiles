#!/bin/zsh

show_power_menu() {
	local shutdown=' Shutdown'
	local reboot=' Reboot'
	local lock=' Lock'
	local suspend='󰤄 Suspend'
	local logout='󰍃 Logout'
	local chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | fuzzel -d -i -p '󱐋 ')

	case ${chosen} in
		$shutdown)
			shutdown now
			;;
		$reboot)
			reboot
			;;
		$lock)
			swaylock -f
			;;
		$suspend)
			systemctl suspend
			;;
		$logout)
			swaymsg exit
			;;
	esac
}

show_power_menu
