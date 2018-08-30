#!/bin/bash
ISTIO_VERSION=1.0.1
OSEXT="linux"
NAME="istio-$ISTIO_VERSION"

kubectl delete -f $HOME/istio.yaml
kubectl delete -f ~/INSTALL/"$NAME"/install/kubernetes/helm/istio/templates/crds.yaml
kubectl delete namespace istio-system
