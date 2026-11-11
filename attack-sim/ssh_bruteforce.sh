#!/usr/bin/env bash
# Generate failed SSH logins against YOUR OWN lab victim VM to trigger Wazuh rules
# 5710 / 5760 and the brute-force rules 5712 / 5763.
# Usage: bash ssh_bruteforce.sh <victim_ip> [attempts]
# Requires: sshpass  (sudo apt install sshpass)
# LAB USE ONLY - never point this at systems you don't own.
set -uo pipefail

TARGET="${1:?Usage: $0 <victim_ip> [attempts]}"
ATTEMPTS="${2:-12}"
USERS=(admin test oracle fakeuser root)

command -v sshpass >/dev/null || { echo "Install sshpass first: sudo apt install sshpass"; exit 1; }

for i in $(seq 1 "$ATTEMPTS"); do
  u=${USERS[$((i % ${#USERS[@]}))]}
  echo "[$i/$ATTEMPTS] trying $u@$TARGET"
  sshpass -p "wrong-password-$i" ssh \
    -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
    -o ConnectTimeout=5 -o PreferredAuthentications=password \
    "$u@$TARGET" exit 2>/dev/null
  sleep 1
done

echo "Done. Check the Wazuh dashboard for rules 5712/5763 and an active-response block."
