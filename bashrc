eval "$(starship init bash)"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Shell options
shopt -s autocd              # change directory just by typing its name
shopt -s cdspell             # auto correct minor spelling mistakes in cd
shopt -s checkwinsize        # update LINES and COLUMNS after each command
shopt -s histappend          # append to history file instead of overwriting
shopt -s cmdhist             # save multi-line commands as single history entry

# Key bindings (emacs mode)
set -o emacs
bind '"\e[3;5~": kill-word'           # ctrl + del
bind '"\e[3~": delete-char'           # delete
bind '"\e[1;5C": forward-word'        # ctrl + ->
bind '"\e[1;5D": backward-word'       # ctrl + <-
bind '"\e[5~": beginning-of-history'  # page up
bind '"\e[6~": end-of-history'        # page down
bind '"\e[H": beginning-of-line'      # home
bind '"\e[F": end-of-line'            # end
bind '" ": magic-space'               # history expansion on space

# Enable bash completion
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

# History configurations
HISTFILE=~/.bash_history
HISTSIZE=2000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth:erasedups  # ignore duplicates and lines starting with space
shopt -s histverify               # show history expansion before running

# Linux specific configurations

export TERM=xterm
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/usr/bin:$PATH"
complete -o nospace -C /usr/bin/hcp hcp
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export GO111MODULE=auto
export OLLAMA_HOST=$(hostname -I | awk '{print $1}'):11435
export OLLAMA_ORIGINS=safari-web-extension://*
export PATH="$PATH:/home/priyansh/.local/bin"

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Common configurations for all OS
export EDITOR='nvim'

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# some more ls aliases
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'

# -- Use bat instead of cat --
export BAT_THEME="ansi"
eval "$(fzf --bash)"
alias cat='bat'

# ---- Zoxide (better cd) ----
eval "$(zoxide init bash)"
alias cd="z"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
