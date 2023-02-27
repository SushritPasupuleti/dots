#!/bin/sh

# Reference: https://developer.android.com/studio/run/emulator-commandline

# Should work on all unix-like systems
#OPTION=$(emulator -list-avds | gum filter --limit 1)

# patch to work on my mac
OPTION=$(~/Library/Android/sdk/emulator/emulator -list-avds | gum filter --limit 1)

if [ -z "$OPTION" ]; then
	echo "No AVD found"
	exit 1
fi

echo "Starting $OPTION"

# Should work on all unix-like systems
#emulator -avd "$OPTION"

# patch to work on my mac
~/Library/Android/sdk/emulator/emulator -avd "$OPTION"
