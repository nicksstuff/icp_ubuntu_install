#!/bin/bash

echo "Installing ICP CE";
cd ~/INSTALL/cluster
sudo docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/icp-inception:${ICP_VERSION} install
