#!/bin/bash
ISTIO_VERSION=1.0.2
OSEXT="linux"
NAME="istio-$ISTIO_VERSION"

kubectl delete -f ~/INSTALL/APPS/istio/conf/bookinfo-gateway.yaml
kubectl delete -f ~/INSTALL/APPS/istio/conf/destination-rule-all.yaml
kubectl delete -f ~/INSTALL/APPS/istio/conf/bookinfo.yaml
