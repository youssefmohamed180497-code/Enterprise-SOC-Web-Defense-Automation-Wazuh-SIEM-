#!/bin/bash
read INPUT
FILE=$(echo $INPUT | grep -oP '(?<="file":")[^"]+')
if [ -n "$FILE" ]; then
    rm -f "$FILE"
    echo "$(date) Automated Mitigation: Deleted malicious file $FILE" >> /var/ossec/logs/active-responses.log
fi
