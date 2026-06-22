#!/bin/bash

#1
mkdir -p ~/exam_results/audit
touch ~/exam_results/audit/notes.txt
echo "# pwd ->" > ~/exam_results/audit/cwd.txt
pwd >> ~/exam_results/audit/cwd.txt
#_______________________________________

#2
echo "# user names" > ~/exam_results/audit/users.txt
cut -d: -f1 /etc/passwd >> ~/exam_results/audit/users.txt
echo "# bssh shell" > ~/exam_results/audit/bash_users.txt
grep "/bin/bash" /etc/passwd | cut -d: -f1 >> ~/exam_results/audit/bash_users.txt
echo "# shell change" > ~/exam_results/audit/shell_preview.txt
sed "s#/bin/bash#/usr/bin/zsh#g" /etc/passwd | head -n 5 >> ~/exam_results/audit/shell_preview.txt
#_______________________________________

#3
echo "#system info" > ~/exam_results/audit/sysinfo.txt
uname -srm >> ~/exam_results/audit/sysinfo.txt
# "m" in uname is arch
echo "#group summary" > ~/exam_results/audit/group_summary.txt
head -n 3 /etc/group >> ~/exam_results/audit/group_summary.txt
tail -n 2 /etc/group >> ~/exam_results/audit/group_summary.txt
#_______________________________________

#4
echo "#conf files" > ~/exam_results/audit/conf_files.txt
find /etc -type f -name "*.conf" >> ~/exam_results/audit/conf_files.txt 2>/dev/null
echo "#log files" > ~/exam_results/audit/top_logs.txt
find /var/log -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 >> ~/exam_results/audit/top_logs.txt
# 2>/dev/null for error
#_______________________________________

#5
cp /etc/hosts ~/exam_results/audit/hosts.bak
chmod 600 ~/exam_results/audit/hosts.bak
echo "#hosts perm" > ~/exam_results/audit/hosts_perm.txt
ls -l ~/exam_results/audit/hosts.bak >> ~/exam_results/audit/hosts_perm.txt
#_______________________________________

#6
find ~/exam_results/audit -type f -name "*.txt" ! -name "hosts_perm.txt" ! -name "notes.txt" -delete
#_______________________________________

#---zip---
cd ~/exam_results && zip -r audit.zip audit

