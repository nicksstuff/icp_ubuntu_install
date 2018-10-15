#!/bin/bash

source ~/INSTALL/0_variables.sh

# Create some Stuff
echo "Prepare some Stuff"
kubectl create -f ~/INSTALL/APPS/ta/secret.yaml

helm repo add ibm-stable https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
helm repo update
helm fetch ibm-stable/ibm-transadv-dev

helm install --name ta --namespace default --set authentication.icp.edgeIp=$MASTER_IP --set authentication.icp.secretName=tasecret --set couchdb.resources.requests.cpu=500m --set couchdb.resources.limits.memory=2Gi --set couchdb.resources.limits.cpu=500m --set transadv.resources.requests.cpu=500m --set transadv.resources.limits.memory=2Gi --set transadv.resources.limits.cpu=500m --set transadvui.resources.requests.cpu=500m --set transadvui.resources.limits.memory=2Gi --set transadvui.resources.limits.cpu=500m ibm-stable/ibm-transadv-dev --tls
#helm install --name ta --namespace default --set authentication.icp.edgeIp=192.168.27.199 --set authentication.icp.secretName=tasecret --set couchdb.resources.requests.cpu=500m --set couchdb.resources.limits.memory=2Gi --set couchdb.resources.limits.cpu=500m --set transadv.resources.requests.cpu=500m --set transadv.resources.limits.memory=2Gi --set transadv.resources.limits.cpu=500m --set transadvui.resources.requests.cpu=500m --set transadvui.resources.limits.memory=2Gi --set transadvui.resources.limits.cpu=500m ibm-stable/ibm-transadv-dev --tls

#CWOAU0061E: The OAuth service provider could not find the client because the client name is not valid. Contact your system administrator to resolve the problem.
