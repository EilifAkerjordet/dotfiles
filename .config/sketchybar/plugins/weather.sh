#!/usr/bin/env zsh

# Try to detect location from IP
IP=$(curl -s https://ipinfo.io/ip)
LOCATION_JSON=$(curl -s https://ipinfo.io/$IP/json)

LOCATION="$(echo $LOCATION_JSON | jq -r '.city')"
COORDINATES="$(echo $LOCATION_JSON | jq -r '.loc')"

# Override if detected location is Sandnes (ISP location, not actual)
if [[ "$LOCATION" == "Sandnes" ]]; then
    LOCATION="Oslo"
    LAT="59.9139"
    LON="10.7522"
else
    # Split coordinates into lat and lon
    LAT=$(echo $COORDINATES | cut -d',' -f1)
    LON=$(echo $COORDINATES | cut -d',' -f2)
fi

# Use Open-Meteo API (free, no auth needed)
WEATHER_JSON=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,weather_code&timezone=auto")

# Fallback if empty
if [ -z "$WEATHER_JSON" ]; then
    sketchybar --set $NAME label="$LOCATION"
    sketchybar --set $NAME.moon icon=
    return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq -r '.current.temperature_2m' | cut -d'.' -f1)
WEATHER_CODE=$(echo $WEATHER_JSON | jq -r '.current.weather_code')

# Map weather codes to descriptions
case $WEATHER_CODE in
    0) WEATHER_DESCRIPTION="Clear" ;;
    1|2|3) WEATHER_DESCRIPTION="Partly cloudy" ;;
    45|48) WEATHER_DESCRIPTION="Foggy" ;;
    51|53|55) WEATHER_DESCRIPTION="Drizzle" ;;
    61|63|65) WEATHER_DESCRIPTION="Rain" ;;
    71|73|75) WEATHER_DESCRIPTION="Snow" ;;
    95|96|99) WEATHER_DESCRIPTION="Thunderstorm" ;;
    *) WEATHER_DESCRIPTION="" ;;
esac

# Get moon phase emoji from wttr.in
MOON_ICON=$(curl -s "https://wttr.in/?format=%m" 2>/dev/null)

# Fallback if empty
if [ -z "$MOON_ICON" ]; then
    MOON_ICON=
fi

sketchybar --set $NAME label="$LOCATION  $TEMPERATURE℃ $WEATHER_DESCRIPTION"
sketchybar --set $NAME.moon icon="$MOON_ICON"
