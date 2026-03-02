#!/bin/bash
# safe_rm.sh - paul111366 Safe Delete Utility
ARCHIVE_DIR="$HOME/.rm_archive"

if [ $# -eq 0 ]; then
    echo "---------------------------------------------------"
    echo "⚠️  Safe-RM: No files specified."
    echo "To restore: undel <filename>"
    echo "To bypass:  \rm <file>"
    echo "Archives:   $ARCHIVE_DIR"
    echo "---------------------------------------------------"
    exit 0
fi

mkdir -p "$ARCHIVE_DIR"
for item in "$@"; do
    if [ -e "$item" ]; then
        ABS_PATH=$(realpath "$item")
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        NAME=$(basename "$item")
        tar -czPf "$ARCHIVE_DIR/${NAME}_${TIMESTAMP}.tar.gz" "$ABS_PATH"
        /bin/rm -rf "$item"
        echo "Archived: $NAME (Restore with 'undel $NAME')"
    fi
done
