set -gx EDITOR nvim

# Path configuration
fish_add_path /opt/homebrew/bin
fish_add_path (go env GOPATH)/bin 2>/dev/null

# Android SDK paths
set -gx ANDROID_HOME $HOME/Library/Android/sdk
fish_add_path $ANDROID_HOME/tools
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/emulator
