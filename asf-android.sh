# Information script
clear
echo "╭━━━┳━━━┳━━━╮╱╭━━━╮╱╱╱╱╭╮╱╱╱╱╱╱╱╭╮"
echo "┃╭━╮┃╭━╮┃╭━━╯╱┃╭━╮┃╱╱╱╱┃┃╱╱╱╱╱╱╱┃┃"
echo "┃┃╱┃┃╰━━┫╰━━╮╱┃┃╱┃┣━╮╭━╯┣━┳━━┳┳━╯┃"
echo "┃╰━╯┣━━╮┃╭━┳┻━┫╰━╯┃╭╮┫╭╮┃╭┫╭╮┣┫╭╮┃"
echo "┃╭━╮┃╰━╯┃┃╱╰━━┫╭━╮┃┃┃┃╰╯┃┃┃╰╯┃┃╰╯┃"
echo "╰╯╱╰┻━━━┻╯╱╱╱╱╰╯╱╰┻╯╰┻━━┻╯╰━━┻┻━━╯"
echo "      github: sevcator/ASF-Android"
echo ""
echo "ArchiSteamFarm in Android Device"
echo ""

# Check if script is runned in Termux
if [ -n "$TERMUX_VERSION" ]; then
   echo "Executed in Termux $TERMUX_VERSION"
else
   echo "This script only for Termux!"
   exit
fi

# Update pkg
pkg update -y -o Dpkg::Options::="--force-confnew"

# Installing packages
pkg install proot-distro -y

# Installing Ubuntu
proot-distro install ubuntu

# Installing requirements for ArchiSteamFarm
proot-distro login ubuntu -- bash -c 'apt update -y && apt upgrade -y && apt install libicu72 mono-runtime -y'

# Create a user noroot
proot-distro login ubuntu -- bash -c 'useradd -m noroot'

# Configure Autostart & motd
echo 'if telnet "127.0.0.1" "1337" </dev/null 2>&1 | grep -q "Connected"; then' >> /data/data/com.termux/files/usr/etc/bash.bashrc
echo '  echo "Server is running. ASF will not again run..." && echo ""' >> /data/data/com.termux/files/usr/etc/bash.bashrc
echo 'else' >> /data/data/com.termux/files/usr/etc/bash.bashrc
echo '  echo "Server not running!" && echo "Running ASF..." && echo "" && echo "If you want use other session Termux" && echo "please wait when ipc server starts" && echo "and make new session"' >> /data/data/com.termux/files/usr/etc/bash.bashrc
echo "proot-distro login ubuntu --user noroot --fix-low-ports -- bash -c 'export DOTNET_GCHeapHardLimit=1C0000000 && /home/noroot/asf/ArchiSteamFarm'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
echo 'fi' >> /data/data/com.termux/files/usr/etc/bash.bashrc
echo "Welcome to Termux!" > /data/data/com.termux/files/usr/etc/motd
echo " " >> /data/data/com.termux/files/usr/etc/motd

# Joining into directory Ubuntu
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot

# Creating a folder for ASF and IPC config
mkdir /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf
mkdir /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/config
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/config
curl -L -O https://github.com/sevcator/ASF-Android/raw/main/IPC.config
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf

# Downloading ArchiSteamFarm
arch=$(dpkg --print-architecture)

if [ "$arch" = "arm" ]; then
  curl -L https://raw.githubusercontent.com/sevcator/ASF-Android/main/arm-dw.sh -o /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm-dw.sh
  bash /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm-dw.sh
  unzip /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/ASF-linux-arm.zip
  clear
  echo "╭━━━┳━━━┳━━━╮╱╭━━━╮╱╱╱╱╭╮╱╱╱╱╱╱╱╭╮"
  echo "┃╭━╮┃╭━╮┃╭━━╯╱┃╭━╮┃╱╱╱╱┃┃╱╱╱╱╱╱╱┃┃"
  echo "┃┃╱┃┃╰━━┫╰━━╮╱┃┃╱┃┣━╮╭━╯┣━┳━━┳┳━╯┃"
  echo "┃╰━╯┣━━╮┃╭━┳┻━┫╰━╯┃╭╮┫╭╮┃╭┫╭╮┣┫╭╮┃"
  echo "┃╭━╮┃╰━╯┃┃╱╰━━┫╭━╮┃┃┃┃╰╯┃┃┃╰╯┃┃╰╯┃"
  echo "╰╯╱╰┻━━━┻╯╱╱╱╱╰╯╱╰┻╯╰┻━━┻╯╰━━┻┻━━╯"
  echo "      github: sevcator/ASF-Android"
  echo ""
  echo "ArchiSteamFarm in Android Device"
  echo ""
  echo "All right!"
  echo ""
