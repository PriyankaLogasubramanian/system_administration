#!/bin/bash

#!/bin/bash

# Append current date and time to state.log
echo "State as of $(date):" >> state.log

# Append the output of ls -l to state.log
ls -l >> state.log

