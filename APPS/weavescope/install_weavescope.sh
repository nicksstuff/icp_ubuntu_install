#!/bin/bash

source ~/INSTALL/0_variables.sh

helm install --name weavescope --set global.service.type=NodePort --set global.image.tag="1.9.1" stable/weave-scope --tls

kubectl patch service weavescope-weave-scope --patch "$(cat ~/INSTALL/APPS/weavescope/nodeport_patch.yaml)" -n services
