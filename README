Here's my dotfiles

## With Ruby

https://github.com/technicalpickles/homesick

```sh
gem install homesick
homesick clone bf4/dotfiles
homesick symlink dotfiles
homesick exec dotfiles env WORKSTATION_UPDATE=true ./workstation
```

## With shell

https://github.com/andsens/homeshick

```sh
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
# from sh and its derivates (bash, zsh etc.)
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc
# csh and derivatives (i.e. tcsh)
printf '\nalias homeshick source "$HOME/.homesick/repos/homeshick/bin/homeshick.csh"' >> $HOME/.cshrc
# fish shell
echo \n'source "$HOME/.homesick/repos/homeshick/homeshick.fish"' >> "$HOME/.config/fish/config.fish"

$HOME/.homesick/repos/homeshick/bin/homeshick clone bf4/dotfiles
source $HOME/.bashrc
homeshick cd dotfiles &&
  env WORKSTATION_UPDATE=true ./workstation
cd -
```

Optionally configure `MY_EMAIL`

```sh
echo \nexport MY_EMAIL="somthing@something.com"' >> "$HOME/.homesick/repos/dotfiles/.profile
