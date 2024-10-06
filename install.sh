#!/bin/bash
set -eu

# Some commands...
echo "Install EzLPA!!"
# echo "The value of MY_VARIABLE is: $MY_VARIABLE"

# Downloads the latest tarball from https://zed.dev/releases and unpacks it
# into ~/.local/. If you'd prefer to do this manually, instructions are at
# https://zed.dev/docs/linux.

main() {
    
    LPADir=$HOME/tmp

    echo "create ezlpa dir $LPADir"
    mkdir -p $LPADir

    platform="$(uname -s)"
    arch="$(uname -m)"


    # platform="$(uname -s)"
    # arch="$(uname -m)"    

    # if [ "$platform" = "Darwin" ]; then
    #     platform="macos"
    #     echo "macos platform"
    # elif [ "$platform" = "Linux" ]; then
    #     platform="linux"
    #     echo "linux platform"
    # else
    #     echo "Unsupported platform $platform"
    #     exit 1
    # fi

    echo "start install"
    # ask for user name and password
    read -p "Enter your LPA username (e.g. LPA-wlai): " username
    #echo username is $username
    #  not sure why this is not working
    # read -sp "Enter your GitHub password: " github_password

    # option 2
    # Prompt for password (and mask it)
    echo "LAP Password (silent input): "
    stty -echo  # Disable terminal echo
    read password
    stty echo  # Re-enable terminal echo
    echo  # Print a newline after password input 
    # use $password to dereference the password
    
    echo "Downloading EzLPA to $LPADir..."
    
    #curl -L -o "$HOME/tmp/install.sh" https://raw.githubusercontent.com/wlai-lp/ezlpa/refs/heads/main/install.sh

    # install lp.html and lp.sh
    content=$(curl -s "https://raw.githubusercontent.com/wlai-lp/ezlpa/refs/heads/main/lp.html")
    modified_content=$(echo "$content" | sed "s/{{userId}}/$username/g")
    modified_content=$(echo "$modified_content" | sed "s/{{password}}/$password/g")

    # save it to the output directory
    echo "$modified_content" > $LPADir/lp.html

    # install lp.sh
    content=$(curl -s "https://raw.githubusercontent.com/wlai-lp/ezlpa/refs/heads/main/lp.sh")
    # content=$(curl -s "http://localhost:5500/lp2.sh")
    modified_content=$(echo "$content" | sed "s|{{LPADir}}|$LPADir|g")    
    # save it to the output directory
    echo "$modified_content" > $LPADir/lp.sh
    # echo "$content" > $LPADir/lp.sh

    # lpa.html has 3 parameters, jspuserid (no LPA- prefix), userid (LPA-specific) and password
    # install lpa.html and lpa.sh
    jspuserid=$(echo "$username" | cut -d'-' -f2)
    content=$(curl -s "https://raw.githubusercontent.com/wlai-lp/ezlpa/refs/heads/main/lpa.html")
    #content=$(curl -s "http://localhost:5500/lpa.html")
    modified_content=$(echo "$content" | sed "s|{{userid}}|$username|g")
    modified_content=$(echo "$modified_content" | sed "s/{{jspuserid}}/$jspuserid/g")
    modified_content=$(echo "$modified_content" | sed "s/{{password}}/$password/g")
    echo "$modified_content" > $LPADir/lpa.html

    # install lpa.sh
    content=$(curl -s "https://raw.githubusercontent.com/wlai-lp/ezlpa/refs/heads/main/lpa.sh")
    # content=$(curl -s "http://localhost:5500/lp2.sh")
    modified_content=$(echo "$content" | sed "s|{{LPADir}}|$LPADir|g")    
    # save it to the output directory
    echo "$modified_content" > $LPADir/lpa.sh

    echo "EzLPA installation complete."
    
}


main "$@"