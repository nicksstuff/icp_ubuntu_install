#!/bin/bash

# Create some Stuff
echo "Prepare some Stuff"

cd ~/INSTALL/APPS/blockchain

git clone https://github.com/IBM-Blockchain/ibm-container-service

cd ~/INSTALL/APPS/blockchain/ibm-container-service/cs-offerings/scripts

echo "Install BLOCKCHAIN"
./create_all.sh
