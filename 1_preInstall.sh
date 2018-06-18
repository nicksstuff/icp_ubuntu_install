#!/bin/bash

source ~/INSTALL/0_variables.sh





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Prerequisites";
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common python-minimal


# Set VM max map count (see max_map_count https://www.kernel.org/doc/Documentation/sysctl/vm.txt)
sudo sysctl -w vm.max_map_count=262144

sudo cat <<EOB >>/etc/sysctl.conf
  vm.max_map_count=262144
EOB

# Sync time
sudo ntpdate -s time.nist.gov



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Docker"
# INSTALL DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  stable"
sudo apt-get update
sudo apt-get --yes --force-yes install docker-ce=17.09.0~ce-0~ubuntu


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Configure Firewall"
#DISABLE FIREWALL
sudo ufw disable

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Adapting Config";
# Back up and adapt old hosts file
sudo cp /etc/hosts /etc/hosts.bak


echo "127.0.0.1 localhost" | sudo tee /etc/hosts
echo "" | sudo tee -a /etc/hosts

echo "fe00::0 ip6-localnet" | sudo tee -a /etc/hosts
echo "ff00::0 ip6-mcastprefix" | sudo tee -a /etc/hosts
echo "ff02::1 ip6-allnodes" | sudo tee -a /etc/hosts
echo "ff02::2 ip6-allrouters" | sudo tee -a /etc/hosts
echo "ff02::3 ip6-allhosts" | sudo tee -a /etc/hosts
echo "" | sudo tee -a /etc/hosts


# Loop through the array
for ((i=0; i < $NUM_WORKERS; i++)); do
  echo "${WORKER_IPS[i]} ${WORKER_HOSTNAMES[i]}" | sudo tee -a /etc/hosts
done
echo "" | sudo tee -a /etc/hosts

sudo cp /etc/hosts ~/worker-hosts
sudo chown $USER ~/worker-hosts

echo "$MASTER_IP mycluster.icp" | sudo tee -a /etc/hosts


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Tools"
sudo apt-get update
sudo ufw disable
sudo apt install python

sudo apt-get --yes --force-yes install tree
sudo apt-get --yes --force-yes install htop
sudo apt-get --yes --force-yes install curl
sudo apt-get --yes --force-yes install unzip
sudo apt-get --yes --force-yes install iftop

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
sudo docker run -e LICENSE=accept -v "~INSTALL/icp_install/icp_ubuntu_install/INSTALL":/data ibmcom/icp-inception:${ICP_VERSION} cp -r cluster /data


echo "Adapting Host IP";

# Configure hosts
echo "[master]" | sudo tee ~/INSTALL/hosts
echo "${MASTER_IP}" | sudo tee -a ~/INSTALL/hosts
echo "" | sudo tee -a ~/INSTALL/hosts

echo "[worker]" | sudo tee -a ~/INSTALL/hosts
for ((i=0; i < $NUM_WORKERS; i++)); do
  echo ${WORKER_IPS[i]} | sudo tee -a ~/INSTALL/hosts
done
echo "" | sudo tee -a ~/INSTALL/hosts

echo "[proxy]" | sudo tee -a ~/INSTALL/hosts
echo "${MASTER_IP}" | sudo tee -a ~/INSTALL/hosts

# Add line for external IP in config
echo "cluster_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/config.yaml
echo "proxy_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/config.yaml


echo "Copy SSH Key";
sudo mv hosts ~/INSTALL/cluster
sudo cp ~/.ssh/id_rsa ~/INSTALL/cluster/ssh_key
sudo chmod 400 ~/INSTALL/cluster/ssh_key
