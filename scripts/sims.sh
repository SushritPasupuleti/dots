#!/bin/sh

# Reference for `xcrun simctl`: https://gist.github.com/patriknyblad/be3678bf6b515f11b602051530b5ac3e

node ~/.my-scripts/simulator-parser.js

OPTION=$(cat ~/.my-scripts/devices.txt | gum filter --limit 1)

if [ -z "$OPTION" ]; then
  echo "No devices found"
  exit 1
fi

echo "Starting:" "$OPTION"

node ~/.my-scripts/simulator-runner.js "$OPTION"
