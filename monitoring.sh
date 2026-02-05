#!/bin/bash

ARCHITECTURE=$(uname -a)
PHYSICAL_CPU=$(grep "physical id" /proc/cpuinfo | wc -l)
VIRTUAL_CPU=$(grep "processor" /proc/cpuinfo | wc -l)
RAM_USED=$(free --mega | awk '$1 == "Mem:" {print $3}')
RAM_TOTAL=$(free --mega | awk '$1 == "Mem:" {print $2}')
RAM_PERCENT=$(free --mega | awk '$1 == "Mem:" {printf("%.2f", $3/$2*100)}')
DISC_USED=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{memory += $3} END {print memory}')
DISC_TOTAL=$(df -m | grep "/dev" | grep -v "/boot" | awk '{total += $2} END {printf("%.1f", total/1024)}')
DISC_PERCENT=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{use += $3} {total += $2} END {printf("%.2f", use/total*100)}')
CPU_IDLE=$(vmstat 1 4 | tail -1 | awk '{print $15}')
CPU_LOAD=$(awk "BEGIN {printf(\"%.1f%%\", 100 -$CPU_IDLE)}")
LAST_BOOT=$(who -b | awk '{print $3 " " $4}')
LVM_USE=$(lsblk | grep -q lvm && echo yes || echo no)
TCP_CONN=$(ss -ta | grep ESTAB | wc -l)
USER_COUNT=$(users | wc -w)
IP_ADDR=$(hostname -I | awk '{print $1}')
MAC_ADDR=$(ip link | grep "link/ether" | awk '{print $2}')
SUDO_CMDS=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "Architecture: $ARCHITECTURE
Physical CPU: $PHYSICAL_CPU
Virtual CPU: $VIRTUAL_CPU
Memory Usage: $RAM_USED/$RAM_TOTAL MB $RAM_PERCENT
Disk Usage $DISC_USED/${DISC_TOTAL}GB $DISC_PERCENT
CPU load: $CPU_LOAD
Last boot: $LAST_BOOT
LVM use: $LVM_USE
TCP Connections: $TCP_CONN ESTABLISHED
Users logged in: $USER_COUNT
Network: IP $IP_ADDR ($MAC_ADDR)
Sudo: $SUDO_CMDS cmd
"
