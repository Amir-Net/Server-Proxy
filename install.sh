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

# 1-Function to system updates and cleanup
system_update() {
  dialog --title "System Update and Cleanup" --yesno "This operation will update your system and remove unnecessary packages. Do you want to proceed?" 10 60
  response=$?
  
  if [ $response -eq 0 ]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean -y
    sudo apt clean -y
    clear
    dialog --msgbox "System updates and cleanup completed." 10 60
  else
    dialog --msgbox "System updates and cleanup operation canceled." 10 60
  fi
}

# 2-Function to Install Telegram Proxy
install_mtproto_panel() {
  dialog --title "Install Telegram Proxy" --menu "Select a Telegram Proxy to Install:" 15 60 8 \
    "1" "Telegram Proxy by Officials | C-Lang" \
    "2" "Telegram Proxy by Alexbers | Python" \
    "3" "Telegram Proxy by Seriyps | Er-Lang" \
    "4" "Telegram Proxy by 9seconds | Go-Lang" > mtproto_choice.txt  
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
  
# 2-Function to Install SSH Panel
install_ssh_panel() {
  dialog --title "Install Multiprotocol SSH Panel" --menu "Select a SSH Panel to Install:" 15 60 8 \
    "1" "SSH-Panel | Alireza" \
    "2" "SSH-Panel | Vahid" > vpn_choice.txt
     
  ssh_choice=$(cat ssh_choice.txt)

  case $ssh_choice in
    "1")
      bash <(curl -Lfo https://raw.githubusercontent.com/xpanel-cp/XPanel-SSH-User-Management/master/install.sh --ipv4)
      ;;
    "2")
      wget -O ssh-panel-install.sh https://raw.githubusercontent.com/vfarid/ssh-panel/main/install.sh && sudo sh ssh-panel-install.sh
      ;;
    *)
      dialog --msgbox "Invalid choice. No SSH Panel installed." 10 40
      return
      ;;
  esac

  # Wait for the user to press Enter
  read -p "Please press Enter to continue."
  # Return to the menu
}

# 3-Function to Install Multiprotocol VPN Panel
install_vpn_panel() {
  dialog --title "Install Multiprotocol VPN Panel" --menu "Select a VPN Panel to Install:" 15 60 8 \
    "1" "X-UI | Alireza" \
    "2" "X-UI | MHSanaei" \
    "3" "X-UI | vaxilu" \
    "4" "X-UI | FranzKafkaYu" \
    "5" "X-UI En | FranzKafkaYu" \
    "6" "reality-ezpz | aleskxyz" \
    "7" "Hiddify" \
    "8" "Marzban | Gozargah" 2> vpn_choice.txt
     
  vpn_choice=$(cat vpn_choice.txt)

  case $vpn_choice in
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
      bash <(curl -sL https://raw.githubusercontent.com/aleskxyz/reality-ezpz/master/reality-ezpz.sh)
      ;;
    "7")
      bash -c "$(curl -Lfo- https://raw.githubusercontent.com/hiddify/hiddify-config/main/common/download_install.sh)"
      ;;
    "8")
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

  # Return to the menu
}

# 4-Function to exit the script
exit_script() {
  clear  # Clear the terminal screen for a clean exit
  echo "Exiting the script. Goodbye!"
  exit 0  # Exit with a status code of 0 (indicating successful termination)
}

# Main menu options using dialog
while true; do
  choice=$(dialog --clear --backtitle "Proxy Installer - Main Menu" --title "Main Menu" --menu "Choose an option:" 18 60 15 \
    1 "System Update and Cleanup" \
    
    8 "Install Multiprotocol VPN Panels" \
    9 "Obtain SSL Certificates" \
    10 "Setup Pi-Hole" \
    11 "Change SSH Port" \
    12 "Enable UFW" \
    13 "Install & Configure WARP Proxy" \
    14 "Setup MTProto Proxy" \
    15 "Setup/Manage Hysteria II" \
    16 "Setup/Manage TUIC v5" \
    17 "Setup/Manage Juicity" \
    18 "Setup/Manage WireGuard" \
    19 "Setup/Manage OpenVPN" \
    20 "Setup IKEv2/IPsec" \
    21 "Setup Reverse TLS Tunnel" \
    22 "Create SSH User" \
    23 "Reboot System" \
    24 "Exit Script" 3>&1 1>&2 2>&3)

  case $choice in
    1) system_update ;;
    2) install_essential_packages ;;
    3) install_speedtest ;;
    4) create_swap_file ;;
    5) enable_bbr ;;
    6) enable_hybla ;;
    7) enable_and_configure_cron ;;
    8) install_vpn_panel ;;
    9) obtain_ssl_certificates ;;
    10) setup_pi_hole ;;
    11) change_ssh_port ;;
    12) enable_ufw ;;
    13) install_configure_warp_proxy ;;
    14) setup_mtproto_proxy ;;
    15) setup_hysteria_ii ;;
    16) setup_tuic_v5 ;;
    17) setup_juicity ;;
    18) setup_wireguard_angristan ;;
    19) setup_openvpn_angristan ;;
    20) setup_ikev2_ipsec ;;
    21) setup_reverse_tls_tunnel ;;
    22) create_ssh_user ;;
    23) reboot_system ;;
    24) exit_script ;;
    *) echo "Invalid option. Please try again." ;;
  esac
done
