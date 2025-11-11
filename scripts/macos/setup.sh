#!/usr/bin/env bash
# macOS bootstrap: keyboard, trackpad, Finder, hot corners, etc.

set -euo pipefail

if [[ "${OSTYPE:-}" != darwin* ]]; then
  echo "This script is intended for macOS only."
  exit 1
fi

echo "Applying macOS defaults..."

###############################################################################
# Keyboard: key repeat + delay
###############################################################################

# Lower = shorter delay before repeating (Apple default ~68)
defaults write -g InitialKeyRepeat -int 15

# Lower = faster repeat rate (Apple default ~6)
defaults write -g KeyRepeat -int 2

# Disable press-and-hold popup so repeat works for letters
defaults write -g ApplePressAndHoldEnabled -bool false

echo " - Key repeat + delay configured"

###############################################################################
# Trackpad: tap to click
###############################################################################

# Built-in + Bluetooth trackpads
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# System-wide tap behavior (1 = tap to click)
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo " - Tap to click enabled"

###############################################################################
# Finder: show hidden files
###############################################################################

defaults write com.apple.finder AppleShowAllFiles -bool true
echo " - Finder: show hidden files enabled"

###############################################################################
# Disable 'Are you sure you want to open this app?' quarantine dialog
###############################################################################

defaults write com.apple.LaunchServices LSQuarantine -bool false
echo " - LSQuarantine disabled"

###############################################################################
# Hot corners
# wvous-<corner>-corner values:
#   0 = no-op
#   2 = Mission Control
#   4 = Desktop
###############################################################################

# Bottom-left: Mission Control
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom-right: Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

echo " - Hot corners set: BL=Mission Control, BR=Desktop"

###############################################################################
# Caps Lock -> Escape (per-session via hidutil)
#
# Note: This mapping is not persisted across reboots by default.
# For persistence, wrap this in a LaunchAgent that runs at login.
###############################################################################

if command -v hidutil >/dev/null 2>&1; then
  hidutil property --set '{
    "UserKeyMapping": [
      {
        "HIDKeyboardModifierMappingSrc": 0x700000039,
        "HIDKeyboardModifierMappingDst": 0x700000029
      }
    ]
  }' || echo " ! Warning: hidutil remap failed (permissions or no external keyboard yet)."
  echo " - Caps Lock mapped to Escape (current session)"
else
  echo " ! hidutil not found; skipping Caps Lock remap."
fi

###############################################################################
# Restart affected services
###############################################################################

killall Dock >/dev/null 2>&1 || true
killall Finder >/dev/null 2>&1 || true
killall SystemUIServer >/dev/null 2>&1 || true

echo "Done. Some changes may require log out / log in to fully apply."
