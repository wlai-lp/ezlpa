#!/bin/bash
set -eu

# Some commands...
echo "Install EzLPA!"
# echo "The value of MY_VARIABLE is: $MY_VARIABLE"

# Downloads the latest tarball from https://zed.dev/releases and unpacks it
# into ~/.local/. If you'd prefer to do this manually, instructions are at
# https://zed.dev/docs/linux.

main() {
    
    platform="$(uname -s)"
    arch="$(uname -m)"
    channel="${ZED_CHANNEL:-stable}"
    temp="$(mktemp -d "/tmp/zed-XXXXXX")"

    if [ "$platform" = "Darwin" ]; then
        platform="macos"
        echo "macos platform"
    elif [ "$platform" = "Linux" ]; then
        platform="linux"
        echo "linux platform"
    else
        echo "Unsupported platform $platform"
        exit 1
    fi

    # ask for user name and password
    # read -p "Enter your LPA username (e.g. LPA-wlai): " github_username
    #  not sure why this is not working
    # read -sp "Enter your GitHub password: " github_password

    # option 2
    # Prompt for password (and mask it)
    echo -n "LAP Password (silent input): "
    stty -echo  # Disable terminal echo
    # read password
    stty echo  # Re-enable terminal echo
    echo  # Print a newline after password input 
    # use $password to dereference the password
    
    echo "Downloading EzLPA..."
    
    curl -L -o "$HOME/tmp/install.sh" https://raw.githubusercontent.com/wlai-lp/ezlpa/refs/heads/main/install.sh

    content=$(curl -s "https://raw.githubusercontent.com/wlai-lp/ezlpa/refs/heads/main/install.sh")
    # modified_content="${content//echo/oche}"
    modified_content=$(echo "$content" | sed 's/echo/oche/g')
    
    echo "$modified_content" > output.txt




}


main "$@"