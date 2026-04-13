Manager Configuration (ossec.conf)

I linked the VirusTotal Alert (Rule 87105) to the execution of the custom script:

<command>
  <name>remove-threat</name>
  <executable>remove-threat.sh</executable>
  <timeout_allowed>no</timeout_allowed>
</command>

<active-response>
  <command>remove-threat</command>
  <location>local</location>
  <rules_id>87105</rules_id>
</active-response>


and in agent add script  remove-threat.sh and copy that  : 

**Location:** `/var/ossec/active-response/bin/remove-threat.sh`
```bash
#!/bin/bash
read INPUT
FILE=$(echo $INPUT | grep -oP '(?<="file":")[^"]+')
if [ -n "$FILE" ]; then
    rm -f "$FILE"
    echo "$(date) Automated Mitigation: Deleted malicious file $FILE" >> /var/ossec/logs/active-responses.log
fi
