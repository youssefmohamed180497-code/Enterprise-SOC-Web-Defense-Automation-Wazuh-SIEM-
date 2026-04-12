# Enterprise-SOC-Web-Defense-Automation-Wazuh-SIEM-

### 📌 Project Overview

This project showcases a fully automated Security Operations Center (SOC) built on Wazuh SIEM. It integrates endpoint protection, network monitoring, and web application security into a single pane of glass, mapped to the MITRE ATT&CK framework.

![Wazuh Overview](Screenshots/Overview%20.png)

### 🏗️ Architecture & Lab Setup

* SIEM Stack: Containerized Wazuh (Manager, Indexer, Dashboard).

* Endpoints: Windows Server 2022, Windows 10/11, and Kali Linux.

* Monitored Grouping: Specialized policies for Linux and Windows agents.


### 🚀 Quick Navigation

To get this project running in your environment, follow the dedicated guides below:

* Installation Guide: Automated scripts for Docker and Native deployment.

* Detection Rules: The core ruleset for threat detection.

* Custom Decoders: Logic for parsing specialized log formats.

* External API: VirusTotal (Threat Intelligence)



### 🌐 Web Application Security (WAF Mode)

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
   ![XSS Detection](Screenshots/XSS%20Detected%20GIF.gif)

5. Local File Inclusion (LFI)

    Detection: Captured directory traversal attempts (/etc/passwd).

    Alert: Rule 102020 (Level 12 severity).
   ![LFI](Screenshots/LFI%20Alert.png)
   ![LFI Filter](Screenshots/LFI%20Filter.png)

### 🔍 Threat Intelligence & Malware Analysis

1. VirusTotal Integration

    Workflow: Wazuh automatically extracts file hashes and queries VirusTotal.

    Finding: Detected EICAR test malware with a 66/68 malicious score.
   ![File added](Screenshots/File%20Added%20%26%20Permission.png)
   ![LFI](Screenshots/Hash%20file.png)
   ![LFI](Screenshots/Virus%20total%20hash%20scan.png)
   ![LFI](Screenshots/Virustotal.png)

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



### 📊 Detection Logic Strategy
How I Optimized the 80 Rules:

1-Noise Reduction: By using if_sid and if_group, I ensure that high-level alerts only fire when a baseline of suspicious activity is met. "Implemented parent-child rule relationships to suppress repetitive noise and only escalate verified attack chains.".

2-Severity Scoring: Rules are weighted based on risk. For example, a failed login is Level 5, but a Brute Force Success is Level 12.

3-Cross-Platform Visibility: Rules are designed to cover both Windows (Sysmon) and Linux (Auditd/Suricata) simultaneously.

### ⚠️ Incident Alerting

Critical Alerts: Level 15 alerts trigger automated SMTP email notifications for immediate response.

Resource Monitoring: Real-time alerting on system health and memory exhaustion.
    
### 🚀 Key Use Cases Verified

Malware Detection: Identified the EICAR test string and verified its malicious reputation via VirusTotal.

Exploit Identification: Detected Python-based reverse shells and script-based network activity.

Brute Force Correlation: Successfully flagged automated SSH attacks and account takeover attempts.

### Testing 
* To test the XSS rule, log the version and write `<script>alert("Hacked by Youssef")</script>` after the website URL.
* "To test the SQL Injection rule, type ' OR 1=1 #
* To test the XSS DOM rule, when choose Language and replace Language for this text >  '<script>alert(document.cookie)</script>' .
* Hash theft (Dumping Hashes) - (Rule 101142)  > sudo cat /etc/shadow
* The attacker is trying to find out the usernames on the system: (Run Rule 101141) > cat /etc/passwd OR grep "root" /etc/passwd .
* #Network Scanner  (nmap , masscan, Wireshark ,  tcpdump )  > nmap -sS 127.0.0.1 - masscan 127.0.0.1 -p80 - sudo tcpdump -c 5 -i lo .
* Download Test curl http://google.com - wget http://google.com - for i in {1..6}; do curl http://google.com; sleep 1; done .
* Test Shadow file(Password)  > sudo auditctl -w /etc/shadow -p r -k shadow_access


### 👨‍💻 Author

### Youssef Mohamed
### Cybersecurity / SOC Analyst
### [GitHub Profile](https://github.com/youssefmohamed180497-code)
### www.linkedin.com/in/youssef-mohamed-175464238

I will update rules and decoders if the projects I work on require them.


