#!/bin/bash

source ~/INSTALL/0_variables.sh

# Create PersistentVolumes
echo "Install NFS Server"
sudo apt-get --yes --force-yes install nfs-kernel-server

# Create NFS Directories
echo "Create NFS Directories"
sudo mkdir -p /storage/
sudo mkdir -p /storage/nfsvol01rwo
sudo mkdir -p /storage/nfsvol02rwm
sudo mkdir -p /storage/nfsvol03rwo
sudo mkdir -p /storage/nfsvol04rwm
sudo mkdir -p /storage/nfsvol05rwo
sudo mkdir -p /storage/nfsvol06rwm
sudo mkdir -p /storage/nfsvol07rwo
sudo mkdir -p /storage/nfsvol08rwm
sudo mkdir -p /storage/nfsvol11rwo
sudo mkdir -p /storage/nfsvol12rwo
sudo mkdir -p /storage/nfsvol13rwo
sudo mkdir -p /storage/nfsvol14rwo
sudo mkdir -p /storage/nfsvol15rwo
sudo mkdir -p /storage/nfsvol16rwo
sudo mkdir -p /storage/nfsvol17rwo
sudo mkdir -p /storage/nfsvol18rwo
sudo mkdir -p /storage/dsx
sudo mkdir -p /storage/TRA_data
sudo mkdir -p /storage/data-stor
sudo mkdir -p /storage/hadr-stor
sudo mkdir -p /storage/etcd-stor
sudo mkdir -p /storage/pv0001
sudo mkdir -p /storage/pv0002
sudo mkdir -p /storage/CAM_db
sudo mkdir -p /storage/CAM_logs
sudo mkdir -p /storage/CAM_terraform
sudo mkdir -p /storage/CAM_bpd

sudo chmod -R 777 /storage
sudo chown -R nobody:nogroup /storage

# Configure NFS
echo "Configure NFS"
echo "/storage           *(rw,sync,no_subtree_check,async,insecure,no_root_squash)" | sudo tee -a /etc/exports
sudo systemctl restart nfs-kernel-server
sudo exportfs -a


# Create PersistentVolumes
echo "Create PersistentVolumes"
kubectl apply -f ~/INSTALL/KUBE/PV/pv.yaml
