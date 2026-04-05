#!/bin/bash

# =================================================================
# Script Name: install_wazuh_native.sh
# Author: Youssef Mohamed
# Description: Automated Wazuh Native Installation (All-in-one)
# =================================================================

# 1. Update and install dependencies
sudo apt update -y
sudo apt install -y curl apt-transport-https ca-certificates gnupg2

# 2. Download the official Wazuh installation script
curl -sO https://packages.wazuh.com/4.7/wazuh-install.sh

# 3. Run the installation script with the -a (All-in-one) flag
# This will install: Indexer, Manager, and Dashboard on the same node.
sudo bash ./wazuh-install.sh -a

