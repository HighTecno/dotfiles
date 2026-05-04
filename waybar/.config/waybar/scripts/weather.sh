#!/usr/bin/env bash

CACHE="$HOME/.cache/waybar-weather"
LOCATION="Baar"

DATA=$(curl -sf --max-time 5 "https://wttr.in/${LOCATION}?format=j1" 2>/dev/null)

if [[ -z "$DATA" ]]; then
    # Return cached result if available, otherwise N/A
    if [[ -f "$CACHE" ]]; then
        cat "$CACHE"
    else
        echo '{"text": " N/A", "tooltip": ""}'
    fi
    exit 0
fi

TEMP=$(echo "$DATA" | jq -r '.current_condition[0].temp_C')
FEELS=$(echo "$DATA" | jq -r '.current_condition[0].FeelsLikeC')
HUMIDITY=$(echo "$DATA" | jq -r '.current_condition[0].humidity')
WIND=$(echo "$DATA" | jq -r '.current_condition[0].windspeedKmph')
DESC=$(echo "$DATA" | jq -r '.current_condition[0].weatherDesc[0].value')

case "${DESC,,}" in
    *sunny*|*clear*)           ICON="" ;;
    *partly*cloud*)            ICON="" ;;
    *cloud*|*overcast*)        ICON="" ;;
    *rain*|*drizzle*)          ICON="" ;;
    *thunder*|*storm*)         ICON="" ;;
    *snow*|*sleet*|*blizzard*) ICON="" ;;
    *fog*|*mist*|*haze*)       ICON="" ;;
    *)                         ICON="" ;;
esac

RESULT="{\"text\": \"${ICON} ${TEMP}°C\", \"tooltip\": \"${DESC} · Feels like ${FEELS}°C · Humidity ${HUMIDITY}% · Wind ${WIND} km/h\"}"
echo "$RESULT" > "$CACHE"
echo "$RESULT"
