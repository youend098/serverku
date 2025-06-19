# ⚙️SCRIPT BY MF_youend⚙️
─────────────────────────────────────────────────────────────────────────
# 📝REGISTER VIA TELEGRAM
<a href="https://t.me/MF_youend" target=”_blank”><img src="https://img.shields.io/static/v1?style=for-the-badge&logo=Telegram&label=Telegram&message=Click%20Here&color=blue"></a><br>
─────────────────────────────────────────────────────────────────────────
# LOGIN USER ROOT
```
sudo su
```
# GANTI PASWORD ROOT
```
sudo passwd root
```
# SETTING PERMISSION LOGIN ROOT
```
nano /etc/ssh/sshd_config
```
─────────────────────────────────────────────────────────────────────────
# CARA INSTALL SCRIPT DI UBUNTU 18/20 & DEBIAN 9/10
# 1. MASUKAN IP VPS PADA FILE REGISTER YANG TELAH DI POINTING DI CLOUDFLARE SEBELUM NYA
  🔐https://github.com/youend098/registerku/blob/main/reg
# 2. INSTALL SCRIPT PADA VPS YANG TELAH DI DAFTARKAN
```
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/youend098/serverku/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```
# 3. SCRIPT SIAP DI GUNAKAN
─────────────────────────────────────────────────────────────────────────
# CARA INSTALL SCRIPT DI UBUNTU 22/24
# 1. MASUKAN IP VPS PADA FILE REGISTER YANG TELAH DI POINTING DI CLOUDFLARE SEBELUM NYA
  🔐https://github.com/youend098/registerku/blob/main/reg
# 2. INSTALL SCRIPT VIRTUAL
```
cd
rm ubuntu_debian
apt update -y && apt upgrade -y && wget -q https://github.com/youend098/serverku/raw/refs/heads/main/ubuntu.sh && chmod +x ubuntu.sh && ./ubuntu.sh
```
# 4. BUKA PORT
```
cd
rm port.sh
wget -q https://github.com/youend098/serverku/raw/refs/heads/main/port.sh && chmod +x port.sh && ./port.sh
```
# 5. MASUK KE VIRTUAL UBUNTU 20
```
lxc exec ubuntu20 -- bash
```
# 6. INSTALL SCRIPT VPN TUNNELING
```
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/youend098/serverku/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```
# 7. INSTALASI SCRIPT SELESAI
# 8. REBOOT DULU VPSNYA
```
reboot
```
# 9. UNTUK MASUK SCRIPT KETIKAN
```
lxc exec ubuntu20 -- bash
```
```
menu
```
# 10. SCRIPT SIAP DI GUNAKAN
─────────────────────────────────────────────────────────────────────────
# CARA INSTALL SCRIPT DI DEBIAN 11/12
# 1. MASUKAN IP VPS PADA FILE REGISTER YANG TELAH DI POINTING DI CLOUDFLARE SEBELUM NYA
  🔐https://github.com/youend098/registerku/blob/main/reg
# 2. INSTALL SCRIPT VIRTUAL
```
cd
rm ubuntu_debian
apt update -y && apt upgrade -y && wget -q https://github.com/youend098/serverku/raw/refs/heads/main/debian.sh && chmod +x debian.sh && ./debian.sh
```
# 4. BUKA PORT  
```
cd
rm port.sh
wget -q https://github.com/youend098/serverku/raw/refs/heads/main/port.sh && chmod +x port.sh && ./port.sh
```
# 5. MASUK KE VIRTUAL
```
lxc exec ubuntu20 -- bash
```
# 6. INSTALL SCRIPT VPN TUNNELING
```
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/youend098/serverku/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```
# 7. INSTALASI SCRIPT SELESAI
# 8. REBOOT DULU VPSNYA
```
reboot
```
# 9. UNTUK MASUK SCRIPT KETIKAN
```
lxc exec ubuntu20 -- bash
```
```
menu
```
# 10. SCRIPT SIAP DI GUNAKAN
──────────────────────────────────────────────────────────────────────────
