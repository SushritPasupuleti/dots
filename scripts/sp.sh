#!/bin/sh
SESSION=$(tmux list-sessions -F \#S | gum filter --placeholder "Pick session...")
tmux switch-client -t $SESSION || tmux attach -t $SESSION
