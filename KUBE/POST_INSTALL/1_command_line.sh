#!/bin/bash

source ~/INSTALL/0_variables.sh

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
  echo "Installing Command Line Tools";
  # Install Command Line Tools

  echo "Installing kubectl";
  curl -kLo kubectl-linux-amd64-v1.11.1 https://$MASTER_IP:8443/api/cli/kubectl-linux-amd64


  echo "Installing IBMCLOUD Command Line & Plugin";
  curl -kLo cloudctl-linux-amd64-3.1.0-715 https://$MASTER_IP:8443/api/cli/cloudctl-linux-amd64

  sudo cloudctl login -a https://${MASTER_IP}:8443 --skip-ssl-validation
  #sudo cloudctl clusters
  #sudo cloudctl cluster-config mycluster

  echo "Installing helm";
  #Install HELM CLI
  curl -kLo helm-linux-amd64-v2.9.1.tar.gz https://$MASTER_IP:8443/api/cli/helm-linux-amd64.tar.gz

  echo "Installing istio ctl";
  curl -kLo istioctl-linux-amd64-v1.0.0 https://$MASTER_IP:8443/api/cli/istioctl-linux-amd64


  echo "Configuring helm";
  sudo helm init --client-only
  sudo cp /root/.helm/cert.pem ~/.helm/
  sudo cp /root/.helm/key.pem ~/.helm/
  sudo  helm version --tls

  sudo chown -R icp:icp ~/.kube/
  sudo chown -R icp:icp ~/.helm/
  sudo chown -R icp:icp ~/.cloudctl/
