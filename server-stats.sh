#!/bin/bash

# https://roadmap.sh/projects/server-stats

## Total CPU Usage
echo "====== Total CPU Usage ======"
top -b -n1 | grep "%Cpu(s)" | cut -d" " -f11 | awk '{print 100 - $1"%"}'
echo

## Total Memory Usage
echo "====== Total Memory Usage ======"
free -m | awk 'NR==2 {printf "Total: %.2lf MB\nFree: %.2lf%%\nUsed: %.2lf%%\n", $2, ($4/$2)*100, ($3/$2)*100}'
echo

## Total disk usage
echo "====== Total Disk Usage ======"
df -h --total | grep 'total' | awk '{printf "Free: %.2lf%%\nUsed: %.2lf%%\n", (100 - $5), $5}'
echo

## Top Processes by CPU Usage
echo "====== Top Processes by CPU Usage ======"
ps aux --sort=-%cpu | head -n6 | awk 'NR==1 {print "USER\t%CPU\tCOMMAND"} NR>1 {printf "%s\t%.2f%%\t%s\n", $1, $3, $11}'
echo

## Top Processes by Memory Usage
echo "====== Top Processes by Memory Usage ======"
ps aux --sort=-%mem | head -n6 | awk 'NR==1 {print "USER\t%MEM\tCOMMAND"} NR>1 {printf "%s\t%.2f%%\t%s\n", $1, $4, $11}'
echo
