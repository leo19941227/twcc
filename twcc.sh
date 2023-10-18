#!/bin/bash
set -x
set -e

if [ $# != 1 ]; then
    echo Please specify GPU num.
    return 1
fi

gpu=$1
launch_name="leo-$(date +%s)"

# launch machine
launch_id=$(twccli mk ccs -wait -json -gpu $gpu -itype "Custom Image" -img "pytorch-21.06-py3:leo19941227-v1.0" -n $launch_name | jq -r ".id")
ssh_info=$(twccli ls ccs -s $launch_id -gssh)
ssh -o StrictHostKeyChecking=no -t $ssh_info "cd /work/leo19941227; tmux new -s $launch_name"

# stop machine
twccli rm ccs -f -s $launch_id

