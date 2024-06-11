#!/bin/bash

# Function to display usage message
usage() {
    echo "Please provide correct arguments and options"
    echo "Usage: $0 [-i|-n] [USERS]"
    echo "Options (optional): -i or -n for interactive or non-interactive execution"
    echo "Arguments: list of user names"
    echo "Every user name must match this regular expression: '^[a-z][a-z0-9_]*$'"
}

# Initialize mode to an empty string and create an array for user names
mode=""
users=()

# Parse options -i and -n using getopts
while getopts ":in" opt; do
    case ${opt} in
        i )
            if [[ $mode == "non-interactive" ]]; then
                echo "ERR: option after an argument or wrong argument or wrong option: -i"
                usage
                exit 1
            fi
            mode="interactive"
            ;;
        n )
            if [[ $mode == "interactive" ]]; then
                echo "ERR: option after an argument or wrong argument or wrong option: -n"
                usage
                exit 1
            fi
            mode="non-interactive"
            ;;
        \? )
            echo "ERR: wrong option: -${OPTARG}"
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))

# Check for options after user names
for arg in "$@"; do
    if [[ $arg == -* ]]; then
        echo "ERR: option after an argument or wrong argument or wrong option: $arg"
        usage
        exit 1
    fi
done

# Default mode to interactive if not set
if [[ -z $mode ]]; then
    mode="interactive"
fi

# Check if at least one user name is provided
if [ $# -lt 1 ]; then
    echo "ERR: No user names provided"
    usage
    exit 1
fi
users=("$@")

# Validate each user name against the regular expression
regex='^[a-z][a-z0-9_]*$'
for user in "${users[@]}"; do
    if [[ ! $user =~ $regex ]]; then
        echo "ERR: Invalid user name: $user"
        usage
        exit 1
    fi
done

# Print mode and user names
echo "Options and arguments okay"
if [[ $mode == "interactive" ]]; then
    echo "running in interactive mode"
else
    echo "running in NON-interactive mode"
fi
echo "User names:"
for user in "${users[@]}"; do
    echo " - $user"
done

# Exit with success code
exit 0
