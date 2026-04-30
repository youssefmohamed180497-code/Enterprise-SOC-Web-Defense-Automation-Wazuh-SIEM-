cat << 'EOF' > yara/scripts/yara.sh
#!/bin/sh
# Path to Yara binary and rules
YARA_PATH="/usr/bin/yara"
RULES_PATH="/var/ossec/etc/yara/rules/malware_rules.yar"
LOG_FILE="/var/ossec/logs/active-responses.log"

read INPUT
FILE=$(echo $INPUT | jq -r '.parameters.extra_args[0] // .syscheck.path // .data.file')

if [ "$FILE" = "null" ] || [ -z "$FILE" ]; then
    FILE=$(echo $INPUT | jq -r '.file')
fi

if [ -n "$FILE" ] && [ "$FILE" != "null" ]; then
    RESULT=$($YARA_PATH $RULES_PATH "$FILE" 2>&1)
    if [ -n "$RESULT" ] && ! echo "$RESULT" | grep -q "error scanning"; then
        echo "$(date) YARA_DETECTION: $RESULT File: $FILE" >> $LOG_FILE
    fi
fi
EOF
