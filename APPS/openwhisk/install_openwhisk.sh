#!/bin/bash

# Create some Stuff
echo "Prepare some Stuff"


cd ~/INSTALL/APPS
sudo rm -r ~/INSTALL/APPS/OpenWhisk

kubectl create namespace openwhisk

kubectl label nodes --all openwhisk-role=invoker
git clone https://github.com/apache/incubator-openwhisk-deploy-kube.git OpenWhisk

cd ~/INSTALL/APPS/OpenWhisk/helm/openwhisk

echo "Install Chart"
helm install . --namespace=openwhisk --name=openwhisk -f ~/INSTALL/KUBE/OPENWHISK/openwhisk.yaml --tls

echo "Install Command Line"
mkdir -p ~/INSTALL/APPS/OpenWhisk/tmp
cd ~/INSTALL/APPS/OpenWhisk/tmp
wget https://github.com/apache/incubator-openwhisk-cli/releases/download/latest/OpenWhisk_CLI-latest-linux-amd64.tgz

tar xvfz OpenWhisk_CLI-latest-linux-amd64.tgz
sudo mv wsk /usr/local/bin
alias wsk='wsk -i'
cd ~/INSTALL

echo "Configure Command Line"
wsk property set --apihost ${PUBLIC_IP}:31001
wsk property set --auth 23bc46b1-71f6-4ed5-8c54-816aa4f8c502:123zO3xZCLrMN6v2BKK1dXYFpXlPkccOFqm12CdAsMgRU4VrNZ9lyGVCGuMDGIwP
