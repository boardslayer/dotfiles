# macOS (Apple Silicon) zshrc — symlinked to ~/.zshrc by install-macos.sh

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_INSTALL_CLEANUP=0

# Completions (Homebrew + Docker Desktop)
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
[ -d "$HOME/.docker/completions" ] && fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive completion
zstyle ':completion:*' menu select

# Shell options
setopt correct      # offer to fix mistyped commands
setopt auto_cd      # cd by typing a directory name
bindkey -e          # emacs keybindings

# Prompt, zoxide, fzf
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# Language
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor
export EDITOR="zed --wait"
export VISUAL="$EDITOR"

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history          # Share command history across sessions
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# PATH additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
export PATH="$PATH:/Applications/LibreOffice.app/Contents/MacOS"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # GNU coreutils

# Aliases and functions
source "$HOME/dotfiles/aliases.zsh"
[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Secrets: kept in ~/.config/<tool>/api_key, never in this repo
[ -r "$HOME/.config/openalex/api_key" ] && export OPENALEX_API_KEY="$(cat "$HOME/.config/openalex/api_key")"
[ -r "$HOME/.config/firecrawl/api_key" ] && export FIRECRAWL_API_KEY="$(cat "$HOME/.config/firecrawl/api_key")"

# Ollama
export OLLAMA_HOST="0.0.0.0:11434"

# Optional tools — each block only runs if the tool is installed
# conda
if [ -x /opt/homebrew/Caskroom/miniconda/base/bin/conda ]; then
    eval "$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook 2>/dev/null)"
fi

# bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
fi

# go
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"

# Oh-My-Pi
command -v omp >/dev/null && eval "$(omp completions zsh)"

# 3gpp-mcp completions
if command -v 3gpp-mcp >/dev/null; then
    _3gpp_mcp() {
        local -a commands
        commands=(
            'serve:Start the MCP server'
            'build:Download and import specs into database'
            'download:Download spec files from 3GPP archive'
            'import:Import a single DOCX file into database'
            'import-dir:Import a directory of DOCX files into database'
            'update:Update database to latest spec versions'
            'completion:Generate shell completion scripts'
        )
        _describe '3gpp-mcp command' commands
    }
    compdef _3gpp_mcp 3gpp-mcp
fi
