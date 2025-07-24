#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit || killall -q polybar
# Otherwise you can use the nuclear option:

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar.logp
polybar main --config="$HOME/.config/polybar/config.ini" 2>&1 | tee -a /tmp/polybar1.log & disown
