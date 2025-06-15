#!/bin/bash

# Show banner
echo -e "\033[1;34m"  # Biru terang
echo " ███╗   ███╗███████╗    ██╗   ██╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗██████╗ "
echo " ████╗ ████║██╔════╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔══██╗"
echo " ██╔████╔██║█████╗       ╚████╔╝ ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║  ██║"
echo " ██║╚██╔╝██║██╔══╝        ╚██╔╝  ██║   ██║██║   ██║██╔══╝  ██║╚██╗██║██║  ██║"
echo " ██║ ╚═╝ ██║██║            ██║   ╚██████╔╝╚██████╔╝███████╗██║ ╚████║██████╔╝"
echo " ╚═╝     ╚═╝╚═╝            ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═════╝ "
echo -e "\033[0m"
echo -e "\033[1;32m>> Starting port forwarding setup...\033[0m"
sleep 2

echo "=== Update Sistem ==="
apt update && apt upgrade -y

echo "=== Install dependensi umum ==="
apt install -y git curl unzip build-essential libssl-dev libpcre3-dev \
    ppp xl2tpd pptpd strongswan pip python3-pip

echo "=== Install SSTP ==="
pip install git+https://github.com/sorz/sstp-server.git

echo "=== Buat folder sertifikat untuk SSTP ==="
mkdir -p /etc/sstp

echo "=== Contoh generate self-signed sertifikat SSTP ==="
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/sstp/server-key.pem \
  -out /etc/sstp/server-cert.pem \
  -subj "/CN=sstp.example.com"

echo "=== Buat systemd service untuk sstpd ==="
cat > /etc/systemd/system/sstpd.service <<EOF
[Unit]
Description=SSTP VPN Server
After=network.target

[Service]
ExecStart=/usr/local/bin/sstpd -c /etc/sstp/server-cert.pem -k /etc/sstp/server-key.pem --range 192.168.2.10-192.168.2.100 --remote 192.168.2.0/24 -l 0.0.0.0 -p 444
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable --now sstpd

echo "=== Konfigurasi PPTP ==="
echo "localip 192.168.0.1" >> /etc/pptpd.conf
echo "remoteip 192.168.0.100-200" >> /etc/pptpd.conf

cat > /etc/ppp/pptpd-options <<EOF
name pptpd
refuse-pap
refuse-chap
refuse-mschap
require-mschap-v2
require-mppe-128
ms-dns 8.8.8.8
proxyarp
lock
nobsdcomp
EOF

echo "vpnuser pptpd vpnpassword *" >> /etc/ppp/chap-secrets

systemctl enable --now pptpd

echo "=== Konfigurasi L2TP/IPSec ==="
cat > /etc/ipsec.conf <<EOF
config setup
  uniqueids=no

conn l2tp-psk
  authby=secret
  pfs=no
  auto=add
  keyingtries=3
  rekey=no
  ikelifetime=8h
  keylife=1h
  type=transport
  left=%any
  leftprotoport=17/1701
  right=%any
  rightprotoport=17/%any
EOF

cat > /etc/ipsec.secrets <<EOF
: PSK "vpnsharedkey"
EOF

cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[global]
ipsec saref = yes

[lns default]
ip range = 192.168.1.100-192.168.1.200
local ip = 192.168.1.1
require chap = yes
refuse pap = yes
require authentication = yes
name = l2tpd
ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
EOF

cat > /etc/ppp/options.xl2tpd <<EOF
require-mschap-v2
ms-dns 8.8.8.8
asyncmap 0
auth
crtscts
lock
hide-password
modem
debug
name l2tpd
proxyarp
lcp-echo-interval 30
lcp-echo-failure 4
EOF

echo "vpnuser l2tpd vpnpassword *" >> /etc/ppp/chap-secrets

echo "=== Aktifkan layanan L2TP/IPSec ==="
systemctl enable --now xl2tpd
systemctl enable --now strongswan-starter

echo "=== Semua layanan telah diinstal dan dijalankan ==="
