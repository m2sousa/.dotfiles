#!/bin/sh

VPN_IP=$(ip -4 addr show tun0 2> /dev/null | grep inet | tr -s ' ' | cut -d' ' -f3 | cut -d/ -f1)

[[ -n $VPN_IP ]] || echo;
    echo "󱚾 VPN: $VPN_IP"

if [[ -n $1 ]]; then
	echo $VPN_IP | xclip -selection clipboard
fi
