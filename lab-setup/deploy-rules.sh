#!/usr/bin/env bash
# Copy the custom decoder and rules to the Wazuh server, validate, and restart.
# Run from the repo root on the Wazuh server: sudo bash lab-setup/deploy-rules.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OSSEC=/var/ossec

if [[ $EUID -ne 0 ]]; then
  echo "Run as root." >&2
  exit 1
fi

ts=$(date +%Y%m%d%H%M%S)
cp "$OSSEC/etc/decoders/local_decoder.xml" "$OSSEC/etc/decoders/local_decoder.xml.bak.$ts" 2>/dev/null || true
cp "$OSSEC/etc/rules/local_rules.xml"     "$OSSEC/etc/rules/local_rules.xml.bak.$ts"     2>/dev/null || true

install -o wazuh -g wazuh -m 660 "$REPO_DIR/decoders/local_decoder.xml" "$OSSEC/etc/decoders/local_decoder.xml"
install -o wazuh -g wazuh -m 660 "$REPO_DIR/rules/local_rules.xml"     "$OSSEC/etc/rules/local_rules.xml"

systemctl restart wazuh-manager
sleep 5
systemctl is-active --quiet wazuh-manager && echo "wazuh-manager restarted OK." || {
  echo "Manager failed to start - check $OSSEC/logs/ossec.log. Backups saved with suffix .bak.$ts" >&2
  exit 1
}

echo "Test with: sudo $OSSEC/bin/wazuh-logtest < $REPO_DIR/tests/myapp_sample.log"
