#!/bin/bash
clear
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
IP=$(wget -qO- icanhazip.com);
domain="$(cat /etc/v2ray/domain)"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

Login=trial-`</dev/urandom tr -dc X-Z0-9 | head -c3`
read -p "Expired (Jam): " xpjam
Pass=1234
masaaktif=1
exp1=`date -d "$xpjam hour" +"%R"`

useradd -e `date -d "$xpjam hour" +"%R"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null

echo "#SSH $Login $exp1 $Pass" >> /etc/akun.conf
echo ""
read -p "Select 1 for Non-GCP and 2 for GCP :  " pilih
case $pilih in
1)
clear
echo ""
echo "Sukses !"
echo "==============================" | lolcat
echo "    • ROCKNET STORE | VPN • "
echo "   SSH Account Configuration"
echo "==============================" | lolcat
echo "Username     : $Login "
echo "Password     : $Pass"
echo "Masa Aktif   : $xpjam Jam"
echo "Aktif Sampai : $exp1 WIB"
echo "==============================" | lolcat
echo "Host         : $domain"
echo "IP           : $IP"
echo "ISP          : $ISP"
echo "City         : $CITY"
echo "==============================" | lolcat
echo "OpenSSH      : 22"
echo "Dropbear     : 109, 143"
echo "SSL/TLS      : 443, 777, 222"
echo "SSLH         : 443"
echo "Port WS SSL  : 443"
echo "Port WS HTTP : 2095"
echo "Port WS OVPN : 2082"
echo "Badvpn/Udpgw : 7100-7300"
echo "Port Squid   : 3128, 8080"
echo "==============================" | lolcat
echo "Payload SSH Websocket"                                                          
echo "GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo "==============================" | lolcat
echo "Download FIle OpenVPN"
echo "OpenVPN TCP  : http://$IP:85/tcp.ovpn"
echo "OpenVPN UDP  : http://$IP:85/udp.ovpn"
echo "OpenVPN SSL  : http://$IP:85/ssl.ovpn" 
echo "==============================" | lolcat
echo "Terimakasih"
echo ""
;;
2)
echo ""
read -p "Sub Domain GCP : " dgcp
read -p "Port GCP : " pgcp
clear
echo ""
echo "Sukses !"
echo "==============================" | lolcat
echo "    • ROCKNET STORE | VPN • "
echo "==============================" | lolcat
echo "SSH Account Configuration"
echo "Username    : $Login "
echo "Password    : $Pass"
echo "Masa Aktif  : $xpjam Jam"
echo "Expired     : $exp1"
echo "==============================" | lolcat
echo "Host        : ${dgcp}.rocknetvpn.my.id"
echo "Port        : $pgcp"
echo "BadVPN      : $badvpn"
echo "==============================" | lolcat
echo "Terimakasih"
echo ""
;;
*)
read -p "Select 1 for Non-GCP and 2 for GCP :  " pilih
;;
esac
