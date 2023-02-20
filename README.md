# Lachlan's dotfiles

A collection of my dotfiles. I tend to delete as many as I can as often as I can.

## Installation

```bash
git clone https://github.com/lox/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## Components

There's a few special files in the hierarchy.

 - `bin/`: Anything in bin/ will get added to your $PATH and be made available everywhere.
 - `topic/*.zsh`: Any files ending in .zsh get loaded into your environment.
 - `topic/path.zsh`: Any file named path.zsh is loaded first and is expected to setup $PATH or similar.
 - `topic/completion.zsh`: Any file named completion.zsh is loaded last and is expected to setup autocomplete.
 - `topic/*.symlink`: Any files ending in *.symlink get symlinked into your $HOME. This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in `bootstrap.sh`.

## SSH Agent Setup

```
Host *
ServerAliveInterval 10
ServerAliveCountMax 4
IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
ForwardAgent no
StrictHostKeyChecking=accept-new
```

## GPG Keys and Git Signing

Importing keys:

```
gpg --import lachlan-ljd.cc.key
```

Check keys are imported:

```
gpg --list-keys
```

## Thanks to…
  - [Caarlos0's dotfiles](https://github.com/caarlos0/dotfiles)
