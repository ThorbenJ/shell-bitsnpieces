#!/bin/bash

# Expand relative path to full path
INIT_DIR="$(cd ./init && pwd)"
BASHRC="$HOME/.bashrc"

BIN_DIR="$(cd ./bin && pwd)"
LOCAL_BIN="$HOME/Local/bin"

mkdir -p "$LOCAL_BIN"

for file in "$BIN_DIR"/*; do
  [ -x "$file" ] || continue

  ln -sf "$file" "$LOCAL_BIN/"
done

for file in "$INIT_DIR"/*.sh; do
  # Skip if no files match
  [ -e "$file" ] || continue

  #escaped_file=$(printf '%s\n' "$file" | sed 's/[][\.*^$(){}+?|]/\\&/g')

  # Check if already in .bashrc
  if ! grep -Fxq "source \"$file\"" "$BASHRC"; then
    echo "Adding: source \"$file\""
    echo "source \"$file\"" >> "$BASHRC"
  else
    echo "Already present: $file"
  fi
done

