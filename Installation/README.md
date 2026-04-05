Follow these steps to replicate this SOC environment and deploy the custom ruleset.

### 1. Prerequisites
* **Wazuh Manager:** Installed on Ubuntu/CentOS (v4.x recommended).
* **Wazuh Agents:** Installed on Windows 10/11 and Kali Linux/Ubuntu.

### 2. Deploying Custom Rules (The Brain)
1.  Navigate to your Wazuh Manager terminal.
2.  Open the local rules file:


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
chmod +x install_wazuh_docker.sh
sudo ./install_wazuh_docker.sh
</pre>



1. Deployment Options (Choose one)
Option A: Docker Deployment (Fastest)

This script prepares the OS, installs Docker, and starts the Wazuh stack.
    chmod +x install_wazuh_docker.sh
    sudo ./install_wazuh_docker.sh

Option B: Native Installation

Use this for a more stable, long-term deployment on Ubuntu servers.
chmod +x install_wazuh_native.sh
sudo ./install_wazuh_native.sh

2. Endpoint Configuration (Adding Agents) > open File Linux Agent or Windows Agent 
