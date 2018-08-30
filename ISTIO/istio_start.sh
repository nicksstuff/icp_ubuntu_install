#!/bin/bash
ISTIO_VERSION=1.0.1
OSEXT="linux"
NAME="istio-$ISTIO_VERSION"


kubectl apply -f ~/INSTALL/"$NAME"/install/kubernetes/helm/istio/templates/crds.yaml

helm template ~/INSTALL/"$NAME"/install/kubernetes/helm/istio --name istio --namespace istio-system > $HOME/istio.yaml
kubectl create namespace istio-system
kubectl apply -f $HOME/istio.yaml
