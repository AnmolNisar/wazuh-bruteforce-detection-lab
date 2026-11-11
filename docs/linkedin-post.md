# LinkedIn post template

Fill in the brackets with your real results. Attach 2–4 screenshots (alert view, MITRE view, active-response block) or a short screen recording.

---

I built a home SOC lab to learn how detection engineering works in practice.

Using Wazuh (open-source SIEM/XDR), I set up a server, a victim VM and an attacker VM on an isolated network, then:

🔹 Wrote a custom decoder and rules to parse a custom application log
🔹 Built a correlation rule that flags 5+ failed logins from one IP in 60 seconds (MITRE T1110.001)
🔹 Added alerts for root and off-hours SSH logins (T1078)
🔹 Configured active response to block the attacker's IP automatically
🔹 Tested everything with wazuh-logtest and simulated attacks

Biggest lesson: [e.g. how much a rule's level and timeframe change the noise you see].
Next up: [File Integrity Monitoring / Windows + Sysmon detections].

Code, rules and setup steps are on GitHub: [link]

#Wazuh #SIEM #SOC #BlueTeam #CyberSecurity #DetectionEngineering #HomeLab

---

## Profile tips
- Add the repo under **Featured** on your profile and under **Projects** with the skills: Wazuh, SIEM, Detection Engineering, Linux.
- Pin the repo on your GitHub profile; add topics `wazuh`, `siem`, `blue-team`, `homelab`, `detection-engineering`.
- Post each new project as its own update; one project every 1–2 weeks keeps momentum.
