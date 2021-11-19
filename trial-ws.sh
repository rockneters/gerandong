#!/bin/bash
source /var/lib/premium-script/settvps.conf
clear

read -rp "Bug: " -e bug
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
user=trial-`</dev/urandom tr -dc X-Z0-9 | head -c3`
uuid=$(cat /proc/sys/kernel/random/uuid)
tnggl=$(date +"%R")
read -p "Expired (Jam): " ktf
exp=`date -d "$ktf hour" +"%R"`
#expd=date -d "0 days" +"%d-%m-%Y"
#exp=date -d "$ktf hour" +"%R"
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"2"',"email": "'""$user""'"' /etc/v2ray/config.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"2"',"email": "'""$user""'"' /etc/v2ray/none.json
cat>/etc/v2ray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "2",
      "net": "ws",
      "path": "geo",
      "type": "none",
      "host": "${bug}",
      "tls": "tls"
}
EOF
cat>/etc/v2ray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${bug}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "2",
      "net": "ws",
      "path": "geo",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /etc/v2ray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /etc/v2ray/$user-none.json)"
systemctl restart v2ray
systemctl restart v2ray@none
service cron restart
clear
echo -e "Sukses..!"
echo "==========================" | lolcat
echo -e "$OWNER    "
echo -e "  TRIAL V2RAY VMESS    "
echo "==========================" | lolcat
echo -e "ISP            : ${ISP}"
echo -e "CITY           : ${CITY}"
echo -e "Remarks        : ${user}"
echo -e "Bug            : ${bug}"
echo -e "Domain         : ${domain}"
echo -e "Port TLS       : ${tls}"
echo -e "Port NON-TLS   : ${none}"
echo -e "ID             : ${uuid}"
echo -e "AlterID        : 2"
echo -e "Security       : auto"
echo -e "Network        : ws"
echo -e "Path           : /geo"
echo "--------------------------" | lolcat
echo -e "VMESS TLS :"
echo -e "${vmesslink1}"
echo "--------------------------" | lolcat
echo -e "VMESS NON-TLS :"
echo -e "${vmesslink2}"
echo "--------------------------" | lolcat
echo -e "Masa Aktif     : $ktf Jam"
echo -e "Expaired       : $exp WIB"
echo "==========================" | lolcat
echo -e "$PESAN"
echo -e ""