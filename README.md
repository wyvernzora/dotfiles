# ~/. <sup>2026</sup>

A small starter repo for zsh-focused dotfiles.

## Files

- `.zshenv` is loaded by every zsh process. Keep it fast, quiet, and limited to environment variables.
- `.zprofile` is loaded by login shells. Put PATH setup and login-only initialization here.
- `.zshrc` is loaded by interactive shells. Put prompt, completion, aliases, and shell ergonomics here.
- `.gitconfig` contains shared git defaults, aliases, and merge/diff settings.
- `.gitconfig.macos` contains macOS-only git signing settings.
- `zsh/aliases.zsh` is an optional place for shared aliases.

## Install

Run the installer from this repo:

```sh
./install.sh
```

It creates symlinks in your home directory for `.zshenv`, `.zprofile`, `.zshrc`, and `.gitconfig`. On macOS, it also links `.gitconfig.macos`. If ignored local files exist in the repo, it links those too. If local files already exist in `$HOME`, it adopts them into the repo first. Existing shared files are moved aside with a timestamped `.backup-*` suffix.

## Local Overrides

Machine-specific files are intentionally ignored by git:

- `~/.zshenv.local`
- `~/.zprofile.local`
- `~/.zshrc.local`
- `~/.gitconfig.user.local`
- `~/.gitconfig.local`

Keep those files in this repo as ignored files, then run `./install.sh` to symlink them into `$HOME`. Use them for secrets, private paths, and one-off machine settings.

Put git identity and personal signing keys in `~/.gitconfig.user.local`:

```gitconfig
[user]
        name = Your Name
        email = you@example.com
        signingkey = ssh-ed25519 ...
```
