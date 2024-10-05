#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title lpa
# @raycast.mode compact

# Optional parameters:
# @raycast.icon �
# @raycast.argument1 { "type": "text", "placeholder": "account id" }

#echo "Hello World! Argument1 value: "$1""

# Path to the file you want to open
file_path="{{LPADir}}/lpa.html"
env_file="{{LPADir}}/env.js"

# read env file
source .env
# echo $wei

# function to lookup the corresponding env file
lookup_env_value() {
    local var_name="$1"
    local var_value="${!var_name}"

    if [ -z "$var_value" ]; then
        echo "Environment variable '$var_name' is not set."
    else
        echo "$var_value"
    fi
}

if [[ $1 =~ ^[0-9]+$ ]]; then
        echo "$1 is a number"
        siteid="$1"
    else
        echo "$1 is not a number"
        siteid=$(lookup_env_value "$1")
fi

# 
echo "lp account id $siteid"

# Base URL to open in Chrome (file URL)
base_url="file://${file_path}"

# option 1 not working
# Query parameter to append, notworking
query_param="your_param=value"

# Complete URL with query parameter notworking
complete_url="${base_url}?${query_param}"

# echo $complete_url

# option 2, write to a env.js file instead
site="var site = ${siteid};"
echo "${site}" > "${env_file}"

# Open the URL in Google Chrome
open -a "Google Chrome" "$complete_url"

# A really hacky way to simulate an escape press:
echo "tell application \"System Events\" to key code 53" | osascript
