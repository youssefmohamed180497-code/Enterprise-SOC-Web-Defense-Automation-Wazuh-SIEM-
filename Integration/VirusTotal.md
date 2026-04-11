#add this text to /var/ossec/etc/ossec.conf
<ossec_config>
  <integration>
    <name>virustotal</name>
    <api_key>API Key</api_key>
    <group>syscheck</group>
    <alert_format>json</alert_format>
  </integration>
</ossec_config>

