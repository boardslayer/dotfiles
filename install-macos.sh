#!/bin/bash
# macOS setup: installs tools with Homebrew and symlinks configs from this repo.
# Safe to re-run. Existing files are moved to ~/.dotfiles-backup/<timestamp>/.

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() { # link <repo file> <target>
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP"
    mv "$dst" "$BACKUP/"
    echo "Backed up $dst -> $BACKUP/"
  fi
  ln -s "$src" "$dst"
  echo "Linked $dst"
}

# 1. Homebrew
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. CLI tools and font
brew install tmux fzf zoxide bat fd ripgrep lazygit lazydocker starship coreutils zsh-autosuggestions
brew install --cask font-meslo-lg-dz

# 3. Tmux Plugin Manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# 4. Configs
link zshrc          "$HOME/.zshrc"
link tmux.conf      "$HOME/.tmux.conf"
link starship.toml  "$HOME/.config/starship.toml"
link ghostty-config "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

echo
echo "Done. Open a new terminal, then in tmux press Ctrl-a I to install plugins."
