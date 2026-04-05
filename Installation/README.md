Follow these steps to replicate this SOC environment and deploy the custom ruleset.

### 1. Prerequisites
* **Wazuh Manager:** Installed on Ubuntu/CentOS (v4.x recommended).
* **Wazuh Agents:** Installed on Windows 10/11 and Kali Linux/Ubuntu.

### 2. Deploying Custom Rules (The Brain)
* Navigate to your Wazuh Manager terminal.
* Open the local rules file:

### 3. Deploying Custom Decoders
* To ensure Wazuh correctly parses non-standard logs, you must apply the custom decoders included in this project.

  

🚀Automated Deployment : 

1-Install Wazuh Manager inside Container 
Copy the code below and paste it directly into your terminal:

<pre>
curl -sO [https://raw.githubusercontent.com/youssefmohamed180497-code/Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-/main/installation/install_wazuh_docker.sh](https://raw.githubusercontent.com/youssefmohamed180497-code/Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-/main/installation/install_wazuh_docker.sh)
chmod +x install_wazuh_docker.sh
sudo ./install_wazuh_docker.sh
</pre>

2-Install Wazuh Manager Native
Copy the code below and paste it directly into your terminal:

<pre>
curl -sO [https://raw.githubusercontent.com/youssefmohamed180497-code/Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-/main/installation/install_wazuh_native.sh](https://raw.githubusercontent.com/youssefmohamed180497-code/Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-/main/installation/install_wazuh_native.sh)
chmod +x install_wazuh_native.sh.sh
sudo ./install_wazuh_native.sh.sh
</pre>


3- Endpoint Configuration (Adding Agents) > open File Linux Agent or Windows Agent 


4- Download and apply the custom ruleset
<pre>
sudo curl -so /var/ossec/etc/rules/local_rules.xml https://raw.githubusercontent.com/youssefmohamed180497-code/Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-/main/rules/local_rules.xml
</pre>

5- Fix permissions
<pre>
sudo chown wazuh:wazuh /var/ossec/etc/rules/local_rules.xml
sudo chmod 660 /var/ossec/etc/rules/local_rules.xml
</pre>

6- Apply Decoders to Wazuh Manager
<pre>
# Download and apply the custom decoder
sudo curl -so /var/ossec/etc/decoders/local_decoder.xml https://raw.githubusercontent.com/youssefmohamed180497-code/Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-/main/decoders/local_decoder.xml

# Fix permissions
sudo chown wazuh:wazuh /var/ossec/etc/decoders/local_decoder.xml
sudo chmod 660 /var/ossec/etc/decoders/local_decoder.xml
</pre>

