#!/bin/bash

# Define the source and destination directories
source_dir="$PWD/templates/latex"
destination_dir="$HOME/.local/share/pandoc/templates"

# Create the destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Copy the files from the source directory to the destination directory
cp -r "$source_dir"/* "$destination_dir/"
