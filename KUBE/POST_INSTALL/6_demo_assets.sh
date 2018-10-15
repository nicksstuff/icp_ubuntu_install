#!/bin/bash

source ~/INSTALL/0_variables.sh


# Create some Stuff
echo "Create some Stuff"
cd ~/INSTALL/
kubectl create namespace dev-namespace
kubectl create namespace test-namespace
kubectl create namespace prod-namespace

kubectl create rolebinding -n dev-namespace rolebindingname --clusterrole=privileged --serviceaccount=dev-namespace:default
kubectl create rolebinding -n test-namespace rolebindingname --clusterrole=privileged --serviceaccount=test-namespace:default
kubectl create rolebinding -n prod-namespace rolebindingname --clusterrole=privileged --serviceaccount=prod-namespace:default

kubectl create -f ~/INSTALL/KUBE/CONFIG/devlimits_quota.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/restricted_policy.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/privileged_policy.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/calico_demo.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/clusterimagepolicy_all.yaml

cat ~/INSTALL/KUBE/CONFIG/bashrc_add_stress.sh >> ~/.bashrc
