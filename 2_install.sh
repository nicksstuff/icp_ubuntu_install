#!/bin/bash

echo "Installing ICP CE";
cd ~/INSTALL/cluster
sudo docker run -e LICENSE=accept --net=host -t -v "~INSTALL/icp_install/icp_ubuntu_install/INSTALL/cluster":/installer/cluster ibmcom/icp-inception:2.1.0.3 install | sudo tee install.log

