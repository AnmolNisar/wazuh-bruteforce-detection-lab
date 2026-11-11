#!/usr/bin/env bash
# Install and enroll a Wazuh agent on Ubuntu/Debian.
# Usage: sudo WAZUH_MANAGER=192.168.56.10 bash install-agent-linux.sh
# Tip: the dashboard's "Deploy new agent" page generates an exact command for your version too.
set -euo pipefail

: "${WAZUH_MANAGER:?Set WAZUH_MANAGER to the Wazuh server IP}"
WAZUH_AGENT_NAME="${WAZUH_AGENT_NAME:-$(hostname)}"

if [[ $EUID -ne 0 ]]; then
  echo "Run as root." >&2
  exit 1
fi

apt-get update -y
apt-get install -y curl gnupg apt-transport-https

curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH \
  | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import
chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" \
  > /etc/apt/sources.list.d/wazuh.list

apt-get update -y
WAZUH_MANAGER="$WAZUH_MANAGER" WAZUH_AGENT_NAME="$WAZUH_AGENT_NAME" apt-get install -y wazuh-agent

systemctl daemon-reload
systemctl enable --now wazuh-agent

# Stop accidental upgrades that could mismatch the manager version
sed -i 's/^deb/#deb/' /etc/apt/sources.list.d/wazuh.list
apt-get update -y

echo "Agent '$WAZUH_AGENT_NAME' installed and pointed at $WAZUH_MANAGER."
