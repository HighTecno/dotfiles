#!/bin/bash
if pgrep -f "nerd-dictation" > /dev/null; then
    echo '{"text": " REC", "class": "active", "tooltip": "Dictation active"}'
else
    echo '{"text": "", "class": "inactive"}'
fi
