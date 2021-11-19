#!/bin/bash
source /var/lib/premium-script/settvps.conf
echo "Permission Accepted"
sleep 1
clear

uuid=$(cat /etc/trojan/uuid.txt)
user1=trial-`</dev/urandom tr -dc X-Z0-9 | head -c3`
#tr="$(cat ~/log-install.txt | grep -i Trojan | cut -d: -f2|sed 's/ //g')"
tnggl=$(date +"%R")
read -p "Expired (Jam): " masaaktif
exp=`date -d "$masaaktif hour" +"%R"`
user=-e $user1
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
#exp=`date -d "$masaaktif days" +"%d-%m-%Y"`
#created=`date -d "0 days" +"%d-%m-%Y"`
echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
trojanlink="trojan://${user}@${domain}:${tr}"
clear

echo "Success!"
echo "==========================" | lolcat
echo "${OWNER}"
echo "        • TROJAN •        "
echo "==========================" | lolcat
echo "Remarks    : ${user}"
echo "Host       : ${domain}"
echo "IP         : ${IP}"
echo "port       : ${tr}"
echo "Key        : ${user}"
echo "link       : ${trojanlink}"
echo "==========================" | lolcat
echo "Masa Aktif : $masaaktif Jam"
echo "Expaired   : $exp WIB"
echo "==========================" | lolcat
echo "${PESAN}"
echo ""