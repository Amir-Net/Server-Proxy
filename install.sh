#!/bin/bash
# -----------------------------------------------------------------------------
# Description: This script automates the setup and configuration of various
#              utilities and services on a Linux server for a secure and
#              optimized environment.
#
# Author: BabyBoss
# GitHub: https://github.com/Amir-Net/
#
# Disclaimer: This script is provided for educational and informational
#             purposes only. Use it responsibly and in compliance with all
#             applicable laws and regulations.
#
# Note: Make sure to review and understand each section of the script before
#       running it on your system. Some configurations may require manual
#       adjustments based on your specific needs and server setup.
# -----------------------------------------------------------------------------

# Check for sudo privileges
if [[ $EUID -ne 0 ]]; then
  if [[ $(sudo -n true 2>/dev/null) ]]; then
    echo "This script will be run with sudo privileges."
  else
    echo "This script must be run with sudo privileges."
    exit 1
  fi
fi

# 1. Function to perform system updates and cleanup
system_update() {
  dialog --title "System Update and Cleanup" --yesno "This operation will update your system and remove unnecessary packages. Do you want to proceed?" 10 60
  response=$?
  
  if [ $response -eq 0 ]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean -y
    sudo apt clean -y

    dialog --msgbox "System updates and cleanup completed." 10 60
  else
    dialog --msgbox "System updates and cleanup operation canceled." 10 60
  fi
}

# 2. Function to ban IP system
system_ipban() {
  dialog --title "System IP Ban" --yesno "This operation will ban your system IP. Do you want to proceed?" 10 60
  response=$?
  
  if [ $response -eq 0 ]; then

  bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/ipban.sh)"

    dialog --msgbox "System updates and cleanup completed." 10 60
  else
    dialog --msgbox "System updates and cleanup operation canceled." 10 60
  fi
}

# 3-Function to Install Telegram Proxy
install_mtproto_panel() {
local mtproto_choice
  dialog --title "Install Telegram Proxy" --menu "Select a Telegram Proxy to Install:" 15 60 8 \
    "1" "Telegram Proxy by Officials | C-Lang" \
    "2" "Telegram Proxy by Alexbers | Python" \
    "3" "Telegram Proxy by Seriyps | Er-Lang" \
    "4" "Telegram Proxy by 9seconds | Go-Lang" 2> mtproto_choice.txt  
  mtproto_choice=$(cat mtproto_choice.txt)

  case $mtproto_choice in
    "1")
    bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtproto-c.sh)"
    ;;
    "2")
    bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtproto-py.sh)"
    ;;
    "3")
    bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtproto-er.sh)"
    ;;
    "4")
    bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtproto-go.sh)"
    ;;
    *)
      dialog --msgbox "Invalid choice. No SSH Panel installed." 10 40
      return
      ;;
  esac
  
  # Wait for the user to press Enter
  read -p "Please press Enter to continue."
  rm mtproto_choice.txt
  # Return to the menu
  }
  
# 4-Function to Install SSH Panel
install_ssh_panel() {
local ssh_choice
  dialog --title "Install SSH Proxy" --menu "Select a SSH Panel to Install:" 15 60 8 \
    "1" "SSH-Panel | Alireza" \
    "2" "SSH-Panel | Vahid" \
    "3" "SSH-Manual | Amir" 2> ssh_choice.txt
     
  ssh_choice=$(cat ssh_choice.txt)

  case $ssh_choice in
    "1")
      bash <(curl -Lfo https://raw.githubusercontent.com/xpanel-cp/XPanel-SSH-User-Management/master/install.sh --ipv4)
      ;;
    "2")
      wget -O ssh-panel-install.sh https://raw.githubusercontent.com/vfarid/ssh-panel/main/install.sh && sudo sh ssh-panel-install.sh
      ;;
    "3")
      bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/ssh.sh)"
      ;;
    *)
      dialog --msgbox "Invalid choice. No SSH Panel installed." 10 40
      return
      ;;
  esac

  # Wait for the user to press Enter
  read -p "Please press Enter to continue."
  rm ssh_choice.txt
  # Return to the menu
}

