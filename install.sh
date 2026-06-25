#!/usr/bin/env bash

# Expand relative path to full path
INIT_DIR="$(cd ./init && pwd)"
BASHRC="$HOME/.bashrc"

BIN_DIR="$(cd ./bin && pwd)"
OS_BIN_DIR="$(pwd)/bin_$(uname -s | tr '[:upper:]' '[:lower:]')"
LOCAL_BIN="$HOME/Local/bin"

mkdir -p "$LOCAL_BIN"

for file in "$BIN_DIR"/*; do
  [ -x "$file" ] || continue

  ln -sf "$file" "$LOCAL_BIN/"
done

if [ -d "$OS_BIN_DIR" ]; then
  for file in "$OS_BIN_DIR"/*; do
    [ -x "$file" ] || continue

    ln -sf "$file" "$LOCAL_BIN/"
  done
fi

AUTO_YES="$(echo "${1:-}" | tr '[:upper:]' '[:lower:]')"

for file in "$INIT_DIR"/*.sh; do
  # Skip if no files match
  [ -e "$file" ] || continue

  # Check if already in .bashrc
  if grep -Fxq "source \"$file\"" "$BASHRC"; then
    echo "Already present: $file"
    continue
  fi

  if [ "$AUTO_YES" != "yes" ]; then
    echo ""
    echo "$(basename "$file"):"
    grep "^##" "$file" | sed 's/^## */  /'
    echo ""
    read -r -p "Add 'source \"$file\"' to $BASHRC? [Y/n] " confirm
    case "$(echo "$confirm" | tr '[:upper:]' '[:lower:]')" in
      y|yes|'') ;;
      *) echo "Skipping."; continue ;;
    esac
  fi

  echo "Adding: source \"$file\""
  echo "source \"$file\"" >> "$BASHRC"
done

