# Dotfiles Repo

This repository contains my personal dotfiles for zsh, tmux, and vim, as well as some other personal configuration files.

The DOTFILES included here:

- .vimrc
- .tmux.conf
- .zshrc
- alacritty.yaml
- my.env

## Installation

To use these dotfiles, please follow these steps:

1. Clone this repository to your home directory:

```bash
git clone https://github.com/rafaelvzago/dotfiles.git ~/dotfiles
```

2. Create symbolic links to the files in this repository:

```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/alacritty.yaml ~/.config/alacritty/alacritty.yaml
```

This will create symbolic links to the files in this repository, so that any changes made to these files will be reflected in your home directory.

## Usage

After installation, you can customize the dotfiles to your liking. The following are some examples of how to use them:

- **Zsh**: The `.zshrc` file contains configuration settings for zsh, including aliases, environment variables, and shell options. You can customize this file to suit your needs.
- **Tmux**: The `.tmux.conf` file contains configuration settings for tmux, including key bindings, color schemes, and status bar settings. You can customize this file to suit your needs.
- **Vim**: The `.vimrc` file contains configuration settings for vim, including plugins, key bindings, and syntax highlighting. You can customize this file to suit your needs.

## Contributing

If you have any suggestions or improvements, please feel free to create an issue or submit a pull request. I welcome any feedback or contributions to this repository.

## License

This repository is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
