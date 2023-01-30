#!/bin/sh
OPTION=$(gum choose "Octo")

if [ "$OPTION" = "Octo" ]; then
	echo "Octo Docs..."
	gum format < $(pwd)/scripts/docs/Octo.md
fi
exit 0
