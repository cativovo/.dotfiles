#!/bin/zsh

run_rofi() {
	local shutdown=' Shutdown'
	local reboot=' Reboot'
	local lock=' Lock'
	local suspend='󰤄 Suspend'
	local logout='󰍃 Logout'
	local chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -i)

	case ${chosen} in
		$shutdown)
			shutdown now
			;;
		$reboot)
			reboot
			;;
		$lock)
			i3lock -c 1A73E8
			;;
		$suspend)
			systemctl suspend
			;;
		$logout)
			i3-msg exit
			;;
	esac
}

run_rofi