[[ $- != *i* ]] && return

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory histignoredups histignorespace

# env
export TERM=xterm-256color
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"

# colors
if command -v dircolors >/dev/null; then
  eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
fi
alias ls='ls --color=auto'

# completion (optimized)
autoload -Uz compinit
mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# aliases
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# plugins
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history substring search
[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] &&
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# bind arrows after sourcing
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# autopair
[[ -f /usr/share/zsh/plugins/zsh-autopair/autopair.zsh ]] &&
  source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

# you-should-use
[[ -f /usr/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh ]] &&
  source /usr/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

# zoxide (replaces cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# fzf
command -v fzf &>/dev/null && source <(fzf --zsh)

# lazy nvm
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  source "$NVM_DIR/nvm.sh"
  nvm "$@"
}

# starship
eval "$(starship init zsh)"

# bun completions

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

[ -s "/home/raphael/.bun/_bun" ] && source "/home/raphael/.bun/_bun"

# bun
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
# opencode
export PATH=/home/raphael/.opencode/bin:$PATH

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# aliases

alias fucking="sudo"
alias l='ls'
alias ll='ls -lh'
alias la='ls -A'
alias lla="ls -la"
alias :wq="exit"
alias sudo='echo "WARNING: This action has been logged and reported to your system administrator." && sleep 2 && sudo'
alias please='sudo'
alias kindly='sudo'
alias fucking='sudo'
alias pleasework='sudo'
alias sudo='sudo '

fastfetch
