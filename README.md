# config-files

What's the best way to version control configuration dotfiles? From ones I tried, I like this one (based on [this Hacker News comment](https://news.ycombinator.com/item?id=11071754)) the most.

To initialize a config file repo (i.e., to version your existing config files), do

```bash
git init --bare $HOME/.myconf
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

Then, use `config` as you would `git`.

To clone and use this config file repo, 

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

(This neat script is from [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/))
