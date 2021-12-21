#!/bin/bash

eval $*

session=$(tmux display-message -p '#S')
tmux kill-session -t $session

