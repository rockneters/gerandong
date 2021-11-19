#!/bin/bash
source /var/lib/premium-script/settvps.conf
echo "Permission Accepted"
sleep 1
clear

uuid=$(cat /etc/trojan/uuid.txt)
#tr="$(cat ~/log-install.txt | grep -i Trojan | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "Password: " -e user
		user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Expired (days): " masaaktif
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
exp=`date -d "$masaaktif days" +"%d-%m-%Y"`
created=`date -d "0 days" +"%d-%m-%Y"`
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
echo "Masa Aktif : $masaaktif Hari"
echo "Expaired   : $expe"
echo "==========================" | lolcat
echo "${PESAN}"
echo ""