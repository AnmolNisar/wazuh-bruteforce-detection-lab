#!/usr/bin/env bash
# All-in-one Wazuh server install (manager + indexer + dashboard) on Ubuntu.
# Check https://documentation.wazuh.com/current/quickstart.html for the current
# version and set WAZUH_VERSION to its major.minor (e.g. 4.14).
set -euo pipefail

WAZUH_VERSION="${WAZUH_VERSION:-4.14}"

if [[ $EUID -ne 0 ]]; then
  echo "Run as root: sudo bash $0" >&2
  exit 1
fi

apt-get update -y
apt-get install -y curl

cd /tmp
curl -sO "https://packages.wazuh.com/${WAZUH_VERSION}/wazuh-install.sh"
bash wazuh-install.sh -a

echo
echo "Done. Dashboard: https://$(hostname -I | awk '{print $1}')"
echo "The admin password is printed above and stored in wazuh-install-files.tar"
echo "  sudo tar -O -xvf /tmp/wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt"
