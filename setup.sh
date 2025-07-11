#!/bin/bash
# AUTO SCRIPT BY MF_youend
clear

# MEMPERBAHARUI SYSTEM
apt update -y
apt upgrade -y
apt install curl -y
apt install wondershaper -y
clear

# MENDAPATKAN IP ADDRESS
export IP=$(curl -sS icanhazip.com)

# CLEAR DATA
clear
clear && clear && clear
clear;clear;clear
clear

# AMBIL IP PUBLIK
MYIP=$(curl -sS ipv4.icanhazip.com)

# AMBIL TANGGAL DARI SERVER GOOGLE
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')

# FORMAT TANGGAL MENJADI DD-MM-YYYY
date_list=$(date +"%d-%m-%Y" -d "$data_server")

# KONFIGURASI TELEGRAM
TIME=$(date '+%d-%m-%Y')
MYIP=$(wget -qO- ipinfo.io/ip)
TIMES="10"
CHATID="1922504414"
KEY="8101122738:AAFNNI-jHdpDHpfnjQ5Wq0p_5Q5eo1jbJf0"
URL="https://api.telegram.org/bot$KEY/sendMessage"
clear

# POWERED BANNER BY MF_youend
echo "┌───────────────────────┐"
echo "│  MF_youend TUNNELING  │"
echo "└───────────────────────┘"
echo "SUPPORT SCRIPT UBUNTU 18/20 & DEBIAN 9/10"
echo "MEMULAI INSTALASI SCRIPT VPN TUNNELING"
echo "⏳LOADING..."
echo ""
sleep 2

# MEMERIKSA ARSITEKTUR OS
if [[ $(uname -m | awk '{print $1}') == "x86_64" ]]; then
    echo "✅ARSITEKTUR YANG ANDA GUNAKAN DIDUKUNG ( $(uname -m) )"
else
    echo "❌ARSITEKTUR YANG ANDA GUNAKAN TIDAK DIDUKUNG ( $(uname -m) )"
    exit 1
fi

# MEMERIKSA SYSTEM OS
os_id=$(cat /etc/os-release | grep -w ID | head -n1 | sed 's/ID=//' | sed 's/"//g')
os_name=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME=//' | sed 's/"//g')

if [[ $os_id == "ubuntu" || $os_id == "debian" ]]; then
    echo "✅OS YANG ANDA GUNAKAN DIDUKUNG ( $os_name )"
else
    echo "❌OS YANG ANDA GUNAKAN TIDAK DIDUKUNG ( $os_name )"
    exit 1
fi

# MEMERIKSA IP VPS
if [[ $MYIP == "" ]]; then
    echo "❌IP ADDRESS TIDAK TERDETEKSI"
else
    echo "✅IP ADDRESS ( $IP )"
fi

# SEMUANYA BERHASIL DIPERIKSA
read -p "🖥️TEKAN [ENTER] UNTUK MEMILAI INSTALASI"
clear

# MEMERIKSA USER ROOT
if [ "${EUID}" -ne 0 ]; then
    echo "⚠️JALANKAN SCRIPT INI SEBAGAI USER ROOT"
    exit 1
fi

# BERHENTI JIKA SYSTEM BERJALAN DI OPENVZ
if [ "$(systemd-detect-virt)" == "openvz" ]; then
    echo "❌OPENVZ TIDAK DIDUKUNG"
    exit 1
fi
clear

