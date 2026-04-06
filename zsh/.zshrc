# ~/.zshrc

# ── guard: bail if not interactive ───────────────────────────────────────────
[[ $- != *i* ]] && return

# ── history ──────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory        # append instead of overwrite on exit
setopt histignoredups       # no duplicate entries
setopt histignorespace      # skip lines starting with a space

# ── terminal ─────────────────────────────────────────────────────────────────
export TERM=xterm-256color  # safe fallback for SSH / tmux

# ── path ─────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"

# ── colors ───────────────────────────────────────────────────────────────────
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
fi
alias ls='ls --color=auto'

# ── completion ───────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit

# ── aliases ───────────────────────────────────────────────────────────────────
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# ── plugins ───────────────────────────────────────────────────────────────────
# install: sudo apt install zsh-autosuggestions zsh-syntax-highlighting
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ── nvm (node version manager) ───────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]]          && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# ── anthropic / ollama (claude code + jarvis) ────────────────────────────────
export ANTHROPIC_API_KEY="ollama"                       # routes to local ollama
export ANTHROPIC_BASE_URL="http://100.90.16.100:11434"  # hp-server via tailscale

# ── prompt (starship) ────────────────────────────────────────────────────────
# install: curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"


source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

# bun completions
[ -s "/home/raphael/.bun/_bun" ] && source "/home/raphael/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
