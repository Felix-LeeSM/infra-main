#!/bin/bash
set -e

echo "Updating submodules to their remote tracking branches..."
git submodule update --remote --recursive

echo "Pulling latest changes for the superproject..."
git pull origin main

echo "Pulling latest changes within each submodule..."
git submodule foreach '
    echo "Entering submodule: $name"
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    echo "Pulling latest changes for $name on branch $current_branch..."
    git pull origin "$current_branch"
    echo "Exiting submodule: $name"
'

echo "All submodules and superproject updated successfully (pull only)."