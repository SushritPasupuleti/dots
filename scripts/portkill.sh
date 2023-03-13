#!/bin/sh

# Kills process using specified port

PORT_TO_KILL=$(gum input --placeholder "Enter Port to Kill Process on")

gum confirm "Are you sure you want to kill process on port $PORT_TO_KILL?" || exit 0

echo "Killing process on port $PORT_TO_KILL"

kill -9 $(lsof -ti:"$PORT_TO_KILL")