elif [ "$arch" = "armhf" ]; then
  curl -L https://raw.githubusercontent.com/sevcator/ASF-Android/main/arm-dw.sh -o /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm-dw.sh
  bash /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm-dw.sh
  unzip /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/ASF-linux-arm.zip
  clear
  echo "╭━━━┳━━━┳━━━╮╱╭━━━╮╱╱╱╱╭╮╱╱╱╱╱╱╱╭╮"
  echo "┃╭━╮┃╭━╮┃╭━━╯╱┃╭━╮┃╱╱╱╱┃┃╱╱╱╱╱╱╱┃┃"
  echo "┃┃╱┃┃╰━━┫╰━━╮╱┃┃╱┃┣━╮╭━╯┣━┳━━┳┳━╯┃"
  echo "┃╰━╯┣━━╮┃╭━┳┻━┫╰━╯┃╭╮┫╭╮┃╭┫╭╮┣┫╭╮┃"
  echo "┃╭━╮┃╰━╯┃┃╱╰━━┫╭━╮┃┃┃┃╰╯┃┃┃╰╯┃┃╰╯┃"
  echo "╰╯╱╰┻━━━┻╯╱╱╱╱╰╯╱╰┻╯╰┻━━┻╯╰━━┻┻━━╯"
  echo "      github: sevcator/ASF-Android"
  echo ""
  echo "ArchiSteamFarm in Android Device"
  echo ""
  echo "All right!"
  echo ""
elif [ "$arch" = "arm64" ]; then
  curl -L https://raw.githubusercontent.com/sevcator/ASF-Android/main/arm64-dw.sh -o /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm64-dw.sh
  bash /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm64-dw.sh
  unzip /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/ASF-linux-arm64.zip
  clear
  echo "╭━━━┳━━━┳━━━╮╱╭━━━╮╱╱╱╱╭╮╱╱╱╱╱╱╱╭╮"
  echo "┃╭━╮┃╭━╮┃╭━━╯╱┃╭━╮┃╱╱╱╱┃┃╱╱╱╱╱╱╱┃┃"
  echo "┃┃╱┃┃╰━━┫╰━━╮╱┃┃╱┃┣━╮╭━╯┣━┳━━┳┳━╯┃"
  echo "┃╰━╯┣━━╮┃╭━┳┻━┫╰━╯┃╭╮┫╭╮┃╭┫╭╮┣┫╭╮┃"
  echo "┃╭━╮┃╰━╯┃┃╱╰━━┫╭━╮┃┃┃┃╰╯┃┃┃╰╯┃┃╰╯┃"
  echo "╰╯╱╰┻━━━┻╯╱╱╱╱╰╯╱╰┻╯╰┻━━┻╯╰━━┻┻━━╯"
  echo "      github: sevcator/ASF-Android"
  echo ""
  echo "ArchiSteamFarm in Android Device"
  echo ""
  echo "All right!"
  echo ""
elif [ "$arch" = "aarch64" ]; then
  curl -L https://raw.githubusercontent.com/sevcator/ASF-Android/main/arm64-dw.sh -o /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm64-dw.sh
  bash /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/arm64-dw.sh
  unzip /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/noroot/asf/ASF-linux-arm64.zip
  clear
  echo "╭━━━┳━━━┳━━━╮╱╭━━━╮╱╱╱╱╭╮╱╱╱╱╱╱╱╭╮"
  echo "┃╭━╮┃╭━╮┃╭━━╯╱┃╭━╮┃╱╱╱╱┃┃╱╱╱╱╱╱╱┃┃"
  echo "┃┃╱┃┃╰━━┫╰━━╮╱┃┃╱┃┣━╮╭━╯┣━┳━━┳┳━╯┃"
  echo "┃╰━╯┣━━╮┃╭━┳┻━┫╰━╯┃╭╮┫╭╮┃╭┫╭╮┣┫╭╮┃"
  echo "┃╭━╮┃╰━╯┃┃╱╰━━┫╭━╮┃┃┃┃╰╯┃┃┃╰╯┃┃╰╯┃"
  echo "╰╯╱╰┻━━━┻╯╱╱╱╱╰╯╱╰┻╯╰┻━━┻╯╰━━┻┻━━╯"
  echo "      github: sevcator/ASF-Android"
  echo ""
  echo "ArchiSteamFarm in Android Device"
  echo ""
  echo "All right!"
  echo ""
else
  clear
  echo "Unknown architecture. Please install ArchiSteamFarm manually."
  echo "Your architecture: $arch. Please report this on GitHub Issues."
  echo ""
fi
