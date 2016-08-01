#!/bin/bash
echo "Checking for root priviledges.."
ROOT_UID=0
if [ $UID != $ROOT_UID ]; then
	echo "This script must be ran with sudo."
	exit 1
fi
echo "Check passed."

echo "This script will install the Azure docker volume driver 0.4.0"
echo "Driver 0.4.0 might be incompatible with docker versions beyond 1.11"

wget -qO /usr/bin/azurefile-dockervolumedriver https://github.com/Azure/azurefile-dockervolumedriver/releases/download/0.4.0/azurefile-dockervolumedriver
chmod +x /usr/bin/azurefile-dockervolumedriver

cp azurefile-dockervolumedriver.default /etc/default/azurefile-dockervolumedriver
cp azurefile-dockervolumedriver.service /etc/systemd/azurefile-dockervolumedriver.service

echo "Storage account credentials are set in /etc/default/azurefile-dockervolumedriver."
echo "You will have to add your username and password."

mkdir -p /etc/systemd/systemd
systemctl daemon-reload
systemctl enable azurefile-dockervolumedriver
systemctl start azurefile-dockervolumedriver

echo "azurefile-dockervolumedriver status:"
systemctl status azurefile-dockervolumedriver

