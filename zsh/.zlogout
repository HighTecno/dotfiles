# ============================================================
# ~/.zshlogout — runs on shell exit
# ============================================================


# ------------------------------------------------------------
# Clean up temporary files or sessions
# ------------------------------------------------------------

# Example: clear terminal history from screen
clear


# Example: kill ssh agent (optional)
if [[ -n "$SSH_AGENT_PID" ]]; then
    eval "$(ssh-agent -k)" >/dev/null
fi


echo "Logged out cleanly."
