#!/usr/bin/env bash
#
# Update symlinks for OpenJDK 17 on macOS.

# Create the JavaVirtualMachines directory if it doesn't exist
sudo mkdir -p /Library/Java/JavaVirtualMachines/

# Find and remove any existing OpenJDK symlinks
echo "Checking for existing OpenJDK symlinks..."
for jdk in /Library/Java/JavaVirtualMachines/openjdk-*.jdk; do
  if [ -L "$jdk" ]; then
    echo "Removing existing symlink: $jdk"
    sudo rm "$jdk"
  fi
done

# Create a new symlink for OpenJDK 17
echo "Creating symlink for OpenJDK 17..."
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk \
     /Library/Java/JavaVirtualMachines/openjdk-17.jdk


