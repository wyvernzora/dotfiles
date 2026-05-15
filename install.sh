#!/usr/bin/env sh
set -eu

repo_dir="$(CDPATH= cd "$(dirname "$0")" && pwd)"
timestamp="$(date +%Y%m%d%H%M%S)"

link_dotfile() {
  name="$1"
  source_path="$repo_dir/$name"
  target_path="$HOME/$name"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    backup_path="$target_path.backup-$timestamp"
    mv "$target_path" "$backup_path"
    printf 'Backed up: %s -> %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked: %s -> %s\n' "$target_path" "$source_path"
}

link_dotfile ".zshenv"
link_dotfile ".zprofile"
link_dotfile ".zshrc"
