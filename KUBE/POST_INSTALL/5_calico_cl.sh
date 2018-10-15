#!/bin/bash

source ~/INSTALL/0_variables.sh


# Create ALERTS
echo "Download CALICO Commandline"
docker run -v /root:/data --entrypoint=cp ibmcom/calico-ctl:v2.0.2 /calicoctl /data
sudo cp /root/calicoctl /usr/local/bin/
export ETCD_CERT_FILE=/etc/cfc/conf/etcd/client.pem
export ETCD_CA_CERT_FILE=/etc/cfc/conf/etcd/ca.pem
export ETCD_KEY_FILE=/etc/cfc/conf/etcd/client-key.pem
export ETCD_ENDPOINTS=https://mycluster.icp:4001