# USERNAME
rm -f /usr/bin/user
username=$(curl https://raw.githubusercontent.com/youend098/registerku/main/reg | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
exp=$(curl https://raw.githubusercontent.com/youend098/registerku/main/reg | grep $MYIP | awk '{print $3}')
echo "$exp" >/usr/bin/e

# DETAIL ORDER
username=$(cat /usr/bin/user)
exp=$(cat /usr/bin/e)
clear

# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))

# INFORMASI VPS
DATE=$(date +'%d-%m-%Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo "Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}

# STATUS AKTIF / EXPIRED
Info="(Active)"
Error="(ExpiRED)"
today=$(date -d "0 days" +"%d-%m-%Y")
Exp=$(curl https://raw.githubusercontent.com/youend098/registerku/main/reg | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp ]]; then
    sts="${Info}"
else
    sts="${Error}"
fi

clear
echo "⏳LOADING..."

# REPO    
REPO="https://raw.githubusercontent.com/youend098/serverku/main/"

# HITUNG WAKTU INSTALL
start=$(date +%s)
secs_to_human() {
    echo "🕒WAKTU INSTALASI : $((${1} / 3600)) JAM $(((${1} / 60) % 60)) MRNIT $((${1} % 60)) DETIK"
}

# CEK ROOT
function is_root() {
    if [[ 0 == "$UID" ]]; then
        echo "🔄USER ROOT MEMULAI PROSES INSTALASI"
    else
        echo "⚠️HARAP BERALIH KE PENGGUNA USER ROOT DAN JALANKAN SCRIPT INI KEMBALI"
    fi
}

# BUAT DIREKTORI XRAY
echo "🔄MEMBUAT DIREKTORI XRAY"
mkdir -p /etc/xray
curl -s ifconfig.me > /etc/xray/ipvps
touch /etc/xray/domain
mkdir -p /var/log/xray
chown www-data:www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
mkdir -p /var/lib/kyt >/dev/null 2>&1

# INFORMASI RAM
while IFS=":" read -r a b; do
    case $a in
        "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
        "Shmem") ((mem_used+=${b/kB})) ;;
        "MemFree" | "Buffers" | "Cached" | "SReclaimable")
            mem_used="$((mem_used-=${b/kB}))"
        ;;
    esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=$(date -d "0 days" +"%d-%m-%Y - %X")
export OS_Name=$(grep -w PRETTY_NAME /etc/os-release | head -n1 | sed 's/PRETTY_NAME=//' | sed 's/"//g')
export Kernel=$(uname -r)
export Arch=$(uname -m)
export IP=$(curl -s https://ipinfo.io/ip)

# SETUP DATA SYSTEM
function first_setup() {
    timedatectl set-timezone Asia/Jakarta
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    echo "✅DIREKTORY XRAY SELESAI DIBUAT"

    OS_ID=$(grep -w ID /etc/os-release | head -n1 | sed 's/ID=//' | sed 's/"//g')
    OS_NAME=$(grep -w PRETTY_NAME /etc/os-release | head -n1 | sed 's/PRETTY_NAME=//' | sed 's/"//g')

    if [[ "$OS_ID" == "ubuntu" ]]; then
        echo "🔄SETUP DEPENDENCIES $OS_NAME"
        sudo apt update -y
        apt-get install --no-install-recommends software-properties-common
        add-apt-repository ppa:vbernat/haproxy-2.0 -y
        apt-get -y install haproxy=2.0.\*
    elif [[ "$OS_ID" == "debian" ]]; then
        echo "Setup Dependencies For OS Is $OS_NAME"
        curl https://haproxy.debian.net/bernat.debian.org.gpg |
            gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
        echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
            http://haproxy.debian.net buster-backports-1.8 main \
            >/etc/apt/sources.list.d/haproxy.list
        sudo apt-get update
        apt-get -y install haproxy=1.8.\*
    else
        echo "❌OS YANG ANDA GUNAKAN TIDAK DIDUKUNG ($OS_NAME)"
        exit 1
    fi
}

function nginx_install() {
    clear
    OS_ID=$(grep -w ID /etc/os-release | head -n1 | sed 's/ID=//' | sed 's/"//g')
    OS_NAME=$(grep -w PRETTY_NAME /etc/os-release | head -n1 | sed 's/PRETTY_NAME=//' | sed 's/"//g')

    if [[ "$OS_ID" == "ubuntu" ]]; then
        echo "🔄SETUP NGINX $OS_NAME"
        sudo apt-get install nginx -y
    elif [[ "$OS_ID" == "debian" ]]; then
        echo "🔄SETUP NGINX $OS_NAME"
        apt -y install nginx
    else
        echo "❌OS YANG ANDA GUNAKAN TIDAK DIDUKUNG ($OS_NAME)"
    fi
}

# UPDATE DAN INSTALL PACKAGE
function base_package() {
    clear
    echo "🔄INSTALL PAKET YANG DIBUTUHKAN"
    apt install zip pwgen openssl netcat socat cron bash-completion -y
    apt install figlet -y
    apt update -y
    apt upgrade -y
    apt dist-upgrade -y
    systemctl enable chronyd
    systemctl restart chronyd
    systemctl enable chrony
    systemctl restart chrony
    chronyc sourcestats -v
    chronyc tracking -v
    apt install ntpdate -y
    ntpdate pool.ntp.org
    apt install sudo -y
    sudo apt-get clean all
    sudo apt-get autoremove -y
    sudo apt-get install -y debconf-utils
    sudo apt-get remove --purge exim4 -y
    sudo apt-get remove --purge ufw firewalld -y
    sudo apt-get install -y --no-install-recommends software-properties-common
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
    echo "✅PAKET YANG DIBUTUHKAN SELESAI DI INSTALL"
}

clear
# INPUT DOMAIN
function pasang_domain() {
echo -e ""
clear

# POWERED BANNER BY MF_youend
echo ""
echo "┌───────────────────────┐"
echo "│  MF_youend TUNNELING  │"
echo "└───────────────────────┘"
echo "SILAHKAN INPUT DOMAIN ANDA"
echo "DOMAIN WAJIB SUDAH DI POINTING DI CLOUDFLARE"
echo ""
read -p "MASUKKAN DOMAIN ANDA DISINI : " domain

# PASTIKAN DIREKTORI TUJUAN ADA
mkdir -p /etc/xray
mkdir -p /var/lib/kyt

# SIMPAN KE FILE KONFIGURASI
echo "$domain" > /root/domain
echo "$domain" > /etc/xray/domain
echo "IP=$domain" > /var/lib/kyt/ipvps.conf
echo "✅DOMAIN SELESAI DISIMPAN : $domain"

}

clear
# GANTI PASSWORD DEFAULT
restart_system() {
    USRSC=$(wget -qO- https://raw.githubusercontent.com/youend098/registerku/main/reg | grep $MYIP | awk '{print $2}')
    EXPSC=$(wget -qO- https://raw.githubusercontent.com/youend098/registerku/main/reg | grep $MYIP | awk '{print $3}')
    TIMEZONE=$(printf '%(%H:%M:%S)T')
    TEXT="
<code>-------------------------------</code>
<code>AUTOSCRIPT PREMIUM BY MF_youend</code>
<code>-------------------------------</code>
<code>USER   : </code><code>$USRSC</code>
<code>IP VPS : </code><code>$MYIP</code>
<code>DOMAIN : </code><code>$domain</code>
<code>DATE   : </code><code>$TIME</code>
<code>TIME   : </code><code>$TIMEZONE</code>
<code>EXP SC : </code><code>$EXPSC</code>
<code>-------------------------------</code>
<code>NOTIFIKASI OTOMATIS DARI GITHUB</code>
<code>-------------------------------</code>
"'&reply_markup={"inline_keyboard":[[{"text":"ᴏʀᴅᴇʀ","url":"t.me/MF_youend"}]]}'
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

# PASANG SSL
function pasang_ssl() {
    clear
    echo "🔄MEMASANG CERTIFICATE SSL PADA DOMAIN"
    rm -rf /etc/xray/xray.key
    rm -rf /etc/xray/xray.crt
    domain=$(cat /root/domain)
    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop $STOPWEBSERVER
    systemctl stop nginx
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    echo "✅CERTIFICATE SSL SELESAI DIPASANG"
}

function make_folder_xray() {
    rm -rf /etc/vmess/.vmess.db
    rm -rf /etc/vless/.vless.db
    rm -rf /etc/trojan/.trojan.db
    rm -rf /etc/shadowsocks/.shadowsocks.db
    rm -rf /etc/ssh/.ssh.db
    rm -rf /etc/bot/.bot.db
    mkdir -p /etc/bot
    mkdir -p /etc/xray
    mkdir -p /etc/vmess
    mkdir -p /etc/vless
    mkdir -p /etc/trojan
    mkdir -p /etc/shadowsocks
    mkdir -p /etc/ssh
    mkdir -p /usr/bin/xray/
    mkdir -p /var/log/xray/
    mkdir -p /var/www/html
    mkdir -p /etc/kyt/limit/vmess/ip
    mkdir -p /etc/kyt/limit/vless/ip
    mkdir -p /etc/kyt/limit/trojan/ip
    mkdir -p /etc/kyt/limit/ssh/ip
    mkdir -p /etc/limit/vmess
    mkdir -p /etc/limit/vless
    mkdir -p /etc/limit/trojan
    mkdir -p /etc/limit/ssh
    chmod +x /var/log/xray
    touch /etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
    touch /etc/vmess/.vmess.db
    touch /etc/vless/.vless.db
    touch /etc/trojan/.trojan.db
    touch /etc/shadowsocks/.shadowsocks.db
    touch /etc/ssh/.ssh.db
    touch /etc/bot/.bot.db
    echo "& plughin Account" >> /etc/vmess/.vmess.db
    echo "& plughin Account" >> /etc/vless/.vless.db
    echo "& plughin Account" >> /etc/trojan/.trojan.db
    echo "& plughin Account" >> /etc/shadowsocks/.shadowsocks.db
    echo "& plughin Account" >> /etc/ssh/.ssh.db
}

# INSTALL XRAY
function install_xray() {
    clear
    echo "🔄INSTALL Core Xray 1.8.1 Latest Version"
    domainSock_dir="/run/xray"
    [ ! -d $domainSock_dir ] && mkdir $domainSock_dir
    chown www-data:www-data $domainSock_dir

    latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version

    wget -O /etc/xray/config.json "${REPO}config/config.json" >/dev/null 2>&1
    wget -O /etc/systemd/system/runn.service "${REPO}file/runn.service" >/dev/null 2>&1

    domain=$(cat /etc/xray/domain)
    IPVS=$(cat /etc/xray/ipvps)
    echo "✅Core Xray 1.8.1 Latest Version SELESAI DI INSTALL"

    curl -s ipinfo.io/city >> /etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /etc/xray/isp
    echo "🔄MEMASANG KONFIGURASI PAKET"
    wget -O /etc/haproxy/haproxy.cfg "${REPO}file/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "${REPO}file/xray.conf" >/dev/null 2>&1
    sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    curl ${REPO}file/nginx.conf > /etc/nginx/nginx.conf

    cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem

    chmod +x /etc/systemd/system/runn.service

    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

    echo "✅KONFIGURASI PAKET SELESAI DIPASANG"
}

function ssh(){
    clear
    echo "🔄MEMASANG PASSWORD SSH"
    wget -O /etc/pam.d/common-password "${REPO}file/password"
    chmod +x /etc/pam.d/common-password

    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "

# GO TO ROOT
cd

# EDIT FILE
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# BUAT FOLDER
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

chmod +x /etc/rc.local

# ENABLE RC LOCAL
systemctl enable rc-local
systemctl start rc-local.service

# NONAKTIFKAN IPV6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# UPDATE & BUAT TANGGAL DAN WAKTU
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# SET LOCAL
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

echo "✅PASSWORD SSH SELESAI DIPASANG"
}

function udp_mini(){
clear
echo "🔄MEMASANG SERVICE LIMIT QUOTA"
wget raw.githubusercontent.com/youend098/serverku/main/limit/limit.sh && chmod +x limit.sh && ./limit.sh

cd
wget -q -O /usr/bin/limit-ip "${REPO}limit/limit-ip"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip
cd
clear

cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vmip
systemctl enable vmip

cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vlip
systemctl enable vlip

cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart trip
systemctl enable trip

mkdir -p /usr/local/kyt/
wget -q -O /usr/local/kyt/udp-mini "${REPO}file/udp-mini"
chmod +x /usr/local/kyt/udp-mini
wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}file/udp-mini-1.service"
wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}file/udp-mini-2.service"
wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}file/udp-mini-3.service"
systemctl disable udp-mini-1
systemctl stop udp-mini-1
systemctl enable udp-mini-1
systemctl start udp-mini-1
systemctl disable udp-mini-2
systemctl stop udp-mini-2
systemctl enable udp-mini-2
systemctl start udp-mini-2
systemctl disable udp-mini-3
systemctl stop udp-mini-3
systemctl enable udp-mini-3
systemctl start udp-mini-3
echo "✅SERVICE LIMIT KUOTA SELESAI DIPASANG"
}

function ins_SSHD(){
clear
echo "🔄MEMASANG SSHD"
wget -q -O /etc/ssh/sshd_config "${REPO}file/sshd" >/dev/null 2>&1
chmod 700 /etc/ssh/sshd_config
/etc/init.d/ssh restart
systemctl restart ssh
/etc/init.d/ssh status
echo "✅SSHD SELESAI DIPASANG"
}

function ins_dropbear(){
clear
echo "🔄INSTALL DROPBEAR"
apt-get install dropbear -y > /dev/null 2>&1
wget -q -O /etc/default/dropbear "${REPO}file/dropbear.conf"
chmod +x /etc/default/dropbear
/etc/init.d/dropbear restart
/etc/init.d/dropbear status
echo "✅DROPBEAR SELESAI DI INSTALL"
}

function ins_vnstat(){
clear
echo "🔄INSTALL VNSTAT"
apt -y install vnstat > /dev/null 2>&1
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev > /dev/null 2>&1
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "eth0"/Interface "'$NET'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
/etc/init.d/vnstat status
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
echo "✅VNSTAT SELESAI DI INSTALL"
}

function ins_openvpn(){
clear
echo "🔄INSTALL OPENVPN"
wget ${REPO}file/openvpn && chmod +x openvpn && ./openvpn
/etc/init.d/openvpn restart
echo "✅OPENVPN SELESAI DI INSTALL"
}

function ins_backup(){
clear
echo "🔄MEMASANG BACKUP SERVER"
apt install rclone -y
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "${REPO}file/rclone.conf"

cd /bin
git clone https://github.com/magnific0/wondershaper.git
cd wondershaper
sudo make install
cd
rm -rf wondershaper

echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y
cat <<EOF >> /etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user oceantestdigital@gmail.com
from oceantestdigital@gmail.com
password jokerman77 
logfile ~/.msmtp.log
EOF

chown -R www-data:www-data /etc/msmtprc
wget -q -O /etc/ipserver "${REPO}file/ipserver" && bash /etc/ipserver
echo "✅BACKUP SERVER SELESAI DIPASANG"
}

function ins_swab(){
clear
echo "🔄MEMASANG SWAP 1 G"
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v${gotop_latest}_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb >/dev/null 2>&1

dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile swap swap defaults 0 0' /etc/fstab

chronyd -q 'server 0.id.pool.ntp.org iburst'
chronyc sourcestats -v
chronyc tracking -v

wget ${REPO}file/bbr.sh && chmod +x bbr.sh && ./bbr.sh
echo "✅SWAP 1 G SELESAI DIPASANG"
}

function ins_Fail2ban(){
clear
echo "🔄INSTALL FAIL2BAN"

if [ -d '/usr/local/ddos' ]; then
	echo "Harap uninstall versi sebelumnya terlebih dahulu"
	exit 0
else
	mkdir /usr/local/ddos
fi

echo "Banner /etc/kyt.txt" >> /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/kyt.txt"@g' /etc/default/dropbear

wget -O /etc/kyt.txt "${REPO}file/issue.net"
echo "✅FAIL2BAN SELESAI DI INSTALL"
}

function ins_epro(){
clear
echo "🔄INSTALL EPRO WEBSOCKET PROXY"
wget -O /usr/bin/ws "${REPO}file/ws" >/dev/null 2>&1
wget -O /usr/bin/tun.conf "${REPO}file/tun.conf" >/dev/null 2>&1
wget -O /etc/systemd/system/ws.service "${REPO}file/ws.service" >/dev/null 2>&1
chmod +x /etc/systemd/system/ws.service
chmod +x /usr/bin/ws
chmod 644 /usr/bin/tun.conf

systemctl disable ws
systemctl stop ws
systemctl enable ws
systemctl start ws
systemctl restart ws

wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
wget -O /usr/sbin/ftvpn "${REPO}file/ftvpn" >/dev/null 2>&1
chmod +x /usr/sbin/ftvpn

iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

apt autoclean -y >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
echo "✅EPRO WEBSOCKET PROXY SELESAI DI DI INSTALL"
}

function ins_restart(){
clear
echo "🔃RESTART SEMUA PAKET"
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/vnstat restart
systemctl restart haproxy
/etc/init.d/cron restart
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now nginx
systemctl enable --now xray
systemctl enable --now rc-local
systemctl enable --now dropbear
systemctl enable --now openvpn
systemctl enable --now cron
systemctl enable --now haproxy
systemctl enable --now netfilter-persistent
systemctl enable --now ws
systemctl enable --now fail2ban
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/openvpn
rm -f /root/key.pem
rm -f /root/cert.pem
echo "✅SEMUA PAKET BERHASIL DI RESTART"
}

function menu(){
clear
echo "🔄MEMASANG SEMUA PAKET MENU"
wget ${REPO}menu/menu.zip
unzip menu.zip
chmod +x menu/*
mv menu/* /usr/local/sbin
rm -rf menu
rm -rf menu.zip
}

function profile(){
clear
cat >/root/.profile <<EOF
# ~/.profile: executed by Bourne-compatible login shells.
if [ "\$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
mesg n || true
menu
EOF

cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END

cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/10 * * * * root /usr/local/sbin/clearlog
END

chmod 644 /root/.profile

cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 5 * * * root /sbin/reboot
END

echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray

service cron restart

cat >/home/daily_reboot <<-END
5
END

cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF

echo "/bin/false" >>/etc/shells
echo "/usr/sbin/nologin" >>/etc/shells

cat >/etc/rc.local <<EOF
#!/bin/sh -e
# rc.local
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF

chmod +x /etc/rc.local

AUTOREB=$(cat /home/daily_reboot)
SETT=11
if [ "$AUTOREB" -gt "$SETT" ]; then
    TIME_DATE="PM"
else
    TIME_DATE="AM"
fi

echo "✅SEMUA PAKET MENU BERHASIL DIPASANG"
}

function enable_services(){
clear
echo "🛠️ENABLE SERVICE"
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now rc-local
systemctl enable --now cron
systemctl enable --now netfilter-persistent
systemctl restart nginx
systemctl restart xray
systemctl restart cron
systemctl restart haproxy
echo "✅ENABLE SERVICE SELESAI"
}

function instal(){
clear
echo "🔧MULAI PROSES SEMUA INSTALASI"
first_setup
nginx_install
base_package
make_folder_xray
pasang_domain
password_default
pasang_ssl
install_xray
ssh
udp_mini
ssh_slow
ins_SSHD
ins_dropbear
ins_vnstat
ins_openvpn
ins_backup
ins_swab
ins_Fail2ban
ins_epro
ins_restart
menu
profile
enable_services
restart_system
}

instal
echo "🧹HAPUS HISTORY PEOSES INSTALASI"
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /root/domain
secs_to_human "$(($(date +%s) - ${start}))"
sudo hostnamectl set-hostname $username
clear

# POWERED BANNER BY MF_youend
clear
echo "┌───────────────────────┐"
echo "│  MF_youend TUNNELING  │"
echo "└───────────────────────┘"
echo "✅[SELAMAT] INSTALASI SCRIPT BERJALAN SUKSES"
echo ""
read -p "TEKAN [ENTER] UNTUK [REBOOT]"
reboot
