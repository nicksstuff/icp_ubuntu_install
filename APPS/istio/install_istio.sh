#!/bin/bash


# Install ISTIO
echo "Install ISTIO"


ISTIO_VERSION=1.0.2
OSEXT="linux"

#------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------

cd ~/INSTALL/APPS/istio

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

#helm template ~/INSTALL/APPS/istio/"$NAME"/install/kubernetes/helm/istio --name istio --namespace istio-system --set grafana.enabled=true --set grafana.service.type=NodePort --set servicegraph.enabled=true --set servicegraph.service.type=NodePort --set kiali.enabled=true --set tracing.enabled=true > ~/INSTALL/APPS/istio/istio.yaml
kubectl create namespace istio-system
kubectl apply -f ~/INSTALL/APPS/istio/config/istio.yaml

~/INSTALL/APPS/istio/bookinfo/install_istio_bookinfo.sh

sudo cp ~/INSTALL/APPS/istio/"$NAME"/bin/istioctl /usr/local/bin/


cp ~/.bashrc_icp_save ~/.bashrc
cp ~/.bashrc ~/.bashrc_icp_save
cat ~/INSTALL/APPS/istio/conf/bashrc_add_istio.sh >> ~/.bashrc
