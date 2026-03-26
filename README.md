# dotfiles
This is my Linux dotfiles repository, where an updated version of my dotfiles will always be stored

## Dependencies

As of now no dependencies are needed they might be needed someday and i will try to update this, but chances are I'll forget

## Install

To install just run 
```
git clone github.com/HighTecno/dotfiles.git/ ~/dotfiles
```
and then use stow to create symlinks, in this example my neovim config

```
stow nvim
```
for this to work your $PATH environment variable has to include "home/user"
to check run
```
echo $PATH
```
