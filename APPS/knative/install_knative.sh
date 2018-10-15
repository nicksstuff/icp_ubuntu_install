#!/bin/bash

kubectl apply --filename ~/INSTALL/APPS/knative/knative_istio_0.1.1.yaml

kubectl label namespace default istio-injection=enabled

kubectl apply --filename ~/INSTALL/APPS/knative/knative_release_0.1.1.yaml

kubectl apply --filename ~/INSTALL/APPS/knative/knative_service_demo.yaml
