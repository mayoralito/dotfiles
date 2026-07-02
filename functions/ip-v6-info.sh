#!/bin/bash

# Function to check IPv6 status for all network services
check_ipv6_status() {
    networksetup -listallnetworkservices | tail -n +2 | while read -r service; do
        ipv6_status=$(networksetup -getinfo "$service" | grep "IPv6 Address")
        if [[ ! -z "$ipv6_status" ]]; then
            # Send macOS notification
            osascript -e "display notification \"IPv6 is enabled on $service\" with title \"IPv6 Status\""
        fi
    done
}
echo "hola"
# Call the function
check_ipv6_status