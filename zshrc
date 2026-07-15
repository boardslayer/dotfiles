# Added by ForgeCode installer
export PATH="/Users/priyansh/.local/bin:$PATH"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="apple"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

zstyle ':omz:update' mode reminder # just remind me to update when it's time

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zoxide)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=zed
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history          # Share command history across sessions
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it#

source ~/.zprofile

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# For Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# For linking local compiled binaries in path
export PATH="$HOME/.local/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.

fpath=(/Users/priyansh/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source /Users/priyansh/.oh-my-zsh/custom/aliases.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Homebrew disable hints but clean-up always
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_INSTALL_CLEANUP=0

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# bun completions
[ -s "/Users/priyansh/.bun/_bun" ] && source "/Users/priyansh/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
# alias claude-mem='/Users/priyansh/.bun/bin/bun "/Users/priyansh/.claude/plugins/cache/thedotmack/claude-mem/11.0.1/scripts/worker-service.cjs"'

alias texbuild='pdflatex main.tex && bibtex main && pdflatex main.tex && pdflatex main.tex'
alias texbuildc='texbuild && latexmk -c main.tex'

# Oh-My-Pi
eval "$(omp completions zsh)"


# OLLAMA & SEARCH-FIRECRAWL
export OLLAMA_HOST="0.0.0.0:11434"
export FIRECRAWL_API_KEY=fc-86edb78ef88a412298a192f066255f05

# Linux CoreUtils
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
# Doom Emacs
# export PATH="$PATH:~/.config/emacs/bin"
# Adding OpenOffice soffice
export PATH="$PATH:/Applications/LibreOffice.app/Contents/MacOS/"

#compdef 3gpp-mcp
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
