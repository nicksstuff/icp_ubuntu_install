#!/bin/bash

source ~/INSTALL/0_variables.sh

mkdir -p ~/INSTALL/APPS

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Command Line Tools? [y,N]" DO_COMM
if [[ $DO_COMM == "y" ||  $DO_COMM == "Y" ]]; then
  echo "Installing Command Line Tools";
  # Install Command Line Tools

  echo "Installing kubectl";
  docker run -e LICENSE=accept --net=host -v /usr/local/bin:/data ibmcom/icp-inception:2.1.0.3 cp /usr/local/bin/kubectl /data


  echo "Installing IBMCLOUD Command Line & Plugin";
  curl -sL http://ibm.biz/idt-installer | bash

  wget https://mycluster.icp:8443/api/cli/icp-linux-amd64 --no-check-certificate
  ibmcloud plugin install icp-linux-amd64

  sudo ibmcloud pr login -a https://${MASTER_IP}:8443 --skip-ssl-validation
  sudo ibmcloud pr clusters
  sudo ibmcloud pr cluster-config mycluster

  echo "Installing helm";
  #Install HELM CLI
  docker run -e LICENSE=accept --net=host -v /usr/local/bin:/data ibmcom/icp-helm-api:1.0.0 cp /usr/src/app/public/cli/linux-amd64/helm /data

  echo "Configuring helm";
  sudo helm init --client-only
  sudo cp /root/.helm/cert.pem ~/.helm/
  sudo cp /root/.helm/key.pem ~/.helm/
  sudo  helm version --tls

  sudo chown -R icp:icp ~/.kube/
  sudo chown -R icp:icp ~/.helm/

else
  echo "Command Line Tools not configured"
