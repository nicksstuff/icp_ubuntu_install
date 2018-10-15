#!/bin/bash

source ~/INSTALL/0_variables.sh

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure WeaveScope? [y,N]" DO_WVS
if [[ $DO_WVS == "y" ||  $DO_STF == "Y" ]]; then
  ~/INSTALL/APPS/weavescope/install_weavescope.sh
else
  echo "WeaveScope not configured"
fi



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Liberty Demo? [y,N]" DO_LIB
if [[ $DO_LIB == "y" ||  $DO_LIB == "Y" ]]; then
  ~/INSTALL/APPS/libertydemo/install_libertydemo.sh
else
  echo "Liberty Demo not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure ISTIO? [y,N]" DO_ISTIO
if [[ $DO_ISTIO == "y" ||  $DO_ISTIO == "Y" ]]; then
  ~/INSTALL/APPS/istio/install_istio.sh
else
  echo "ISTIO not configured"
fi


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure TA? [y,N]" DO_TA
if [[ $DO_TA == "y" ||  $DO_TA == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
kubectl create secret docker-registry tasecret --db_username=4oCcYWRtaW7igJ0= --secret=4oCcYWRtaW7igJ0= -n default

else
  echo "TA not configured"
fi


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure BLOCKCHAIN? [y,N]" DO_BLK
if [[ $DO_BLK == "y" ||  $DO_BLK == "Y" ]]; then
  ~/INSTALL/APPS/blockchain/install_blockchain.sh
else
  echo "BLOCKCHAIN not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure VOICEGATEWAY? [y,N]" DO_VGW
if [[ $DO_VGW == "y" ||  $DO_VGW == "Y" ]]; then
  ~/INSTALL/APPS/voicegateway/install_voicegateway.sh
else
  echo "VOICEGATEWAY not configured"
fi






echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure CAM? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  read -p "Keep PV? [Y,n]" DO_STF
  if [[ $DO_STF == "n" ||  $DO_STF == "N" ]]; then
    ~/INSTALL/APPS/cam/install_cam.sh
  else
    ~/INSTALL/APPS/cam/reinstall_cam.sh
  fi
else
  echo "CAM not configured"
fi






echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure OpenFaaS? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  ~/INSTALL/APPS/openfaas/install_openfaas.sh
else
  echo "OpenFaaS not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure OpenWhisk? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  ~/INSTALL/APPS/openwhisk/install_openwhisk.sh
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
