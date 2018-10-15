#!/bin/bash

source ~/INSTALL/0_variables.sh

# Create ALERTS
echo "Create ALERTS"

kubectl -n kube-system delete -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertrules_config.yaml
kubectl -n kube-system delete -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertmanager_config.yaml

kubectl -n kube-system apply -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertrules_config.yaml
kubectl -n kube-system apply -f ~/INSTALL/KUBE/CONFIG/monitoring-prometheus-alertmanager_config.yaml
