#!/bin/bash
# undel.sh - paul111366 Interactive Restore
ARCHIVE_DIR="$HOME/.rm_archive"
SEARCH_TERM="$1"

if [ -z "$SEARCH_TERM" ] || [[ "$SEARCH_TERM" == "--help" ]]; then
    echo "Usage: undel [filename]"
    echo "Example: 'undel story.txt' then '1p' to peek at the first 10 lines."
    exit 1
fi

MATCHES=($(ls -t "$ARCHIVE_DIR/${SEARCH_TERM}_"* 2>/dev/null))
if [ ${#MATCHES[@]} -eq 0 ]; then
    echo "No archives found for: $SEARCH_TERM"
    exit 1
fi

echo "Versions of '$SEARCH_TERM' found (Newest first):"
for i in "${!MATCHES[@]}"; do
    MOD_TIME=$(stat -c %y "${MATCHES[$i]}" | cut -d'.' -f1)
    printf "[%d] %s (%s)\n" "$((i+1))" "$(basename "${MATCHES[$i]}")" "$MOD_TIME"
done

read -p "Enter # to restore, or '#p' to peek (e.g. 1p): " INPUT
if [[ "$INPUT" =~ ^([0-9]+)p$ ]]; then
    INDEX=$((${BASH_REMATCH[1]}-1))
    echo "--- Peek at ${MATCHES[$INDEX]} ---"
    tar -xzOf "${MATCHES[$INDEX]}" | head -n 10
    echo "---------------------------------"
    exec "$0" "$SEARCH_TERM"
fi

CHOICE=${INPUT:-1}
INDEX=$((CHOICE-1))
if [[ -n "${MATCHES[$INDEX]}" ]]; then
    tar -xzPf "${MATCHES[$INDEX]}"
    echo "Restored to original path."
else
    echo "Invalid selection."
fi
