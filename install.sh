#!/bin/bash

# Colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

# 📌 HIDDEN SIGNATURE (DO NOT REMOVE)
SIGNATURE="HYDRA-TERMUX-SECRET-SIGNATURE"

# 📌 SELF-CHECK: If the signature is missing, the script stops
if ! grep -q "$SIGNATURE" "$0"; then
    echo -e "${RED}❌ ERROR: Script integrity check failed!${RESET}"
    echo -e "${RED}This script has been modified or stolen.${RESET}"
    exit 1
fi

# Check and install required tools
echo -e "${YELLOW}🔍 Checking required tools...${RESET}"
sleep 1

if ! command -v xdg-open &> /dev/null && ! command -v termux-open-url &> /dev/null; then
    echo -e "${RED}❌ Missing required tools! Installing...${RESET}"
    apt update -y
    apt install xdg-utils -y || apt install termux-tools -y
    echo -e "${GREEN}✅ Tools installed successfully!${RESET}"
else
    echo -e "${GREEN}✅ All required tools are installed!${RESET}"
fi

# Animated loading effect
echo -e "${BLUE}🔹 Opening YouTube Channel...${RESET}"
echo -e "\n${GREEN}🚀 Launching YouTube...${RESET}"

# Open YouTube Channel
xdg-open https://YouTube.com/@HYDRATERMUX 2>/dev/null || termux-open-url https://www.youtube.com/@HYDRATERMUX?sub_confirmation=1 2>/dev/null

# Wait for 9 seconds before running Metarun
echo -e "${YELLOW}⏳ Waiting for 9 seconds...${RESET}"
sleep 9

# Grant execute permissions for installmsf.sh & metarun.sh
echo -e "${GREEN}✅ Granting execute permissions...${RESET}"
chmod +x installmsf.sh metarun.sh
pkg install figlet -y

# Run Metarun script
echo -e "${YELLOW}🚀 Running Metarun...${RESET}"
./metarun.sh

# HYDRA-TERMUX-SECRET-SIGNATURE
