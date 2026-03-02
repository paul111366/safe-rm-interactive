#!/bin/bash
# install.sh - Traces shell config and sets up alias

# 1. Determine Target Config
if [ -d "/etc/profile.d" ] && [ "$EUID" -eq 0 ]; then
    TARGET="/etc/profile.d/safe-rm.sh"
elif [ -f "$HOME/.bash_aliases" ]; then
    TARGET="$HOME/.bash_aliases"
elif [ -f "$HOME/.bashrc" ]; then
    TARGET="$HOME/.bashrc"
else
    TARGET="$HOME/.profile"
fi

# 2. Setup Binaries (assuming they are in the current folder)
mkdir -p "$HOME/.local/bin"
cp safe_rm.sh "$HOME/.local/bin/safe_rm"
cp undel.sh "$HOME/.local/bin/undel"
chmod +x "$HOME/.local/bin/safe_rm" "$HOME/.local/bin/undel"

# 3. Add Alias
ALIAS_LINE="alias rm='$HOME/.local/bin/safe_rm'"
if ! grep -q "$ALIAS_LINE" "$TARGET"; then
    echo "$ALIAS_LINE" >> "$TARGET"
    echo "Installed alias to $TARGET"
fi

echo "Install complete. Please restart your terminal or run: source $TARGET"
