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
			i3lock
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
