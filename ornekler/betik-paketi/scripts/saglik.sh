#!/usr/bin/env bash
# saglik.sh: salt okunur sağlık özeti (hedef sunucuda çalışır; hiçbir şeyi değiştirmez).
set -u
disk=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')
yuk=$(cut -d' ' -f1 /proc/loadavg)
if [ -e /var/run/reboot-required ]; then reboot=evet; else reboot=hayir; fi
echo "Disk (/): %$disk · yük: $yuk · yeniden başlatma gerekli: $reboot"
echo "SSHPOCKET_RESULT ornek-betik.saglik disk_yuzde=$disk yuk=$yuk yeniden_baslat=$reboot"
