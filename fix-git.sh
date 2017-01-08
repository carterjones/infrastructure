#!/bin/bash

# Update git settings for this repo only.
git config core.eol lf
git config core.autocrlf input

# Update the line endings on disk.
find ./ -type f -exec dos2unix {} \;
