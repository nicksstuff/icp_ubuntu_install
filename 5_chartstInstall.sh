#!/bin/bash

source ~/INSTALL/0_variables.sh


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure CAM? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  helm delete --purge cam --tls

cd ~/INSTALL/
  helm repo add ibm-stable https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
  helm repo update
  helm fetch ibm-stable/ibm-cam-prod --version 1.2.1

  kubectl delete secret camsecret -n services
  kubectl create secret docker-registry camsecret --docker-username=${DOCKER_HUB_LOGIN} --docker-password=${DOCKER_HUB_PWD} --docker-email=${DOCKER_HUB_MAIL} -n services

  echo "Install Chart"
  helm install --name cam ibm-cam-prod-1.2.1.tgz --namespace services --set arch=amd64 --set global.image.secretName=camsecret --tls
else
  echo "CAM not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Spinnaker? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  helm delete --purge spinnaker --tls

  kubectl create namespace spinnaker

  cd ~/INSTALL/

  echo "Install Chart"
  helm install --namespace=spinnaker --name spinnaker --set kubeConfig.contexts=[icp-cluster1] --set deck.ingress.enabled=true --set deck.host=spinnaker.icp.cloud.com stable/spinnaker --tls
else
  echo "Spinnaker not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure OpenFaaS? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  helm delete --purge openfaas --tls

  cd ~/INSTALL/
  kubectl create namespace openfaas
  kubectl create namespace openfaas-fn
  helm repo add openfaas https://openfaas.github.io/faas-netes/

  echo "Install Chart"
  helm upgrade openfaas --install openfaas/openfaas --namespace openfaas --set functionNamespace=openfaas-fn --tls
else
  echo "OpenFaaS not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure OpenWhisk? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  helm delete --purge openwhisk --tls


  cd ~/INSTALL/
  sudo rm -r ~/INSTALL/OpenWhisk

  kubectl create namespace ow

  kubectl label nodes --all openwhisk-role=invoker
  git clone https://github.com/apache/incubator-openwhisk-deploy-kube.git OpenWhisk

  cd OpenWhisk/helm

  echo "Install Chart"
  helm install . --namespace=ow --name=openwhisk -f ~/INSTALL/KUBE/OPENWHISK/openwhisk.yaml --tls

  echo "Install Command Line"
  mkdir -p ~/INSTALL/TEMP
  cd ~/INSTALL/TEMP
  wget https://github.com/apache/incubator-openwhisk-cli/releases/download/latest/OpenWhisk_CLI-latest-linux-amd64.tgz

  tar xvfz OpenWhisk_CLI-latest-linux-amd64.tgz
  sudo mv wsk /usr/local/bin
  alias wsk='wsk -i'
  cd ~/INSTALL

  echo "Configure Command Line"
  wsk property set --apihost ${PUBLIC_IP}:31001
  wsk property set --auth 23bc46b1-71f6-4ed5-8c54-816aa4f8c502:123zO3xZCLrMN6v2BKK1dXYFpXlPkccOFqm12CdAsMgRU4VrNZ9lyGVCGuMDGIwP
else
  echo "OpenWhisk not configured"
fi


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "ALL DONE"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "If you have installed OpenWhisk you can test it:"
echo "wsk -i list"
echo "wsk -i action create hello ~/INSTALL/KUBE/OPENWHISK/hello.js"
echo "wsk -i action list"
echo "wsk -i action invoke --blocking hello"
echo "wsk -i action invoke -r hello"
fi
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Add Repositories"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Charts"
echo "https://raw.githubusercontent.com/niklaushirt/charts/master/charts/repo/stable/"
echo ""
echo "Liberty Simple"
echo "https://raw.githubusercontent.com/niklaushirt/demoliberty/master/charts/stable/repo/stable/"
echo ""
echo "Service Broker"
echo "https://raw.githubusercontent.com/niklaushirt/servicebroker/master/charts/repo/stable/"
