#!/bin/bash

source ~/INSTALL/0_variables.sh


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Liberty Demo? [y,N]" DO_LIB
if [[ $DO_LIB == "y" ||  $DO_LIB == "Y" ]]; then
  # Create Liberty Demo
  echo "Download Liberty Demo"
  cd ~/INSTALL/APPS
  git clone https://github.com/niklaushirt/demoliberty.git
  cd ~/INSTALL/APPS/demoliberty
  docker build -t demoliberty:1.0.0 docker_100
  docker build -t demoliberty:1.1.0 docker_110
  docker build -t demoliberty:1.2.0 docker_120
  docker build -t demoliberty:1.3.0 docker_130

  docker login mycluster.icp:8500 -u admin -p admin
  docker tag demoliberty:1.3.0 mycluster.icp:8500/default/demoliberty:1.3.0
  docker tag demoliberty:1.2.0 mycluster.icp:8500/default/demoliberty:1.2.0
  docker tag demoliberty:1.1.0 mycluster.icp:8500/default/demoliberty:1.1.0
  docker tag demoliberty:1.0.0 mycluster.icp:8500/default/demoliberty:1.0.0
  docker push mycluster.icp:8500/default/demoliberty:1.3.0
  docker push mycluster.icp:8500/default/demoliberty:1.2.0
  docker push mycluster.icp:8500/default/demoliberty:1.1.0
  docker push mycluster.icp:8500/default/demoliberty:1.0.0

  echo "SET WORKER PLACEMENT labels"
  for ((i=0; i < $NUM_WORKERS; i++)); do
    kubectl label nodes ${WORKER_IPS[i]} placement=local
  done

else
  echo "Liberty Demo not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure ISTIO? [y,N]" DO_ISTIO
if [[ $DO_ISTIO == "y" ||  $DO_ISTIO == "Y" ]]; then
  # Install ISTIO
  echo "Install ISTIO"

  cd ~/INSTALL/APPS/istio
  ISTIO_VERSION=1.0.1
  OSEXT="linux"
  NAME="istio-$ISTIO_VERSION"
  URL="https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-${OSEXT}.tar.gz"
  echo "Downloading $NAME from $URL ..."
  curl -L "$URL" | tar xz
  echo "Downloaded into $NAME:"
  ls "$NAME"

  BINDIR="$(cd "$NAME/bin" && pwd)"
  echo "Add $BINDIR to your path; e.g copy paste in your shell and/or ~/.profile:"
  echo "export PATH=\"\$PATH:$BINDIR\""

  cd "$NAME"
  export PATH=$PWD/bin:$PATH
  kubectl apply -f ~/INSTALL/APPS/istio/"$NAME"/install/kubernetes/helm/istio/templates/crds.yaml

  helm template ~/INSTALL/APPS/istio/"$NAME"/install/kubernetes/helm/istio --name istio --namespace istio-system > ~/INSTALL/APPS/istio/istio.yaml
  kubectl create namespace istio-system
  kubectl apply -f ~/INSTALL/APPS/istio/istio.yaml

  kubectl apply -f <(istioctl kube-inject -f ~/INSTALL/APPS/istio/"$NAME"/samples/bookinfo/platform/kube/bookinfo.yaml)
  kubectl apply -f ~/INSTALL/APPS/istio/"$NAME"/samples/bookinfo/networking/bookinfo-gateway.yaml

  sudo cp ~/INSTALL/APPS/istio/"$NAME"/bin/istioctl /usr/local/bin/


  export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o 'jsonpath={.items[0].status.hostIP}')
  export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')

  export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

  curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage

  kubectl get virtualservice
  #kubectl delete -f ~/INSTALL/"$NAME"/samples/bookinfo/platform/kube/bookinfo.yaml
  #kubectl delete -f ~/INSTALL/"$NAME"/samples/bookinfo/networking/bookinfo-gateway.yaml

  cp ~/.bashrc_icp_save ~/.bashrc
  cp ~/.bashrc ~/.bashrc_icp_save
  cat ~/INSTALL/APPS/istio/conf/bashrc_add_istio.sh >> ~/.bashrc
else
  echo "ISTIO not configured"
fi







echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure BLOCKCHAIN? [y,N]" DO_BLK
if [[ $DO_BLK == "y" ||  $DO_BLK == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"

  mkdir -p ~/INSTALL/APPS/blockchain
  cd ~/INSTALL/APPS/blockchain

  git clone https://github.com/IBM-Blockchain/ibm-container-service

  cd ~/INSTALL/APPS/blockchain/ibm-container-service/cs-offerings/scripts

  echo "Install BLOCKCHAIN"
  ./create_all.sh

else
  echo "BLOCKCHAIN not configured"
fi





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure VOICEGATEWAY? [y,N]" DO_VGW
if [[ $DO_VGW == "y" ||  $DO_VGW == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  sudo helm repo add ibm-charts https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
  sudo helm repo update

  echo "Install VOICEGATEWAY"
  sudo helm install ibm-charts/ibm-voice-gateway-dev --name my-voicegateway \
  --set mediaRelayEnvVariables.mediaRelayWsPort=8889 \
  --set sipOrchestratorEnvVariables.mediaRelayHost=localhost:8889 \
  --set sipOrchestratorEnvVariables.sipPort=5560 \
  --set sipOrchestratorEnvVariables.sipPortTcp=5560 \
  --set sipOrchestratorEnvVariables.sipPortTls=5561 \
  --set serviceCredentials.watsonSttUsername="xxxxx-e17c-4a5d-8a8c-68a4af972dfe" \
  --set serviceCredentials.watsonSttPassword="xxxxx" \
  --set serviceCredentials.watsonTtsUsername="xxxxx-b549-46d8-96ac-2b60d4e96006" \
  --set serviceCredentials.watsonTtsPassword="xxxxx" \
  --set serviceCredentials.watsonConversationWorkspaceId="xxxx-0f43-4262-9503-680613f41337" \
  --set serviceCredentials.watsonConversationUsername="xxxx-ad73-41db-8f87-03048f0ab6c0" \
  --set serviceCredentials.watsonConversationPassword="xxxxx" --tls

  echo "SIP Address will be something like this sip:watson@192.168.27.199:30729 "

else
  echo "VOICEGATEWAY not configured"
fi






echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure CAM? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  helm delete --purge cam --tls

  kubectl delete pvc cam-bpd-appdata-pv --namespace services
  kubectl delete pvc cam-logs-pv --namespace services
  kubectl delete pvc cam-mongo-pv --namespace services
  kubectl delete pvc cam-terraform-pv --namespace services

  cd ~/INSTALL/

  helm repo add ibm-stable https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
  helm repo update
  helm fetch ibm-stable/ibm-cam --version 1.3.1

  kubectl delete secret camsecret -n services
  kubectl create secret docker-registry camsecret --docker-username=${DOCKER_HUB_LOGIN} --docker-password=${DOCKER_HUB_PWD} --docker-email=${DOCKER_HUB_MAIL} -n services

  #export serviceIDName='service-deploy'
  #export serviceApiKeyName='service-deploy-api-key'
  #ibmcloud pr login -a https://localhost:8443 --skip-ssl-validation -u admin  -p admin -c id-mycluster-account
  #ibmcloud pr target -n services
  #ibmcloud pr iam service-id-create ${serviceIDName} -d 'Service ID for service-deploy'
  #ibmcloud pr iam service-policy-create ${serviceIDName} -r Administrator,ClusterAdministrator --service-name ''
  #ibmcloud pr iam service-api-key-create ${serviceApiKeyName} ${serviceIDName} -d 'Api key for service-deploy'


  echo "Install Chart"
  helm install --name cam ibm-cam-1.3.1.tgz --namespace services --set arch=amd64 --set global.image.secretName=camsecret --set global.iam.deployApiKey=ye1_J8rgpK7o5zZK0kb0VVEjA-4Qcsv1Q3YtjFETZlF3 --tls
else
  echo "CAM not configured"
fi






echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure OpenFaaS? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  helm delete --purge openfaas --tls

  cd ~/INSTALL/
  #kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml

  kubectl create namespace openfaas
  kubectl create namespace openfaas-fn
  sudo helm repo add openfaas https://openfaas.github.io/faas-netes/

  echo "Install Chart"
  sudo helm upgrade openfaas --install openfaas/openfaas --namespace openfaas --set functionNamespace=openfaas-fn --tls
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


  cd ~/INSTALL/APPS
  sudo rm -r ~/INSTALL/APPS/OpenWhisk

  kubectl create namespace openwhisk

  kubectl label nodes --all openwhisk-role=invoker
  git clone https://github.com/apache/incubator-openwhisk-deploy-kube.git OpenWhisk

  cd ~/INSTALL/APPS/OpenWhisk/helm/openwhisk

  echo "Install Chart"
  helm install . --namespace=openwhisk --name=openwhisk -f ~/INSTALL/KUBE/OPENWHISK/openwhisk.yaml --tls

  echo "Install Command Line"
  mkdir -p ~/INSTALL/APPS/OpenWhisk/tmp
  cd ~/INSTALL/APPS/OpenWhisk/tmp
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
read -p "Install and configure Spinnaker? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  # Create some Stuff
  echo "Prepare some Stuff"
  helm delete --purge spinnaker --tls

  kubectl create namespace spinnaker

  cd ~/INSTALL/

  echo "Install Chart"
  helm install --namespace=spinnaker --name spinnaker --set kubeConfig.contexts=[mycluster] --set deck.ingress.enabled=true --set deck.host=spinnaker.icp.cloud.com stable/spinnaker --tls
  helm install --namespace=spinnaker --name spinnaker --set deck.ingress.enabled=true --set deck.host=spinnaker.icp.cloud.com stable/spinnaker --tls

else
  echo "Spinnaker not configured"
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
