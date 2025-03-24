#!/data/data/com.termux/files/usr/bin/bash

# Define color codes
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

# Function to display banner
display_banner() {
    local term_width=$(stty size | cut -d" " -f2)

    echo -e "${BLUE}" # Set text color to blue
    figlet -c -w "$term_width" "Metasploit"
    echo -e "${GREEN} Coded by: HYDRA TERMUX ${RESET}"
}

# Function to center text with color
align_text() {
    local term_width=$(stty size | cut -d" " -f2)
    local text="$1"
    local color="$2"
    local padding="$(printf '%0.1s' ={1..500})"

    echo -e "${color}" # Set text color
    printf '%*.*s %s %*.*s\n' 0 "$(((term_width-2-${#text})/2))" "$padding" "$text" 0 "$(((term_width-1-${#text})/2))" "$padding"
    echo -e "${RESET}" # Reset text color
}

# Function to show a loading animation
loading_animation() {
    local spin='|/-\'
    local i=0
    while [ $i -lt 10 ]; do
        printf "\r${YELLOW}[%c] Setting up...${RESET}" "${spin:i++%${#spin}:1}"
        sleep 0.2
    done
    echo ""
}

clear
display_banner
align_text "Starting installation..." "${BLUE}"
loading_animation

# Update & install dependencies
align_text "* Updating packages..." "${YELLOW}"
pkg update -y && pkg upgrade -y

align_text "* Installing dependencies..." "${YELLOW}"
deps=(binutils python autoconf bison clang coreutils curl findutils apr apr-util postgresql openssl readline libffi libgmp libpcap libsqlite libgrpc libtool libxml2 libxslt ncurses make ncurses-utils ncurses git wget unzip zip tar termux-tools termux-elf-cleaner pkg-config ruby)

for pkg in "${deps[@]}"; do
    pkg install -y "$pkg"
done

python3 -m pip install requests

# Remove old Metasploit if exists
align_text "* Checking for old Metasploit installation..." "${YELLOW}"
if [ -d "${PREFIX}/opt/metasploit-framework" ]; then
    rm -rf ${PREFIX}/opt/metasploit-framework
    align_text "✔ Old version removed." "${GREEN}"
fi

# Download & install Metasploit
align_text "* Downloading Metasploit..." "${BLUE}"
mkdir -p ${PREFIX}/opt
git clone https://github.com/rapid7/metasploit-framework.git --depth=1 ${PREFIX}/opt/metasploit-framework

align_text "* Installing Metasploit..." "${BLUE}"
cd ${PREFIX}/opt/metasploit-framework
gem install bundler
nokogiri_version=$(grep -i nokogiri Gemfile.lock | awk '{print $2}')
gem install nokogiri -v $nokogiri_version -- --use-system-libraries --with-cflags="-Wno-implicit-function-declaration -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types"
bundle install
gem install actionpack
bundle update activesupport
bundle update --bundler
bundle install -j$(nproc --all)

# Create executable symlinks
align_text "* Finalizing installation..." "${YELLOW}"
ln -sf ${PREFIX}/opt/metasploit-framework/msfconsole ${PREFIX}/bin/
ln -sf ${PREFIX}/opt/metasploit-framework/msfvenom ${PREFIX}/bin/
ln -sf ${PREFIX}/opt/metasploit-framework/msfrpcd ${PREFIX}/bin/
termux-elf-cleaner ${PREFIX}/lib/ruby/gems/*/gems/pg-*/lib/pg_ext.so

# Completion message
echo -e "${GREEN}" # Set text color to green
align_text "✔ Installation complete!" "${GREEN}"
echo -e "\n${YELLOW}Run Metasploit using: ${GREEN}msfconsole${RESET}"
