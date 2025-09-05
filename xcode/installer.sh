#!/bin/bash

# Function to open the first matching Xcode download URL in the default browser
open_xcode_url_in_browser() {
  local search_str="$1"
  local url=$(echo "$json_data" | jq -r --arg str "$search_str" '
    .[] | select(
      .name == "Xcode" and
      (.version | tostring | contains($str)) and
      (.links.download.url != null)
    ) | .links.download.url' | head -n 1)
  if [ -z "$url" ]; then
    echo "No matching Xcode download URL found for '$search_str'."
    return 1
  fi
  # Remove the base URL and keep the path
  local path="${url#https://download.developer.apple.com}"
  local apple_url="https://developer.apple.com/services-account/download?path=$path"
  
  echo "Opening in browser: $apple_url"
  open "$apple_url"
  echo "Follow the instructions on the Apple Developer site to download and install Xcode."
  echo "You may need to log in with your Apple ID."
  echo "If you have the Apple Developer app installed, you can also search for Xcode there."
  echo "Once downloaded, you can install Xcode by opening the .xip file and following the prompts."
}

# Fetch the JSON data
json_url="https://xcodereleases.com/data.json"
json_data=$(curl -s "$json_url")

# Function to print matching Xcode versions and their download URLs
print_xcode_download_urls() {
  local search_str="$1"
  echo "$json_data" | jq -r --arg str "$search_str" '
    .[] | select(
      .name == "Xcode" and
      (.version | tostring | contains($str))
    ) |
    "Version: " + ((.version | tostring) // "N/A") + "\nURL: " + (.links.download.url // "N/A") + "\n---"
  '
}

# Usage: pass a partial Xcode version string as the first argument

if [ -z "$1" ]; then
  echo "Usage: $0 <partial Xcode version string> [open]"
  echo "       If 'open' is provided as the second argument, the first matching URL will be opened in your default browser."
  exit 1
fi

if [ "$2" = "open" ]; then
  open_xcode_url_in_browser "$1"
else
  output=$(print_xcode_download_urls "$1")
  if [ -n "$output" ]; then
    echo "Matching Xcode versions and download URLs:"
    echo "$output"
  else
    echo "No Xcode versions found matching '$1'."
  fi
fi
