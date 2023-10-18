#!/bin/bash
set -x
set -e

if [ $# != 1 ]; then
    echo $0 launch_id
    return 1
fi

# launch machine
launch_id="$1"
ssh_info=$(twccli ls ccs -s $launch_id -gssh)
ssh -o StrictHostKeyChecking=no -t $ssh_info "if [ \"\$(tmux ls | wc -l)\" == 1 ]; then tmux a; else exit 0; fi"

# stop machine
twccli rm ccs -f -s $launch_id

