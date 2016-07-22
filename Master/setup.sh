#!/bin/bash
#
# Replaces the IP address in smartDeviceLink.ini with the machine's IP address and then runs SmartDeviceLink Core.
# The IP is required to be replaced for the websocket connection with the HMI to function.

# Get the machine's IP address
IP="$(ip addr show ${CORE_NETWORK_INTERFACE} | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"

#######################################
# Replaces text within a specified file
#######################################
function replace {
    target=$1
    value=$2
    file=$3

    echo "${file} - Replacing ${target} with ${value}"
    perl -pi -e 's/'${target}'/'${value}'/g' ${file}
}

# Replace the IP address in smartDeviceLink.ini with the machines IP address
replace "127.0.0.1" ${IP} ${PWD}/smartDeviceLink.ini

# Replace IP and Port in flags file to match the machine's IP address
replace "127.0.0.1:8087" ${HMI_WEBSOCKET_ADDRESS} ${HMI_CWD}/app/Flags.js

# Set location of SDL Core Binaries
export LD_LIBRARY_PATH=${PWD}

# Start supervisord
/usr/bin/supervisord