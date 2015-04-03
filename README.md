Here's my dotfiles

## With shell (preferred)

https://github.com/andsens/homeshick

```sh
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone bf4/dotfiles
source $HOME/.bashrc # needed to get source homeshick path
homeshick cd dotfiles &&
  env WORKSTATION_UPDATE=true ./workstation
cd -
```

## With Ruby

https://github.com/technicalpickles/homesick

```sh
gem install homesick
homesick clone bf4/dotfiles
homesick symlink dotfiles
homesick exec dotfiles env WORKSTATION_UPDATE=true ./workstation
```


Optionally configure `MY_EMAIL`

```sh
echo \nexport MY_EMAIL="somthing@something.com"' >> "$HOME/.homesick/repos/dotfiles/.profile
