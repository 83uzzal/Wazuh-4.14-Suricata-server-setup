#!/bin/bash
# ============================================================
# Wazuh 4.14 All-in-One + Suricata Server Installation Script
# For Ubuntu 22.04 / 24.04
# Server-only (Manager + Dashboard + Indexer)
# Suricata installed with fanout fix and rules update
# Dashboard credentials displayed after installation
# ============================================================

set -euo pipefail

log() { echo -e "\n[INFO] $1"; }

# ---------------------------
# Detect server IP and primary network interface
# ---------------------------
SERVER_IP=$(hostname -I | awk '{print $1}')
PRIMARY_IF=$(ip route | awk '/default/ {print $5; exit}')
log "Detected Server IP: $SERVER_IP"
log "Detected Network Interface: $PRIMARY_IF"

# ---------------------------
# System update
# ---------------------------
log "Updating system"
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y curl gnupg apt-transport-https software-properties-common

# ---------------------------
# Install Wazuh 4.14 (All-in-One)
# ---------------------------
log "Downloading Wazuh installer"
curl -sO https://packages.wazuh.com/4.14/wazuh-install.sh
log "Installing Wazuh (All-in-One)"
sudo bash wazuh-install.sh -a | tee /tmp/wazuh-install.log

# Extract Dashboard credentials from installer log
DASH_USER=$(grep -m1 "User:" /tmp/wazuh-install.log | awk '{print $2}')
DASH_PASS=$(grep -m1 "Password:" /tmp/wazuh-install.log | awk '{print $2}')

# ---------------------------
# Install Suricata
# ---------------------------
log "Installing Suricata"
sudo apt install -y suricata libpcap0.8

# Fix af-packet fanout issue
sudo sed -i "s|interface: .*|interface: $PRIMARY_IF|" /etc/suricata/suricata.yaml
sudo sed -i "/af-packet:/,+5 s/cluster-type:.*/cluster-type: cluster_none/" /etc/suricata/suricata.yaml
sudo sed -i "/af-packet:/,+5 s/cluster-id:.*/cluster-id: 99/" /etc/suricata/suricata.yaml

# Update Suricata rules
log "Updating Suricata rules"
sudo suricata-update

# Set default-rule-path and rule-files
sudo sed -i 's|^default-rule-path:.*|default-rule-path: /var/lib/suricata/rules|' /etc/suricata/suricata.yaml

sudo sed -i '/^rule-files:/,$d' /etc/suricata/suricata.yaml

sudo tee -a /etc/suricata/suricata.yaml > /dev/null <<'EOF'

rule-files:
  - "*.rules"
EOF


# ---------------------------
# Integrate Suricata eve.json logs with Wazuh
# Insert AFTER journald localfile (safe & idempotent)
# ---------------------------

OSSEC_CONF="/var/ossec/etc/ossec.conf"

SURICATA_BLOCK=$(cat <<'EOF'

  <localfile>
    <log_format>json</log_format>
    <location>/var/log/suricata/eve.json</location>
  </localfile>
EOF
)

# Add only if not already present
if ! grep -q "/var/log/suricata/eve.json" "$OSSEC_CONF"; then
    sudo sed -i "/<location>journald<\/location>/a $SURICATA_BLOCK" "$OSSEC_CONF"
fi





# Enable & start Suricata service
sudo systemctl daemon-reload
sudo systemctl enable suricata
sudo systemctl restart suricata
sudo systemctl status suricata --no-pager

# ---------------------------
# Final Output
# ---------------------------
log "INSTALLATION COMPLETED SUCCESSFULLY"
echo "==========================================="
echo " WAZUH DASHBOARD ACCESS INFORMATION"
echo "==========================================="
echo " URL      : https://$SERVER_IP"
echo " Username : $DASH_USER"
echo " Password : $DASH_PASS"
echo "==========================================="
echo "Suricata Interface : $PRIMARY_IF"
echo "Suricata rules updated and service running"
