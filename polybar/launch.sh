#!/usr/bin/env bash

# Terminate already running bar instances
#killall -q polybar
killall -q polybar
while pgrep -u $UID -x polybar >/dev/nul; do sleep 1; done

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main &
done

echo "Bars launched..."
