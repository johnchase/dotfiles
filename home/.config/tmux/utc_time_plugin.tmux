# ~/.tmux/utc_time_plugin.tmux

run-shell "mkdir -p /tmp"

# Custom plugin to show UTC time
set -g @dracula-utc-time-format "UTC: %H:%M"

set -g @dracula-utc-time '#(TZ=UTC date +"#{@dracula-utc-time-format}")'
