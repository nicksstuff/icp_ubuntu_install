#!/bin/bash

source ~/INSTALL/0_variables.sh

helm install --name spinnaker stable/spinnaker --version 1.1.4 --namespace default --set ingress.enabled=true --tls
