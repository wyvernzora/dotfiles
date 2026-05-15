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

link_optional_dotfile() {
  name="$1"
  source_path="$repo_dir/$name"
  target_path="$HOME/$name"

  if [ -e "$source_path" ] || [ -L "$source_path" ]; then
    link_dotfile "$name"
  elif [ -e "$target_path" ] || [ -L "$target_path" ]; then
    mv "$target_path" "$source_path"
    printf 'Adopted local file into repo: %s -> %s\n' "$target_path" "$source_path"
    link_dotfile "$name"
  else
    printf 'Skipping missing optional file: %s\n' "$source_path"
  fi
}

link_dotfile ".zshenv"
link_optional_dotfile ".zshenv.local"
link_dotfile ".zprofile"
link_optional_dotfile ".zprofile.local"
link_dotfile ".zshrc"
link_optional_dotfile ".zshrc.local"
link_dotfile ".gitconfig"
link_optional_dotfile ".gitconfig.user.local"
link_optional_dotfile ".gitconfig.local"

case "$(uname -s)" in
  Darwin)
    link_dotfile ".gitconfig.macos"
    ;;
  *)
    printf 'Skipping macOS git signing config on this platform.\n'
    ;;
esac
