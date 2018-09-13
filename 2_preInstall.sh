#!/bin/bash

source ~/INSTALL/0_variables.sh


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Prerequisites";

sudo apt-get  --yes --force-yes install snapd apt-transport-https ca-certificates curl software-properties-common python-minimal



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Docker"
# INSTALL DOCKER
#snap install docker

sudo apt install apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"


#sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get --yes --force-yes update
sudo apt-get install --yes docker-ce


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Python"
sudo apt-get update
#sudo apt install python

# Install Command Line Tools
echo "Installing Tools";
sudo apt-get --yes --force-yes install tree
sudo apt-get --yes --force-yes install htop
sudo apt-get --yes --force-yes install curl
sudo apt-get --yes --force-yes install unzip
sudo apt-get --yes --force-yes install iftop


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Adapt Environment"
# Set VM max map count (see max_map_count https://www.kernel.org/doc/Documentation/sysctl/vm.txt)
sudo sysctl -w vm.max_map_count=262144

sudo cat <<EOB >>/etc/sysctl.conf
vm.max_map_count=262144
EOB

# Sync time
sudo ntpdate -s time.nist.gov


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Configure Firewall"
sudo ufw disable









echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "INSTALL WORKERS"

for ((i=0; i < $NUM_WORKERS; i++)); do
  if [[ $WORKER_IPS[i] != "n" ||  $MASTER_IP == "N" ]]; then
    cat ~/INSTALL/KUBE/REMOTE_PREPARE/preInstallRemote.sh | ssh root@${WORKER_IPS[i]} 'bash -s'
  fi
done

if [ "$MONITORING_IP" != "x.x.x.x" ]; then
    cat ~/INSTALL/KUBE/REMOTE_PREPARE/preInstallRemote.sh | ssh root@${MONITORING_IP} 'bash -s'
fi










echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "INSTALL INCEPTION"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"



#echo "Creating SSH Key";
#ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -N ""
#cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys
#ssh-copy-id -i ~/.ssh/id_rsa.pub root@

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Fetch Docker Inception Image"
sudo docker pull ibmcom/icp-inception:${ICP_VERSION}


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Creating Cluster Directory";
cd ~/INSTALL
sudo docker run -e LICENSE=accept -v "$(pwd)":/data ibmcom/icp-inception:${ICP_VERSION} cp -r cluster /data


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Adapting Config";

# Configure hosts
echo "[master]" | sudo tee ~/INSTALL/cluster/hosts
echo "${MASTER_IP}" | sudo tee -a ~/INSTALL/cluster/hosts
echo "" | sudo tee -a ~/INSTALL/cluster/hosts

echo "[worker]" | sudo tee -a ~/INSTALL/cluster/hosts
for ((i=0; i < $NUM_WORKERS; i++)); do
  echo ${WORKER_IPS[i]} | sudo tee -a ~/INSTALL/cluster/hosts
done
echo "" | sudo tee -a ~/INSTALL/cluster/hosts

echo "[proxy]" | sudo tee -a ~/INSTALL/cluster/hosts
echo "${MASTER_IP}" | sudo tee -a ~/INSTALL/cluster/hosts
echo "" | sudo tee -a ~/INSTALL/cluster/hosts



if [ "$MONITORING_IP" != "x.x.x.x" ]; then
  echo "[monitoring]" | sudo tee -a ~/INSTALL/cluster/hosts
  echo "${MONITORING_IP}" | sudo tee -a ~/INSTALL/cluster/hosts
else
  echo "No separate monitoring node"
fi

# Add line for external IP in config
echo "cluster_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/cluster/config.yaml
echo "proxy_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/cluster/config.yaml

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Copy SSH Key";
echo "there might be an error, but should be ok";
sudo cp ~/.ssh/id_rsa ~/INSTALL/cluster/ssh_key
sudo cp ~/.ssh/master.id_rsa ~/INSTALL/cluster/ssh_key
sudo chmod 400 ~/INSTALL/cluster/ssh_key