# 5-Function to Install Sing-Box
install_sing_panel() {
local sing_choice
  dialog --title "Install Multi Sing-Box Proxy" --menu "Select a Sing-Box to Install:" 15 60 8 \
    "1" "AIO Installer | Yonggekkk" \
    "2" "Naive Installer | Yonggekkk" \
    "3" "Reality Installer | Deathline94" \
    "4" "TUIC Installer | Deathline94" \
    "5" "Hysteria2 Installer | Deathline94" \
    "6" "Juicity Installer | Deathline94" 2> sing_choice.txt
     
  sing_choice=$(cat sing_choice.txt)

  case $sing_choice in
    "1")
    bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/sing-aio.sh)"
      ;;
    "2")
    bash <(curl -Ls https://gitlab.com/rwkgyg/naiveproxy-yg/raw/main/naiveproxy.sh)
      ;;
    "3")
    bash <(curl -fsSL https://github.com/deathline94/sing-REALITY-Box/raw/main/sing-REALITY-box.sh)
      ;;
    "4")
    bash <(curl -fsSL https://raw.githubusercontent.com/deathline94/tuic-v5-installer/main/tuic-installer.sh)
      ;;
    "5")
    bash <(curl -fsSL https://raw.githubusercontent.com/deathline94/Hysteria2-Installer/main/hysteria.sh)
      ;;
    "6")
     bash <(curl -fsSL https://raw.githubusercontent.com/deathline94/Juicity-Installer/main/juicity-installer.sh)
      ;;
    *)
      dialog --msgbox "Invalid choice. No SSH Panel installed." 10 40
      return
      ;;
  esac

  # Wait for the user to press Enter
  read -p "Please press Enter to continue."
  rm sing_choice.txt
  # Return to the menu
}

# 6-Function to Install X-UI VPN Panel
install_xui_panel() {
local xui_choice
  dialog --title "Install X-UI Panel" --menu "Select a X-UI Panel to Install:" 15 60 8 \
    "1" "X-UI | Alireza" \
    "2" "X-UI | MHSanaei" \
    "3" "X-UI | Vaxilu" \
    "4" "X-UI | FranzKafkaYu" \
    "5" "X-UI En | FranzKafkaYu" \
    "6" "X-UI Marzban | Gozargah" 2> xui_choice.txt
     
  xui_choice=$(cat xui_choice.txt)

  case $xui_choice in
    "1")
      bash <(curl -Ls https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh)
      ;;
    "2")
      bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
      ;;
    "3")
      bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
      ;;
    "4")
      bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install.sh)
      ;;
    "5")
      bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install_en.sh)
      ;;
    "6")
      sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install
      marzban cli admin create --sudo
      ;;
    *)
      dialog --msgbox "Invalid choice. No VPN Panel installed." 10 40
      return
      ;;
  esac

  # Wait for the user to press Enter
  read -p "Please press Enter to continue."
  rm xui_choice.txt
  # Return to the menu
}

# 7-Function to Install Multiprotocol VPN Panel
install_vpn_panel() {
local vpn_choice
  dialog --title "Install Multiprotocol VPN Panel" --menu "Select a VPN Panel to Install:" 15 60 8 \
    "1" "Easy-Peasy | Aleskxyz" \
    "2" "Hiddify | Clash" 2> vpn_choice.txt
     
  vpn_choice=$(cat vpn_choice.txt)

  case $vpn_choice in
    "1")
      bash <(curl -sL https://raw.githubusercontent.com/aleskxyz/reality-ezpz/master/reality-ezpz.sh)
      ;;
    "2")
      bash -c "$(curl -Lfo- https://raw.githubusercontent.com/hiddify/hiddify-config/main/common/download_install.sh)"
      ;;
    *)
      dialog --msgbox "Invalid choice. No VPN Panel installed." 10 40
      return
      ;;
  esac

  # Wait for the user to press Enter
  read -p "Please press Enter to continue."
  rm vpn_choice.txt
  # Return to the menu
}

# 7-Function to exit the script
exit_script() {
  clear  # Clear the terminal screen for a clean exit
  echo "Exiting the script. Goodbye!"
  exit 0  # Exit with a status code of 0 (indicating successful termination)
}

# Main menu options using dialog
while true; do
  choice=$(dialog --clear --backtitle "Proxy Installer - Main Menu" --title "Main Menu" --menu "Choose an option:" 18 60 15 \
    1 "System Update and Cleanup" \
    2 "Install System IP-Baning" \
    3 "Install Telegram Proxy" \
    4 "Install SSH Panel" \
    5 "Install Sing-Box" \
    6 "Install X-UI Panel" \
    7 "Install Multicore VPN Panel" \
    8 "Exit Proxy Installer" 3>&1 1>&2 2>&3)

  case $choice in
    1) system_update ;;
    2) system_ipban ;;
    3) install_mtproto_panel ;;
    4) install_ssh_panel ;;
    5) install_sing_panel ;;
    6) install_xui_panel ;;
    7) install_vpn_panel ;;
    8) exit_script ;;
    *) echo "Invalid option. Please try again." ;;
  esac
done
