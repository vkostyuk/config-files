# config-files

To use config file repo, do

```bash
git init --bare $HOME/.myconf
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

To clone, 

```bash
git clone --bare git@github.com:vkostyuk/config-files.git $HOME/.myconf
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```

If checkout shows conflicts, back up existing config files using

```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
