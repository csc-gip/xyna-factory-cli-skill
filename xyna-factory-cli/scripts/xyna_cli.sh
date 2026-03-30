#!/bin/bash

# Configuration
XYNA_HOST=${XYNA_HOST:-localhost}
XYNA_PORT=${XYNA_PORT:-4242}
READ_TIMEOUT=${XYNA_TIMEOUT:-15}

# Protocol Control Characters
GS=$'\x1D'
RS=$'\x1E'
EOT=$'\x04'

cleanup() {
    exec 3>&- 2>/dev/null
}
trap cleanup EXIT

if [ $# -lt 1 ]; then
    echo "Usage: $0 <command> [arg1 arg2 ...]" >&2
    exit 196
fi

# 1. Build Payload
CMD=$1
shift
PAYLOAD="$CMD$GS"
if [ $# -gt 0 ]; then
    PAYLOAD+="$1$RS"
    shift
    for arg in "$@"; do PAYLOAD+="$RS$arg"; done
fi
PAYLOAD+="$GS$EOT"

# 2. Open Connection
exec 3<>/dev/tcp/"$XYNA_HOST"/"$XYNA_PORT" 2>/dev/null || {
    # Treat missing or unavailable socket as NOT_RUNNING
    echo "Status: 'Not running'" >&2
    exit 5
}

# 3. Send payload
printf "%s" "$PAYLOAD" >&3

# 4. Read response
EXIT_CODE=0
while true; do
    # Attempt to read a line
    IFS= read -r -t "$READ_TIMEOUT" line <&3
    READ_STATUS=$?

    # Clean the line
    clean_line=$(echo "$line" | tr -d '\r')

    # 5. CHECK DATA FIRST (even if read returned non-zero)
    if [[ "$clean_line" == *ENDOFSTREAM_* ]]; then
        # Extract the specific marker
        marker=$(echo "$clean_line" | grep -o 'ENDOFSTREAM_[A-Z_]*')
        
        # Handle the specific status mappings
        case "$marker" in
            ENDOFSTREAM_STATUS_UP_AND_RUNNING*)
                echo "Status: 'Up and running'"; EXIT_CODE=0 ;;
            ENDOFSTREAM_STATUS_STARTING*)
                echo "Status: 'Starting'"; EXIT_CODE=1 ;;
            ENDOFSTREAM_STATUS_ALREADY_RUNNING*)
                echo "Status: 'Up and running'"; EXIT_CODE=2 ;;
            ENDOFSTREAM_STATUS_NOT_RUNNING*)
                echo "Status: 'Not running'"; EXIT_CODE=5 ;;
            ENDOFSTREAM_STATUS_STOPPING*)
                echo "Status: 'Stopping'"; EXIT_CODE=6 ;;
            ENDOFSTREAM_SUCCESS|ENDOFSTREAM_SILENT|ENDOFSTREAM_SUCCESS_BUT_NO_CHANGE)
                EXIT_CODE=0 ;;
            *)
                echo "$marker" >&2; EXIT_CODE=198 ;;
        esac
        break
    fi

    # 6. HANDLE READ ERRORS (only if no marker was found in step 5)
    if [ $READ_STATUS -ne 0 ]; then
        if [ $READ_STATUS -gt 128 ]; then
            echo "Error: Connection timed out." >&2
        else
            # This happens if the server closes the connection 
            # and we haven't seen a marker yet.
            echo "Error: Connection closed by server unexpectedly." >&2
        fi
        EXIT_CODE=199
        break
    fi

    # 7. PRINT NORMAL OUTPUT
    # Only reaches here if read was successful (status 0) and no marker found
    echo "$clean_line"
done

exit $EXIT_CODE