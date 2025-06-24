#!/bin/bash
# AUTO SCRIPT BY MF_youend
clear
# POWERED BANNER BY MF_youend
clear
echo "┌───────────────────────┐"
echo "│  MF_youend TUNNELING  │"
echo "└───────────────────────┘"
echo "SUPPORT SCRIPT DEBIAN 11/12"
echo "MEMULAI INSTALASI SCRIPT VIRTUAL"
echo "⏳LOADING..."
sleep 5
clear

# UPDATE SYSTEM
echo "🔄Memperbarui sistem..."
sudo apt update
sudo apt upgrade -y

# HAPUS SNAPD LAMA
echo "🧹Membersihkan snapd yang bermasalah..."
sudo systemctl stop snapd snapd.socket
sudo apt purge -y snapd
sudo rm -rf /var/snap /snap /var/lib/snapd

# INSTALL SNAPD BARU
echo "🔄Menginstall snapd..."
sudo apt install -y snapd

# AKTIFKAN SERVICE SNAPD
sudo systemctl enable --now snapd snapd.socket

# TAMBAHKAN SNAPD KE PATH
if ! grep -q "/snap/bin" ~/.bashrc; then
    echo "export PATH=\$PATH:/snap/bin" >> ~/.bashrc
    source ~/.bashrc
fi

# TUNGGU SAMPAI SNAPD SIAP
sleep 10

# UPDATE SNAPD
echo "🆙Memperbarui snapd core..."
sudo snap install core
sudo snap refresh core

# INSTALL LXD
echo "🐳Menginstall LXD..."
sudo snap install lxd

# INISIALISASI LXD
echo "🔧Inisialisasi LXD..."

# PASTIKAN SERVICE LXD AKTIF
sudo snap start lxd

# TUNGGU SAMPAI LXD SIAP
timeout=60
while [ $timeout -gt 0 ]; do
    if sudo lxd waitready; then
        break
    fi
    echo "⏳Menunggu LXD ready... (sisa waktu: $timeout detik)"
    sleep 1
    ((timeout--))
done

if [ $timeout -eq 0 ]; then
    echo "⚠️LXD tidak ready dalam waktu yang ditentukan, restarting service..."
    sudo snap restart lxd
    sleep 10
fi

# JALANKAN INISIALISASI
sudo lxd init --auto --storage-backend=dir

# KONFIGURASI USER
echo "👤Konfigurasi user..."
sudo usermod -aG lxd,snapd $USER

# VERIFIKASI
echo "🔍Verifikasi instalasi..."
sudo lxc info
lxc list

# BUAT CONTAINER
echo "🚀Membuat container Ubuntu 20.04..."
lxc launch ubuntu:20.04 ubuntu20
lxc exec ubuntu20 -- apt update && lxc exec ubuntu20 -- apt upgrade -y

# POWERED BANNER BY MF_youend
clear
echo "┌───────────────────────┐"
echo "│  MF_youend TUNNELING  │"
echo "└───────────────────────┘"
echo "✅[SELAMAT] INSTALASI SCRIPT BERJALAN SUKSES"
echo ""
read -p "TEKAN [ENTER] UNTUK [REBOOT]"
reboot
