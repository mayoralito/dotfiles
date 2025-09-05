#!/usr/bin/env bash 

# check if rbenv is installed
if ! command -v rbenv &> /dev/null; then
    echo "rbenv is not installed. Please install rbenv first."
    exit 1
fi  

# review if current rbenv version is 3.3.7
current_version=$(rbenv version | awk '{print $1}')
if [[ "$current_version" == "3.3.7" ]]; then
    echo "Ruby version 3.3.7 is already set as global version."
    return 0 # this is not a blocker, just allowing someone else to use this script
fi  

rbenv install 3.3.7
rbenv global 3.3.7
which ruby
ruby --version 