# Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-

📌 Project Overview

This project showcases a fully automated Security Operations Center (SOC) built on Wazuh SIEM. It integrates endpoint protection, network monitoring, and web application security into a single pane of glass, mapped to the MITRE ATT&CK framework.
![Wazuh Overview](Screenshots/Overview%20.png)

🏗️ Architecture & Lab Setup

SIEM Stack: Containerized Wazuh (Manager, Indexer, Dashboard).

Endpoints: Windows Server 2022, Windows 10/11, and Kali Linux.

Monitored Grouping: Specialized policies for Linux and Windows agents.

🌐 Web Application Security (WAF Mode)

I integrated DVWA (Damn Vulnerable Web App) to simulate and detect real-world web attacks.
1. SQL Injection (SQLi)

    Detection: Identified malicious SQL payloads in Apache logs.

    Alert: Rule 31164 - SQL injection attempt.
   ![SQL injection](Screenshots/SQL%20Injection.png)

3. Cross-Site Scripting (XSS)

    Scenarios: Reflected and DOM-based XSS attacks.

    Custom Rule: Developed Rule 102010 (Level 10) for high-accuracy XSS detection.

    Alert: Rule 102010 - XSS attempt detected.
   ![XSS](Screenshots/XSS%20Reflected%20%26%20DOM.png)

4. Local File Inclusion (LFI)

    Detection: Captured directory traversal attempts (/etc/passwd).

    Alert: Rule 102020 (Level 12 severity).
   ![LFI](Screenshots/LFI%20Alert.png)
   ![LFI Filter](Screenshots/LFI%20Filter.png)

🔍 Threat Intelligence & Malware Analysis

1. VirusTotal Integration

    Workflow: Wazuh automatically extracts file hashes and queries VirusTotal.

    Finding: Detected EICAR test malware with a 66/68 malicious score.
   ![File added](Screenshots/File%20Added%20%26%20Permission.png)
   ![LFI](Screenshots/Hash%20file.png)
   ![LFI](Screenshots/Virus%20total%20hash%20scan.png)

3.  MITRE ATT&CK® Framework Mapping

All custom rules and alerts are mapped to MITRE ATT&CK techniques (e.g., Persistence, Privilege Escalation, Brute Force), allowing for a standardized understanding of adversary behavior.

| Rule ID Range | MITRE Technique | Tactic |
| :--- | :--- | :--- |
| **100041 - 100046** | T1546, T1547 | Persistence |
| **100100 - 100152** | T1110, T1078 | Initial Access |
| **100200 - 100400** | T1003, T1055 | Credential Access, Defense Evasion |
| **100600** | T1091 | Initial Access (Replication Through Removable Media) |
| **101100 - 101191** | T1620, T1611 | Defense Evasion, Privilege Escalation |
| **101200 - 101262** | T1110, T1114 | Initial Access, Collection |
| **101310** | T1021, T1071 | Command and Control (Non-TTY Session) |
| **101320 - 101322** | T1548 | Privilege Escalation (Sudo/Abuse) |
| **101330 - 101332** | T1136 | Persistence (Create Account) |
| **101340 - 101341** | T1222 | Defense Evasion (File Permissions) |
| **101400 - 101440** | T1014, T1564 | Defense Evasion (Rootkit/Hidden Files) |
| **101500 - 101511** | T1021, T1570 | Lateral Movement |
| **102010 - 102030** | T1059, T1190 | Execution, Initial Access (Web Attacks) |

🛡️ Advanced Detection Logic (The Brain)

My custom ruleset consists of 80+ specialized detection rules, designed to reduce false positives and provide high-fidelity alerts. These rules are mapped to the MITRE ATT&CK matrix, covering the full attack lifecycle.

