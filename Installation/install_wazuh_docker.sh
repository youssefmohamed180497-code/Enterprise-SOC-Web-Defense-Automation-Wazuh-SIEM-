# =================================================================
# Script Name: install_wazuh_docker.sh
# Author: Youssef Mohamed
# Description: Automated Docker & Wazuh SIEM Installation
# =================================================================

# 1. Update system and install dependencies
sudo apt update -y
sudo apt install -y curl git apt-transport-https ca-certificates software-properties-common

# 2. Install Docker & Docker Compose
sudo apt install -y docker.io docker-compose-plugin

# 3. Configure System Limits (Required for Wazuh Indexer/Elasticsearch)
# Without this, the Indexer container will fail to start.
sudo sysctl -w vm.max_map_count=262144

# 4. Clone Wazuh Docker Repository (Stable Version)
cd ~
if [ -d "wazuh-docker" ]; then
    sudo rm -rf wazuh-docker
fi
git clone https://github.com/wazuh/wazuh-docker.git -b v4.7.2
cd wazuh-docker/single-node

# 5. Generate SSL Certificates
sudo docker compose -f generate-indexer-certs.yml run --rm generator

# 6. Start Wazuh Containers
sudo docker compose up -d

# 7. Final Check
echo "-------------------------------------------------------"
echo "Installation Complete!"
echo " Access your dashboard at: https://$(hostname -I | awk '{print $1}')"
echo " Username: admin"
echo " Password: SecretPassword"
echo "-------------------------------------------------------"
echo "Note: It may take 1-2 minutes for all services to start."
