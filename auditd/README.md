The Auditd is the one that writes in the /var/log/audit/audit.log file

sudo apt install auditd -y

sudo systemctl enable auditd

sudo systemctl start auditd
