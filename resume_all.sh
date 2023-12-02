#!/bin/bash

set -x
set -e

tmux new -s resume -d

ids=$(twccli ls ccs -json | jq -r ".[] | .id")
for idx in $ids;
do
    tmux new-window -n ${idx} -d
    tmux send-keys -t resume:$idx "./resume.sh ${idx}" C-m
done

