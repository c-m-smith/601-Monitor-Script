#!/bin/bash

#Get the system IP
local_ip=$(ip addr show $(ip route | awk '/default/ { print $5 }') | grep "inet" | head -n 1 | awk '/inet/ {print $2}' | cut -d '/' -f1)

#Detection Portion
inotifywait -m -r -e modify /etc /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin /root

#Log Portion
while read -r path action file; do
  echo "LOCAL FILE LOG: $action on host $(hostname) found at $local_ip ALTERATION of $file found at $path" | nc -w 1 -u -p 514 "172.30.0.5" 1515
done
