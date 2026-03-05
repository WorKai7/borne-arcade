#!/bin/bash

sudo apt install -y python3 default-jdk love tree

PROJECT_DIR="projet"

for dir in "$PROJECT_DIR"/*/; do
    if find "$dir" -type f -name "*.py" | grep -q .; then
        if [ -f "$dir/requirements.txt" ]; then
            echo "Installing dependencies for $dir"
            python3 -m pip install -r "$dir/requirements.txt"
        fi

    fi
done

python3 -m pip install librosa