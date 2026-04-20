# ============================================================
# ~/.zshlogin — runs after login shell starts
# ============================================================


# ------------------------------------------------------------
# Welcome message
# ------------------------------------------------------------

echo "Welcome back $USER"


# ------------------------------------------------------------
# Start background services (optional)
# ------------------------------------------------------------

# Example: start ssh agent if not running
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    eval "$(ssh-agent -s)" >/dev/null
fi
