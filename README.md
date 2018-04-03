# dotfiles

@spoike does dotfiles. Works on Ubuntu 14.04.3 LTS (trusty) and MacOS High Sierra.

## How do I use this?

1. Fork this repo

2. Clone to ~/dotfiles

3. Look through the settings. Change what you want to change.

4. Run the install script. `cd ~/dotfiles && make`

## What does the Makefile do?

The installer/bootstrapper scripts will attempt to do the following things:

* Symlink the dotfiles in the repo's castle directory to your home directory

* Install common OSS packages and tools I use both at work and home. On mac it
  will attempt to install XCode Command Line Tools and Homebrew.