fi



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing kube config";
#INIT KUBECTL
mkdir ~/.kube
cp /var/lib/kubelet/kubectl-config ~/.kube/config


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure OpenLDAP? [y,N]" DO_LDAP
if [[ $DO_LDAP == "y" ||  $DO_LDAP == "Y" ]]; then
  # Install OpenLDAP
  echo "Install OpenLDAP "
  echo "Use mycluster.icp as DNS Domain Name"
  echo "and icp as Organization Name"
  sudo apt-get update
  sudo apt-get --yes --force-yes install slapd ldap-utils
  sudo dpkg-reconfigure slapd

  # Create LDAP Users
  echo "Create LDAP Users"
  ldapadd -x -D cn=admin,dc=mycluster,dc=icp -W -f  ~/INSTALL/KUBE/LDAP/addldapcontent.ldif

  echo "Import LDAP Users "
  export ACCESS_TOKEN=$(curl -k -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d "grant_type=password&username=admin&password=admin&scope=openid" https://${MASTER_IP}:8443/idprovider/v1/auth/identitytoken --insecure |       python3 -c "import sys, json; print(json.load(sys.stdin)['access_token'])")
  echo "$ACCESS_TOKEN"
  curl -k -X POST --header "Authorization: bearer $ACCESS_TOKEN" --header 'Content-Type: application/json' -d '{"LDAP_BINDPASSWORD": "admin", "LDAP_ID":"LDAP","LDAP_REALM":"REALM","LDAP_HOST":"'${MASTER_IP}'","LDAP_PORT":"389","LDAP_IGNORECASE":"false","LDAP_BASEDN":"dc=mycluster,dc=icp","LDAP_BINDDN":"cn=admin,dc=mycluster,dc=icp","LDAP_TYPE":"Custom","LDAP_USERFILTER":"(&(uid=%v)(objectclass=person))","LDAP_GROUPFILTER":"(&(cn=%v)(objectclass=groupOfUniqueNames))","LDAP_USERIDMAP":"*:uid","LDAP_GROUPIDMAP":"*:cn","LDAP_GROUPMEMBERIDMAP":"groupOfUniqueNames:uniqueMember","LDAP_URL":"ldap://'${MASTER_IP}':389","LDAP_PROTOCOL":"ldap"}' 'https://'${MASTER_IP}':8443/idmgmt/identity/api/v1/directory/ldap/onboardDirectory'

else
  echo "LDAP not configured"
fi


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure PersistentVolumes? [y,N]" DO_PV
if [[ $DO_PV == "y" ||  $DO_PV == "Y" ]]; then
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
else
  echo "PersistentVolumes not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Alert Manager? [y,N]" DO_AM
if [[ $DO_AM == "y" ||  $DO_AM == "Y" ]]; then
  # Create ALERTS
  echo "Create ALERTS"

  kubectl -n kube-system delete -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertrules_config.yaml
  kubectl -n kube-system delete -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertmanager_config.yaml

  kubectl -n kube-system apply -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertrules_config.yaml
  kubectl -n kube-system apply -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertmanager_config.yaml
else
  echo "Alert Manager not configured"
fi


read -p "Install and configure CALICO Commandline? [y,N]" DO_CAL
if [[ $DO_CAL == "y" ||  $DO_CAL == "Y" ]]; then
  # Create ALERTS
  echo "Download CALICO Commandline"
  docker run -v /root:/data --entrypoint=cp ibmcom/calico-ctl:v2.0.2 /calicoctl /data
  sudo cp /root/calicoctl /usr/local/bin/
  export ETCD_CERT_FILE=/etc/cfc/conf/etcd/client.pem
  export ETCD_CA_CERT_FILE=/etc/cfc/conf/etcd/ca.pem
  export ETCD_KEY_FILE=/etc/cfc/conf/etcd/client-key.pem
  export ETCD_ENDPOINTS=https://mycluster.icp:4001

else
  echo "CALICO Commandline not configured"
fi



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Demo Stuff? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Create some Stuff"
  cd ~/INSTALL/
  kubectl create namespace dev-namespace
  kubectl create namespace test-namespace

  kubectl create -f ~/INSTALL/KUBE/CONFIG/devlimits_quota.yaml
  kubectl create -f ~/INSTALL/KUBE/CONFIG/restricted_policy.yaml
  kubectl create -f ~/INSTALL/KUBE/CONFIG/privileged_policy.yaml
  kubectl create -f ~/INSTALL/KUBE/CONFIG/calico_demo.yaml

  cat ~/INSTALL/KUBE/CONFIG/bashrc_add_stress.sh >> ~/.bashrc

else
  echo "Stuff not configured"
fi



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "ALL DONE"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Please execute 'source ~/.bashrc'"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Configure LDAP"
echo "-----------------------------------------------------------------------------------------------------------"
echo "LDAP_ID               : OPENLDAP"
echo "LDAP_URL              : ldap://${PUBLIC_IP}:389"
echo "LDAP_BASEDN           : dc=mycluster,dc=icp"
echo "LDAP_BINDDN           : cn=admin,dc=mycluster,dc=icp"
echo "LDAP_BINDPASSWORD     : admin"
echo "LDAP_TYPE             : Custom"
echo "LDAP_USERFILTER       : (&(uid=%v)(objectclass=person))"
echo "LDAP_GROUPFILTER      : (&(cn=%v)(objectclass=groupOfUniqueNames))"
echo "LDAP_USERIDMAP        :  *:uid"
echo "LDAP_GROUPIDMAP       : *:cn"
echo "LDAP_GROUPMEMBERIDMAP : groupOfUniqueNames:uniquemember"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Add Repositories"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Charts"
echo "https://raw.githubusercontent.com/niklaushirt/charts/master/helm/charts/repo/stable/"
echo ""
echo "Liberty Simple"
echo "https://raw.githubusercontent.com/niklaushirt/demoliberty/master/charts/stable/repo/stable/"
echo ""
echo "Service Broker"
echo "https://raw.githubusercontent.com/niklaushirt/servicebroker/master/charts/repo/stable/"
