#!/bin/bash

DEVBOX_DIR="./devbox"

if [ ! -d "$DEVBOX_DIR" ]; then
  echo "Error: $DEVBOX_DIR directory not found."
  exit 1
fi

apps=()
for dir in "$DEVBOX_DIR"/*/; do
  app_name=$(basename "$dir")
  apps+=("$app_name")
done

echo "Available Vite React apps:"
echo "---------------------------"
for i in "${!apps[@]}"; do
  echo "$((i+1))) ${apps[$i]}"
done
echo "$(( ${#apps[@]} + 1 ))) [Create a New App]"

read -p "Select an app by number: " selection

if [ "$selection" -eq "$(( ${#apps[@]} + 1 ))" ]; then
  read -p "Enter name for new app: " new_app_name
  if [[ "$new_app_name" == "" ]]; then
    echo "App name cannot be empty."
    exit 1
  fi

  if [ ! -d "$DEVBOX_DIR/$new_app_name" ]; then
    mkdir "$DEVBOX_DIR/$new_app_name"
    echo "Created new app folder: $new_app_name"
  fi

  echo
  echo "Select template:"
  echo "1) JavaScript (react)"
  echo "2) TypeScript (react-ts)"
  read -p "Enter 1 or 2: " template_selection

  if [ "$template_selection" == "2" ]; then
    echo "REACT_TEMPLATE=react-ts" > "$DEVBOX_DIR/$new_app_name/.vite-template"
  else
    echo "REACT_TEMPLATE=react" > "$DEVBOX_DIR/$new_app_name/.vite-template"
  fi

  selected_app="$new_app_name"
else
  if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "$(( ${#apps[@]} + 1 ))" ]; then
    echo "Invalid selection."
    exit 1
  fi
  selected_app="${apps[$((selection-1))]}"
fi

echo
echo "Switching to: $selected_app"
echo

./switch-app.sh "$selected_app"

open_browser() {
  url=$1
  if command -v xdg-open &> /dev/null; then
    xdg-open "$url"
  elif command -v open &> /dev/null; then
    open "$url"
  elif command -v start &> /dev/null; then
    start "$url"
  elif command -v wslview &> /dev/null; then
    wslview "$url"
  else
    echo "Please open $url manually."
  fi
}

echo
echo "Opening browser window..."
open_browser "http://localhost:5173"
