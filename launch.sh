#!/usr/bin/env bash

# Terminate already running bar instances
#killall -q polybar
killall -q polybar

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar mybar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
