#!/bin/bash
ISTIO_VERSION=1.0.2
OSEXT="linux"
NAME="istio-$ISTIO_VERSION"

kubectl delete -f ~/INSTALL/APPS/istio/conf/istio.yaml
kubectl delete -f ~/INSTALL/APPS/istio/"$NAME"/install/kubernetes/helm/istio/templates/crds.yaml

~/INSTALL/APPS/istio/bookinfo/delete_istio_bookinfo.sh

kubectl delete namespace istio-system
