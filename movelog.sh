#!/bin/bash
# Move the current state.log to a dated log file
mv /tmp/state.log /tmp/statelog.$(date +%Y%m%d)

# Remove dated log files older than two weeks
find /tmp/ -name 'statelog.*' -mtime +14 -exec rm {} \;
