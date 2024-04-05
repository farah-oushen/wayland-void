#!/bin/sh
#==========================
# CLOCK:
#==========================
clock() {
	dte=$(date +"%D")
	time=$(date +"%I:%M%p")

	echo " $dte 󰥔 $time"
}

#==========================
# BATTERY:
#==========================
battery () {
	# you might need to change the path depending on your device
	read -r bat_status </sys/class/power_supply/BAT0/status
	read -r bat_capacity </sys/class/power_supply/BAT0/capacity
	if [ "$bat_status" = "Charging" ]; then
		bat_status=""
	elif [ "$bat_status" = "Not charging" ]; then
		bat_status=""
	elif [ "$bat_capacity" -gt 80 ]; then
		bat_status=""
	elif [ "$bat_capacity" -gt 60 ]; then
		bat_status=""
	elif [ "$bat_capacity" -gt 40 ]; then
		bat_status=""
	elif [ "$bat_capacity" -gt 20 ]; then
		bat_status=""
	else
		bat_status=""
	fi
	echo "$bat_status $bat_capacity%"
}

#==========================
# VOLUME:
#==========================
volume_pulse() {
	muted=$(pactl list sinks | awk '/Mute:/ { print $2 }')
	vol=$(pactl list sinks | grep Volume: | awk 'FNR == 1 { print $5 }' | cut -f1 -d '%')

	if [ "$muted" = "yes" ]; then
		echo " muted"
	else
		if [ "$vol" -ge 65 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 40 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 0 ]; then
			echo " $vol%"
		fi
	fi

}
volume_alsa() {

	mono=$(amixer -M sget Master | grep Mono: | awk '{ print $2 }')

	if [ -z "$mono" ]; then
		muted=$(amixer -M sget Master | awk 'FNR == 6 { print $7 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 6 { print $5 }' | sed 's/[][]//g; s/%//g')
	else
		muted=$(amixer -M sget Master | awk 'FNR == 5 { print $6 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 5 { print $4 }' | sed 's/[][]//g; s/%//g')
	fi

	if [ "$muted" = "off" ]; then
		echo " muted"
	else
		if [ "$vol" -ge 65 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 40 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 0 ]; then
			echo " $vol%"
		fi
	fi
}

#==========================
# NETWORK
#==========================
network() {
    if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'up' ] ; then
        wifiicon="$(awk '/^\s*w/ {print "󱚻", int($3 * 100 / 70) "%" }' /proc/net/wireless)"
    elif [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'down' ] ; then
        [ "$(cat /sys/class/net/w*/flags 2>/dev/null)" = '0x1003' ] && wifiicon="󱚿 " || wifiicon="󰖪 "
    fi
    [ "$(cat /sys/class/net/e*/operstate 2>/dev/null)" = 'up' ] && ethericon="󰩠" || ethericon="󰅗"
    echo "$wifiicon"
}

#==========================
# RAM:
#==========================
ram() {
	mem=$(free -h | awk '/Mem:/ { print $3 }' | cut -f1 -d 'i')
	echo  "$mem"
}

#==========================
# CPU:
#==========================
cpu() {
	read -r cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read -r cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo  "$cpu"%
}

#==========================
# DISPLAY:
#==========================
main() {
	while true; do
		echo " [ $(network) ] [ $(volume_pulse) ] [ $(battery) ] [ $(clock) ]"
		sleep 1
	done
}

main
