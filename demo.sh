#!/bin/bash

# Function to display Disk Usage
monitor_disk() {
    echo "--- Disk Usage (Root Partition) ---"
    # The df command reports filesystem disk space usage.
    # -h for human-readable, $NF=="/" finds the root partition, $5 gets the Use% column.
    df -h | awk '$NF=="/"{printf "Used: %s\n", $5}'
}

# Function to display Memory Usage
monitor_memory() {
    echo -e "\n--- Memory Usage ---"
    # The free command displays the amount of free and used memory.
    # -m for megabytes, NR==2 selects the second line (Mem), calculates usage percentage.
    free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3, $2, $3*100/$2}'
}

# Function to display OS Details
monitor_os() {
    echo "--- OS Information ---"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "OS Name    : $NAME"
        echo "OS Version : $VERSION"
    else
        echo "OS information not available"
    fi
}

# Main execution
monitor_disk
monitor_memory
monitor_os
