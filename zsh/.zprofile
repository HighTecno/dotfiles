# ============================================================
# ~/.zprofile — Login shell environment
# ============================================================


# ------------------------------------------------------------
# PATH setup (IMPORTANT: login-level PATH only)
# ------------------------------------------------------------

export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"


# ------------------------------------------------------------
# Global environment variables
# ------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


# ------------------------------------------------------------
# XDG base directories
# ------------------------------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"


# ------------------------------------------------------------
# GUI session environment (Wayland / Hyprland etc.)
# ------------------------------------------------------------

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland


# ------------------------------------------------------------
# Start graphical session (only if needed)
# ------------------------------------------------------------

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec Hyprland
fi
