# ~/. <sup>2.0</sup>

These are the version 2 of my personal dotfiles and provisioning scripts.


## Getting Started
```sh
$ git clone https://github.com/jluchiji/dotfiles ~/.dotfiles
$ ~/.dotfiles/setup.sh
```


## Customization

In order to add a module, you only need to create a subdirectory in your `~/.dotfiles`.


### Provisioning

When running provisioner, it will scan for `.provision.sh` inside your directories, and will
use [Bash Booster][0] to resolve any task dependencies. Dotfiles will always execute tasks
that match names of their parent directories.

For example, a hypothetical `foo/.provision.sh` file might look like this:

```sh

# Define your tasks like this
bb-task-def 'foo'
bb-task-def 'foo-install'

# This task will be automatically started during provisioning
foo() {
  bb-task-depends 'foo-install'
}

# This task will be started by 'foo', since it depends on this
foo-install() {
  install-foo-from-somewhere
}

```

It is suggested that you only use root tasks for dependency declarations, and put actual
provisioning logic into separate tasks. This allows better flexibility in cross-module
dependencies.


### Environment

Every module can contain `.onload.sh` file, which is loaded every time a shell session starts.
Loading order of `.onload.sh` files is not guaranteed, though usually it is alphabetic.

Within `.onload.sh` files you can utilize the full suit of utility functions provided to provisioning
scripts. However, you **can not** use Bash Booster functions (i.e. ones that look like `bb-*`)


[0]: http://www.bashbooster.net
