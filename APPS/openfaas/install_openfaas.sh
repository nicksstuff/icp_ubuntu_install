#!/bin/bash

# Create some Stuff
echo "Prepare some Stuff"

cd ~/INSTALL/
#kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml

kubectl create namespace openfaas
kubectl create namespace openfaas-fn
sudo helm repo add openfaas https://openfaas.github.io/faas-netes/

echo "Install Chart"
sudo helm upgrade openfaas --install openfaas/openfaas --namespace openfaas --set functionNamespace=openfaas-fn --tls
