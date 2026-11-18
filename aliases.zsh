# Sourced by zshrc

# ls
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'

# -- Use fd for fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# -- Use bat instead of cat --
export BAT_THEME="ansi"
alias cat='bat'

# ---- Zoxide (better cd) ----
alias cd="z"

# Editor
alias e='zed'

# LaTeX
alias texbuild='pdflatex main.tex && bibtex main && pdflatex main.tex && pdflatex main.tex'
alias texbuildc='texbuild && latexmk -c main.tex'
