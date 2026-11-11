#!/usr/bin/env bash
# Write fake "myapp" login events to /var/log/myapp.log on the victim VM
# so the Wazuh agent picks them up.
# Usage: sudo bash generate_app_logs.sh [attacker_ip] [failures]
set -euo pipefail

SRC_IP="${1:-192.168.56.20}"
FAILS="${2:-8}"
LOG=/var/log/myapp.log
HOST=$(hostname)

log() { echo "$(date '+%b %e %H:%M:%S') $HOST myapp[4242]: $1" >> "$LOG"; }

touch "$LOG"
log "LOGIN_SUCCESS user=bob src_ip=192.168.56.15"
for i in $(seq 1 "$FAILS"); do
  log "LOGIN_FAILED user=admin src_ip=$SRC_IP"
  sleep 1
done

echo "Wrote $((FAILS + 1)) events to $LOG. Expect rule 100113 for $SRC_IP."
