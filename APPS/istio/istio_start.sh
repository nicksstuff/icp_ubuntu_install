#!/bin/bash
ISTIO_VERSION=1.0.1
OSEXT="linux"
NAME="istio-$ISTIO_VERSION"


kubectl apply -f ~/INSTALL/APPS/istio/"$NAME"/install/kubernetes/helm/istio/templates/crds.yaml

helm template ~/INSTALL/APPS/istio/"$NAME"/install/kubernetes/helm/istio --name istio --namespace istio-system > ~/INSTALL/APPS/istio/istio.yaml
kubectl create namespace istio-system
kubectl apply -f ~/INSTALL/APPS/istio/istio.yaml
