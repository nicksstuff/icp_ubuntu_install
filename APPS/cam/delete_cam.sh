#!/bin/bash

helm delete --tls --purge cam

kubectl delete pvc cam-bpd-appdata-pv --namespace services
kubectl delete pvc cam-logs-pv --namespace services
kubectl delete pvc cam-mongo-pv --namespace services
kubectl delete pvc cam-terraform-pv --namespace services

cloudctl iam service-id-delete service-deploy
cloudctl iam service-id-delete service-cloud-automation-manager

kubectl delete secret camsecret -n services
