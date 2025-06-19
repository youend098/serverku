#!/bin/bash
# AUTO SCRIPT BY MF_youend
clear

# POWERED BANNER BY MF_youend
echo ""
echo "███╗   ███╗███████╗    ██╗   ██╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗██████╗ "
echo "████╗ ████║██╔════╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔══██╗"
echo "██╔████╔██║█████╗       ╚████╔╝ ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║  ██║"
echo "██║╚██╔╝██║██╔══╝        ╚██╔╝  ██║   ██║██║   ██║██╔══╝  ██║╚██╗██║██║  ██║"
echo "██║ ╚═╝ ██║██║            ██║   ╚██████╔╝╚██████╔╝███████╗██║ ╚████║██████╔╝"
echo "╚═╝     ╚═╝╚═╝            ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═════╝ "
echo "────────────────────── SUPPORT SCRIPT UBUNTU / DEBIAN ──────────────────────"
echo "──────────────── MEMULAI INSTALASI PORT PADA SCRIPT VIRTUAL ────────────────"
echo ""
sleep 5
clear

# MEMBUAT NAMA CONTAINER
echo "👤 Membuat Nama Container..."
CONTAINER_NAME="ubuntu20"

# MEMBUKA PORT YANG DIBUTUHKAN
echo "🚀 Membuka Port Yang Dibutuhkan..."
declare -A PORTS=(
    ["xray443"]="443:443"
    ["xray80"]="80:80"
    ["xray10000"]="10000:10000"
    ["sshws8880"]="8880:8880"
    ["sshws2082"]="2082:2082"
    ["sshws8080"]="8080:8080"
    ["dropbear22"]="149:149"
    ["dropbear109"]="109:109"
    ["dropbear143"]="143:143"
    ["dropbear442"]="442:442"
    ["haproxy8443"]="8443:8443"
    ["haproxy8080"]="8080:8080"
    ["haproxy3000"]="3000:3000"
)

# MEMERIKSA CONTAINER
echo "🛠️ memeriksa Container..."
if ! lxc list | grep -q "$CONTAINER_NAME"; then
    echo "Error: Container $CONTAINER_NAME not found!"
    exit 1
fi

echo "Setting up port forwarding for container $CONTAINER_NAME..."

# VALIDASI PORT YANG DIBUTUHKAN
echo "🔧 Validasi Port Yang Dibutuhkan..."
for name in "${!PORTS[@]}"; do
    IFS=':' read -ra PORT_MAP <<< "${PORTS[$name]}"
    HOST_PORT="${PORT_MAP[0]}"
    CONTAINER_PORT="${PORT_MAP[1]}"
    
    echo "Configuring $name (host:$HOST_PORT -> container:$CONTAINER_PORT)"
    
    # HAPUS PORT LAMA
    echo "🧹 Hapus Port Lama..."
    lxc config device remove "$CONTAINER_NAME" "$name" 2>/dev/null || true
    
    # BUAT PORT BARU
    echo "🔄 Buat Port Baru..."
    lxc config device add "$CONTAINER_NAME" "$name" proxy \
        listen=tcp:0.0.0.0:"$HOST_PORT" \
        connect=tcp:127.0.0.1:"$CONTAINER_PORT"
done

# POWERED BANNER BY MF_youend
echo ""
echo "███╗   ███╗███████╗    ██╗   ██╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗██████╗ "
echo "████╗ ████║██╔════╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔══██╗"
echo "██╔████╔██║█████╗       ╚████╔╝ ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║  ██║"
echo "██║╚██╔╝██║██╔══╝        ╚██╔╝  ██║   ██║██║   ██║██╔══╝  ██║╚██╗██║██║  ██║"
echo "██║ ╚═╝ ██║██║            ██║   ╚██████╔╝╚██████╔╝███████╗██║ ╚████║██████╔╝"
echo "╚═╝     ╚═╝╚═╝            ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═════╝ "
echo "───────────────────────────────── SELAMAT ──────────────────────────────────"
echo "───────────────────── INSTALASI SCRIPT BERJALAN SUKSES ─────────────────────"
echo "─────────── TERIMAKASIH TELAH MENGGUNAKAN SCRIPT DARI MF_youend ────────────"
echo ""
sleep 2
echo "📝 DAFTAR PORT YANG BERHASIL DI CONFIGURASI:"
lxc config device list "$CONTAINER_NAME" | grep -E "$(IFS='|'; echo "${!PORTS[*]}")"
