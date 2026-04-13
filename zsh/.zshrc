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
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
HEAD
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
=======
[ -s "/home/raphael/.bun/_bun" ] && source "/home/raphael/.bun/_bun"

# bun
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
# opencode
export PATH=/home/raphael/.opencode/bin:$PATH

# opencode
export PATH=/home/raphael/.opencode/bin:$PATH