| Group (Category) |Rules Numbers (Count) |  IDs (Range) |
| :--- | :---: | :--- |
| **FIM File Operations** | 5 | 100041 - 100046 |
| **Remote Access Monitoring (RDP & SSH)** | 6 | 100100 - 100152 |
| **Windows Advanced Threats** | 8 | 100200 - 100400 |
| **USB Monitoring** | 1 | 100600 |
| **Auditd Advanced Rules** | 15 | 101100 - 101191 |
| **Fraud Detection** | 20 | 101200 - 101262 |
| **Session Anomalies** | 1 | 101310 |
| **Sudo/Privilege Escalation** | 3 | 101320 - 101322 |
| **User Account Changes** | 3 | 101330 - 101332 |
| **Group/Permission Changes** | 2 | 101340 - 101341 |
| **File Integrity & System Integrity** | 11 | 101400 - 101440 |
| **Network Security & Lateral Movement** | 2 | 101500 - 101511 |
| **Web Security** | 2 | 102010 - 102020 |

1. FIM File Operations (6 Rules)

   | Rule ID | Name | Description | Severity |
| :--- | :--- | :--- | :---: |
| **100041** | Critical File Modified | Detects changes to `/etc/passwd`, `/etc/shadow`, system binaries | 13 |
| **100042** | SUID Binary Added | New SUID/SGID file detected (Potential privilege escalation) | 12 |
| **100043** | Web Shell Upload | PHP/JSP/ASPX file uploaded to web directories | 14 |
| **100044** | Cron Persistence | New cron job added to system or user crontabs | 11 |
| **100045** | Startup Script Modified | Changes to `/etc/rc.local`, systemd services, init.d | 10 |
| **100046** | SSH Key Authorized_keys | New SSH key added to `authorized_keys` file | 12 | 

2. Remote Access Monitoring - RDP & SSH (5 Rules)


   | Rule ID | Name | Description | Severity |
| :--- | :--- | :--- | :---: |
| **100100** | RDP Brute Force | 5+ failed RDP logins within 5 minutes | 10 |
| **100101** | RDP Successful After Brute | Successful RDP login after multiple failures (Account Takeover) | 12 |
| **100150** | SSH Connection from New Country | SSH login from geolocation not seen in 30 days | 8 |
| **100151** | SSH Off-Hours Login | SSH login outside business hours (weekend/night) | 6 |
| **100152** | SSH Root Login Enabled | Direct root login via SSH detected | 14 |


4. Windows Advanced Threats (8 Rules)

   | Rule ID | Name | Description | Severity |
| :--- | :--- | :---: | :---: |
| **100200** | LSASS Memory Access | Process attempting to access `lsass.exe` (Mimikatz style) | 15 |
| **100201** | SAM Database Dump | Attempt to read SAM/SYSTEM/SECURITY registry hives | 15 |
| **100202** | PowerShell Obfuscation | Base64 encoded or obfuscated PowerShell commands detected | 12 |
| **100203** | WMI Event Subscription | Persistence via WMI event consumer insertion | 11 |
| **100204** | Scheduled Task Creation | New scheduled task created via `schtasks` or XML | 9 |
| **100205** | Service Creation | New Windows service installed (Persistence/Privilege Escalation) | 10 |
| **100206** | Process Injection | Detects `CreateRemoteThread` or Process Hollowing techniques | 14 |
| **100400** | DCsync Attack | Directory Replication Service access from a non-Domain Controller | 15 |







📊 Detection Logic Strategy
How I Optimized the 80 Rules:

1-Noise Reduction: By using if_sid and if_group, I ensure that high-level alerts only fire when a baseline of suspicious activity is met. "Implemented parent-child rule relationships to suppress repetitive noise and only escalate verified attack chains.".

2-Severity Scoring: Rules are weighted based on risk. For example, a failed login is Level 5, but a Brute Force Success is Level 12.

3-Cross-Platform Visibility: Rules are designed to cover both Windows (Sysmon) and Linux (Auditd/Suricata) simultaneously.

⚠️ Incident Alerting

Critical Alerts: Level 15 alerts trigger automated SMTP email notifications for immediate response.

Resource Monitoring: Real-time alerting on system health and memory exhaustion.
    
🚀 Key Use Cases Verified

Malware Detection: Identified the EICAR test string and verified its malicious reputation via VirusTotal.

Exploit Identification: Detected Python-based reverse shells and script-based network activity.

Brute Force Correlation: Successfully flagged automated SSH attacks and account takeover attempts.


I will update rules and decoders if the projects I work on require them.
