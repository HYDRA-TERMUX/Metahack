#!/data/data/com.termux/files/usr/bin/bash

# Define color codes
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# Function to show banner
show_banner() {
    echo -e "${BLUE}"
    figlet "METAHACK"
    echo -e "${RESET}"
echo -e "${GREEN}                             Coded by: HYDRA TERMUX ${RESET}"
}

# Function to show menu
show_menu() {
    echo -e "${CYAN}Select an option:${RESET}"
    echo -e "${YELLOW}[1] Install Metasploit${RESET}"
    echo -e "${YELLOW}[2] Show Guide${RESET}"
    echo -e "${YELLOW}[3] Uninstall Metasploit${RESET}"
    echo -e "${YELLOW}[4] Update Metasploit${RESET}"
    echo -e "${YELLOW}[5] About Me${RESET}"
    echo -e "${YELLOW}[6] Run Metasploit${RESET}"
    echo -e "${YELLOW}[7] Exit${RESET}"
}

# Function to show loading animation
loading_animation() {
    local spin='|/-\'
    local i=0
    while [ $i -lt 10 ]; do
        printf "\r${YELLOW}[%c] Please wait...${RESET}" "${spin:i++%${#spin}:1}"
        sleep 0.2
    done
    echo ""
}

# Function to install Metasploit
install_metasploit() {
    echo -e "${YELLOW}[*] Downloading Metasploit installer...${RESET}"
    curl -o installmsf.sh https://raw.githubusercontent.com/HYDRA-TERMUX/Metahack/main/installmsf.sh
    if [ -f "installmsf.sh" ]; then
        chmod +x installmsf.sh
        echo -e "${GREEN}[✔] Installer downloaded successfully.${RESET}"
        echo -e "${YELLOW}[*] Installing Metasploit...${RESET}"
        loading_animation
        ./installmsf.sh
        echo -e "${GREEN}[✔] Installation complete! Run 'msfconsole' to start.${RESET}"
    else
        echo -e "${RED}[✖] Failed to download installer. Check the URL.${RESET}"
    fi
}

# Function to show guide
show_guide() {
    echo -e "${YELLOW}[*] Opening guide...${RESET}"
    termux-open-url https://hydra-termux.github.io/websites/
}

# Function to uninstall Metasploit
uninstall_metasploit() {
    echo -e "${YELLOW}[*] Uninstalling Metasploit...${RESET}"
    rm -rf $PREFIX/opt/metasploit-framework
    rm -f $PREFIX/bin/msfconsole $PREFIX/bin/msfvenom $PREFIX/bin/msfrpcd
    echo -e "${GREEN}[✔] Metasploit uninstalled successfully.${RESET}"
}

# Function to update Metasploit
update_metasploit() {
    echo -e "${YELLOW}[*] Updating Metasploit...${RESET}"
    cd $PREFIX/opt/metasploit-framework || { echo -e "${RED}[✖] Metasploit not installed.${RESET}"; return; }
    git pull
    bundle install
    echo -e "${GREEN}[✔] Metasploit updated successfully.${RESET}"
}

# Function to show "About Me"
about_me() {
    echo -e "${YELLOW}[*] Opening About Me page...${RESET}"
    termux-open-url https://github.com/HYDRA-TERMUX
}

# Function to run Metasploit
run_metasploit() {
    echo -e "${YELLOW}[*] Starting Metasploit...${RESET}"
    msfconsole
}

# Main menu loop
while true; do
    clear
    show_banner
    show_menu
    echo -ne "${CYAN}Enter your choice: ${RESET}"
    read choice

    case $choice in
        1) install_metasploit ;;
        2) show_guide ;;
        3) uninstall_metasploit ;;
        4) update_metasploit ;;
        5) about_me ;;
        6) run_metasploit ;;
        7) echo -e "${GREEN}[✔] Exiting...${RESET}"; exit 0 ;;
        *) echo -e "${RED}[✖] Invalid option! Please try again.${RESET}" ;;
    esac

    echo -e "${YELLOW}Press Enter to continue...${RESET}"
    read
done
