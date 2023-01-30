#!/bin/sh
echo "Pick a duration to break for..."
DURATION=$(gum choose 5 10 15 30 45 60)
gum spin --spinner dot --title "Waiting for $DURATION" -- sleep $((DURATION * 60))

gum style \
	--border double\
	--align center \
	--width 50 --margin "1 2" \
	--padding 1 \
	'Time up!'
exit 0
