#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
killall -q polybar

for m in $(polybar  --list-monitors | cut -d":" -f1); do 
    MONITOR=$m polybar main --config="$HOME/.config/polybar/config.ini" 2>&1 | tee -a /tmp/polybar.log & disown
done
