#!/bin/bash
# AUTO SCRIPT BY MF_youend
clear
# POWERED BANNER BY MF_youend
echo "███╗   ███╗███████╗    ██╗   ██╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗██████╗ "
echo "████╗ ████║██╔════╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔══██╗"
echo "██╔████╔██║█████╗       ╚████╔╝ ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║  ██║"
echo "██║╚██╔╝██║██╔══╝        ╚██╔╝  ██║   ██║██║   ██║██╔══╝  ██║╚██╗██║██║  ██║"
echo "██║ ╚═╝ ██║██║            ██║   ╚██████╔╝╚██████╔╝███████╗██║ ╚████║██████╔╝"
echo "╚═╝     ╚═╝╚═╝            ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═════╝ "
echo "─────────────────────── SUPPORT SCRIPT UBUNTU 22//24 ───────────────────────"
echo "─────── MEMULAI INSTALASI SCRIPT VIRTUAL LXD LXC CONTAINER UBUNTU 20 ───────"
sleep 5
clear

# HAPUS SNAPD LAMA
echo "🧹 Membersihkan snap yang bermasalah..."
sudo systemctl stop snapd
sudo apt purge -y snapd
sudo rm -rf /var/snap /snap /var/lib/snapd

# INSTALL SNAPD BARU
echo "🔄 Menginstall ulang snapd..."
sudo apt update
sudo apt install -y snapd
sudo systemctl start snapd
sudo systemctl enable snapd

# TUNGGU SAMPAI SNAPD SIAP
sleep 10

# UPDATE SNAPD
echo "🆙 Memperbarui snapd core..."
sudo snap install core
sudo snap refresh core

# INSTALL LXD
echo "🐳 Menginstall LXD..."
sudo snap install lxd --channel=latest/stable
sudo snap refresh lxd --channel=latest/stable

# INISIALISASI LXD
echo "🔧 Inisialisasi LXD..."

# PASTIKAN SERVICE LXD AKTIF
sudo snap start lxd

# TUNGGU SAMPAI LXD SIAP
timeout=30
while [ $timeout -gt 0 ]; do
    if sudo lxd waitready; then
        break
    fi
    echo "⏳ Menunggu LXD ready... (sisa waktu: $timeout detik)"
    sleep 1
    ((timeout--))
done

if [ $timeout -eq 0 ]; then
    echo "⚠️ LXD tidak ready dalam waktu yang ditentukan, restarting service..."
    sudo snap restart lxd
    sleep 10
fi

# JALANKAN INISIALISASI
sudo lxd init --auto --storage-backend=dir

# VERIFIKASI SOCKET
echo "🔍 Memverifikasi socket LXD..."
if [ ! -S /var/snap/lxd/common/lxd/unix.socket ]; then
    echo "⚠️ Socket LXD tidak ditemukan, restarting service..."
    sudo snap restart lxd
    sleep 10
fi

# KONFIGURASI USER
echo "👤 Konfigurasi user..."
sudo usermod -aG lxd $USER
newgrp lxd <<EONG
echo "✅ LXD siap digunakan"
lxc list
EONG

# VERIFIKASI
echo "🔍 Verifikasi instalasi..."
sudo lxc info
lxc list

# BUAT CONTAINER
echo "🚀 Membuat container Ubuntu 20.04..."
lxc launch ubuntu:20.04 ubuntu20
lxc exec ubuntu20 -- apt update && lxc exec ubuntu20 -- apt upgrade -y

clear
# POWERED BANNER BY MF_youend
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
read -p "                     TEKAN [ENTER] UNTUK [reboot]"
reboot
