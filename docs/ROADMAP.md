# Wazuh Learning Roadmap (beginner → portfolio)

About 6–8 weeks at 5–7 hours/week. Each phase ends with something you can push to GitHub.

## Phase 0 — Foundations (week 1)
- Linux basics: systemd, `journalctl`, `/var/log`, permissions, `grep`/`tail -f`.
- Networking: IPs, ports, SSH, firewalls (`iptables`/`ufw`).
- Security concepts: SIEM vs EDR vs XDR, alert levels, false positives, MITRE ATT&CK.
- Set up VirtualBox with a host-only network.

## Phase 1 — Install and explore (week 2)
- All-in-one install (`lab-setup/install-manager.sh`) and one Linux agent.
- Learn the components: **agent → manager (analysisd, decoders, rules) → indexer → dashboard**.
- Tour the dashboard: Threat Hunting, MITRE ATT&CK, FIM, Configuration Assessment, Vulnerability Detection.
- Read: `/var/ossec/etc/ossec.conf`, `/var/ossec/logs/alerts/alerts.json`, `/var/ossec/logs/ossec.log`.

## Phase 2 — Decoders and rules (weeks 3–4) → **Project 1 (this repo)**
- How decoders extract fields, how rules match on them, `if_sid`, `frequency`/`timeframe`.
- Use `wazuh-logtest` constantly.
- Active response with `firewall-drop`.

## Phase 3 — Core modules (weeks 5–6) → Projects 2–4
- File Integrity Monitoring, SCA (CIS benchmarks), Vulnerability Detection, Windows agent + Sysmon.

## Phase 4 — Integrations and automation (weeks 7–8) → Projects 5–6
- Integrations (Slack/Discord/VirusTotal), Wazuh REST API with Python.

---

## Project ideas (in order)

| # | Repo name | What you build | Key skills |
|---|---|---|---|
| 1 | `wazuh-bruteforce-detection-lab` | **This repo.** SSH + custom app brute-force detection, custom decoder/rules, active response | Decoders, rules, correlation, AR |
| 2 | `wazuh-fim-ransomware-sim` | FIM with `realtime="yes"` + `report_changes` on a folder; a script that mass-renames/encrypts dummy files; a frequency rule on FIM events (rule 550/554) to flag ransomware-like behaviour | FIM, frequency rules |
| 3 | `wazuh-windows-sysmon-detections` | Windows 10/11 agent + Sysmon; rules for suspicious PowerShell (encoded commands), new local admin (Event ID 4732), etc.; test with Atomic Red Team tests in the lab | Windows logs, Sysmon, ATT&CK |
| 4 | `wazuh-cis-hardening-report` | Run SCA on an Ubuntu agent, record the score, fix 10–15 failed checks, re-scan, document before/after | SCA, hardening |
| 5 | `wazuh-virustotal-discord-alerts` | VirusTotal integration on FIM events + a custom Python integration that sends level ≥ 10 alerts to Discord/Slack | Integrations, Python |
| 6 | `wazuh-api-alert-reporter` | Python script using the Wazuh API / indexer to pull last 24 h alerts and output a summary report (top rules, top agents, top source IPs) | REST API, automation |

Each repo should have: architecture diagram, setup steps, the config/rules, a test procedure, screenshots, MITRE mapping, and a "What I learned" section.

## Free resources
- Wazuh docs: https://documentation.wazuh.com/current/
- Wazuh proof-of-concept guide (great project inspiration): https://documentation.wazuh.com/current/proof-of-concept-guide/
- Wazuh ruleset on GitHub (read real rules): https://github.com/wazuh/wazuh/tree/main/ruleset
- MITRE ATT&CK: https://attack.mitre.org
- Atomic Red Team: https://github.com/redcanaryco/atomic-red-team
- Wazuh community Slack and the Wazuh YouTube channel
