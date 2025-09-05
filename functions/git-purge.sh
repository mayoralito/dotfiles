#!/bin/bash


echo "Running `git fsck` to check for repository integrity."

# Run git fsck to check for repository integrity
git_fsck_output=$(git fsck --full 2>&1)

# Check if git fsck found any dangling objects (dangling commit, tree, etc.)
if echo "$git_fsck_output" | grep -q "dangling"; then
    echo "Git fsck found dangling objects. Running git gc and cleaning up."

    # Run git gc to optimize the repository
    git gc

    # Expire the reflog
    git reflog expire --expire=now --all

    # Run git gc again with prune option to clean up unreachable objects
    git gc --prune=now

    echo "Repository cleaned up."
else
    echo "Git fsck found no dangling objects."
fi
