#!/bin/bash

export PATH="/usr/local/bin:$PATH"

# Colors
COLOR_ACTIVE=0xff8aadf4
COLOR_INACTIVE=0xff6e738d
ICON=󰒘

# Check if port is in dev range (3000-9999)
is_dev_port() {
    [ "$1" -ge 3000 ] && [ "$1" -le 9999 ]
}

# Format display label for a port
get_display_label() {
    local pid=$2 cmd=$3

    [ "$pid" = "docker" ] && echo "🐳 $cmd" && return

    local full_cmd=$(ps -p "$pid" -o command= 2>/dev/null | xargs)
    [ -z "$full_cmd" ] && echo "$cmd" && return

    # Extract relevant command parts and strip paths
    echo "$full_cmd" | awk '{
        if ($1 ~ /node/ && $2 ~ /npm/) print $2, $3, $4
        else if ($1 ~ /python/) print $1, $2
        else if ($1 ~ /node/) print "node", $2
        else print $1, $2
    }' | sed 's|.*/||g' | cut -c1-40
}

# Collect all dev ports from lsof and docker
collect_ports() {
    # Regular listening ports (3000-9999)
    lsof -iTCP:3000-9999 -sTCP:LISTEN -n -P 2>/dev/null | awk 'NR>1 {
        split($9, a, ":")
        print a[length(a)] ":" $2 ":" $1
    }'

    # Docker container ports
    docker ps --format "{{.Names}}|{{.Ports}}" 2>/dev/null | while IFS='|' read -r name ports; do
        echo "$ports" | grep -oE "0\.0\.0\.0:([0-9]+(-[0-9]+)?)" | cut -d: -f2 | while read -r port_spec; do
            # Handle port ranges (e.g., 3000-3005) or single ports
            if [[ "$port_spec" =~ ^([0-9]+)-([0-9]+)$ ]]; then
                for ((p=${BASH_REMATCH[1]}; p<=${BASH_REMATCH[2]}; p++)); do
                    is_dev_port "$p" && echo "$p:docker:$name"
                done
            else
                is_dev_port "$port_spec" && echo "$port_spec:docker:$name"
            fi
        done
    done
}

# Handle port click (right-click to kill)
handle_port_click() {
    [ "$BUTTON" = "right" ] && kill_port_process "$1"
}

get_all_descendants() {
    local pid=$1
    local children=$(pgrep -P "$pid" 2>/dev/null)

    # Print this PID
    echo "$pid"

    # Recursively get children's descendants
    for child in $children; do
        get_all_descendants "$child"
    done
}

# Walk up process tree to find root (stops at shells/terminals)
get_process_tree_root() {
    local current=$1

    while true; do
        local parent=$(ps -o ppid= -p "$current" 2>/dev/null | tr -d ' ')
        [ -z "$parent" ] || [ "$parent" -le 1 ] && break

        # Get parent command basename (strip paths and leading dash for login shells)
        local parent_cmd=$(ps -o comm= -p "$parent" 2>/dev/null | tr -d ' ')
        parent_cmd="${parent_cmd##*/}"
        parent_cmd="${parent_cmd#-}"

        # Stop at shells/terminals
        [[ "$parent_cmd" =~ ^(bash|zsh|sh|fish|login|Terminal|iTerm|tmux)$ ]] && break

        current=$parent
    done

    echo "$current"
}

# Kill process(es) listening on a port
kill_port_process() {
    local port=$1
    local info=$(collect_ports | grep "^${port}:")
    [ -z "$info" ] && return

    local pid cmd
    IFS=: read -r _ pid cmd <<< "$info"

    if [ "$pid" = "docker" ]; then
        docker stop "$cmd" 2>/dev/null
    else
        # Check if process is Docker/OrbStack daemon - if so, find and stop the container
        local proc_name=$(ps -o comm= -p "$pid" 2>/dev/null)
        if [[ "$proc_name" =~ (docker|orbstack|com.docker) ]]; then
            # Find which container is using this port
            local container=$(docker ps --format "{{.Names}}|{{.Ports}}" 2>/dev/null | grep ":${port}->" | cut -d'|' -f1 | head -1)
            [ -n "$container" ] && docker stop "$container" 2>/dev/null
        else
            # Regular process - find root and kill entire tree (bottom-up)
            local root=$(get_process_tree_root "$pid")
            local pids=$(get_all_descendants "$root" | tail -r)
            for p in $pids; do kill -9 "$p" 2>/dev/null; done
        fi
    fi

    sleep 0.5
    update_display
}

# Update sketchybar display with current ports
update_display() {
    # Collect and filter out system processes
    local ports=$(collect_ports | while IFS=: read -r port pid cmd; do
        if [ "$pid" != "docker" ]; then
            local full=$(ps -p "$pid" -o command= 2>/dev/null)
            [[ "$full" == /Applications* || "$full" == /System/Library* ]] && continue
        fi
        echo "$port:$pid:$cmd"
    done | sort -u -t: -k1,1n)

    local count=$(echo "$ports" | grep -c "^[0-9]")

    # Remove old popup items
    sketchybar --remove '/dev_ports\..*/'

    if [ "$count" -eq 0 ]; then
        sketchybar --set dev_ports label="No Ports" icon="$ICON" icon.color="$COLOR_INACTIVE"
    else
        sketchybar --set dev_ports label="$count" icon="$ICON" icon.color="$COLOR_ACTIVE"

        local script="$HOME/.config/sketchybar/plugins/dev_ports.sh"
        echo "$ports" | while IFS=: read -r port pid cmd; do
            sketchybar --add item "dev_ports.${port}" popup.dev_ports \
                       --set "dev_ports.${port}" \
                       label="$(get_display_label "$port" "$pid" "$cmd")" \
                       icon=":${port}" \
                       icon.color="$COLOR_ACTIVE" \
                       padding_left=16 \
                       padding_right=16 \
                       click_script="$script $port"
        done
    fi
}

# Entry point: Handle clicks (from click_script) or events (from sketchybar)
[[ "$1" =~ ^[0-9]+$ ]] && handle_port_click "$1" && exit 0

case "$SENDER" in
    routine|forced) update_display ;;
    mouse.entered) sketchybar --set dev_ports popup.drawing=on ;;
    mouse.exited*) sketchybar --set dev_ports popup.drawing=off ;;
esac
