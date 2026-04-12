### Integrate Virustotal 

* Add this block to file ossec.conf in path /var/ossec.conf

```xml
<integration>
  <name>virustotal</name>
  <api_key>YOUR_VIRUSTOTAL_API_KEY</api_key>
  <group>syscheck</group>
  <alert_format>json</alert_format>
</integration>




