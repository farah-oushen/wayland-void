#!/bin/sh
exec swayidle -w \
	timeout 600 "swaylock" \
	timeout 600 "wlr-randr --output eDP-1 --off" resume "wlr-randr --output eDP-1 --on" \
	before-sleep "swaylock"