# New Machine Setup

> Note: Although this is called dotfiles there are no actual dotfiles in this repo, they are saved and backed up via iCloud.

Steps to make a new machine easier to setup

## Sign into iCloud and enable documents to be synced.

## Clone this repo

## Run the script found in the script folder, or follow the manual process below.

1. cd to the script directory.
2. Make sure make the script executable with `chmod u+x setup-machine.zsh` then run it with `./setup-machine.zsh`
3. Make sure that the `dock.zsh` script is executable with `chmod u+x dock.zsh`

4. The same can be for the backup script `chmod u+x backup.zsh`
   Then with the backup script you add it as a cron job.

## Install HomeBrew

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Add brew to PATH for zsh

```
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Then pass in the Brewfile location...

```
brew bundle --file [clone loaction]/Brewfile
```

### ...or move to the directory first.

```
cd [clone loaction] && brew bundle
```

## Restore App settings, .zshrc, & .gitconfig using Mackup

### In our case, the files are all backed up via iCloud. As a note, at the time of backing up on March 4, 2024, the symlink on macOS 14 seems to be broken and does not allow the linked files to be read correctly.

### Configure the storage

```shell
nvim ~/.mackup.cfg
```

Add this

```ini
[storage]
engine = icloud
```

Save

### Restore

```
mackup restore --force && mackup uninstall --force
```

As of writing, this is the best way, as it is somewhat broken on macOS 14, due to broken symlinks.
https://github.com/lra/mackup/issues/1924#issuecomment-1756330534

### Restore SSH keys from 1password

[Export](https://developer.1password.com/docs/ssh/manage-keys/#export-an-ssh-key) ssh keys from 1password and place them in ~/.ssh
