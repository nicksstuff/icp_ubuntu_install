#!/bin/bash
ISTIO_VERSION=1.0.1
OSEXT="linux"
NAME="istio-$ISTIO_VERSION"

kubectl delete -f ~/INSTALL/APPS/istio/istio.yaml
kubectl delete -f ~/INSTALL/APPS/istio/"$NAME"/install/kubernetes/helm/istio/templates/crds.yaml
kubectl delete namespace istio-system
