# ~/. <sup>2026</sup>

A small starter repo for zsh-focused dotfiles.

## Files

- `.zshenv` is loaded by every zsh process. Keep it fast, quiet, and limited to environment variables.
- `.zprofile` is loaded by login shells. Put PATH setup and login-only initialization here.
- `.zshrc` is loaded by interactive shells. Put prompt, completion, aliases, and shell ergonomics here.
- `zsh/aliases.zsh` is an optional place for shared aliases.

## Install

Run the installer from this repo:

```sh
./install.sh
```

It creates symlinks in your home directory for `.zshenv`, `.zprofile`, and `.zshrc`. Existing files are moved aside with a timestamped `.backup-*` suffix.

## Local Overrides

Machine-specific files are intentionally ignored by git:

- `~/.zshenv.local`
- `~/.zprofile.local`
- `~/.zshrc.local`

Use those for secrets, private paths, and one-off machine settings.
