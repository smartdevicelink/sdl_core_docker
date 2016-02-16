#!/bin/bash

# This script replaces the IP address in smartDeviceLink.ini with the machine's IP address and then runs SmartDeviceLink Core.
# The IPis required to be replaced for the websocket connection with the HMI to function.

# Get the machine's IP address
IP="$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"
echo "Changing smartDeviceLink.ini HMI ServerAddress to ${IP}"

# Replace the IP address in smartDeviceLink.ini with the machines IP address
perl -pi -e 's/127.0.0.1/'$IP'/g' smartDeviceLink.ini

# Start SmartDeviceLink Core!
./smartDeviceLinkCore
