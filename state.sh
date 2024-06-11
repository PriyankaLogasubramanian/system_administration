#!/bin/bash

# Log current date and time
echo "Date and Time: $(date)" >> /tmp/state.log

# Log current load and users logged in
echo "Load and Users Logged In:" >> /tmp/state.log
uptime >> /tmp/state.log
who >> /tmp/state.log

# Log all processes running on the machine
echo "All Processes Running (PID and PPID):" >> /tmp/state.log
ps aux >> /tmp/state.log
