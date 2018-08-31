


bx pr login -a https://<YOUR_CLUSTER_MASTER_NODE_IP>:8443 --skip-ssl-validation


kubectl patch service -n kube-system monitoring-grafana -p '{"spec":{"type": "NodePort"}}' || true

grafanaPort=`kubectl get service -n kube-system monitoring-grafana -o jsonpath='{.spec.ports[?(@.name == "web")].nodePort}'`

token=`kubectl get secret -n kube-system $(kubectl get sa default -n kube-system -o jsonpath="{.secrets[*].name}") -o jsonpath="{.data.token}" | base64 -d`

helm install --namespace kube-system --name hcm http://9.42.80.212:8878/hcm-allinone-0.4.0.tgz --tls \
    -f ./hcmmm.yaml --set hcmm.serviceAccount=kube-system/default,hcmm.grafana.endpoint=https://${MASTER_IP}:${grafanaPort},hcmk.token=${token},hcmk.managerserver=https://${MASTER_IP}:8443/hcm,hcmk.clusterip=${MASTER_IP}

kubectl patch deployment -n kube-system hcm-hcm-allinone-hcmm -p '{"spec": {"template": {"spec": {"containers": [{"name": "hcmm", "env": [{"name": "HCM_MANAGER_ENDPOINT","value": "https://127.0.0.1:8080"}]}]}}}}'


**Install HCM Klusterlet (HCMK) for Each Managed Cluster**

kubectl get secret $(kubectl get sa -l release=hcm -n kube-system -o jsonpath="{.items[0].secrets[0].name}") -n kube-system -o jsonpath="{.data.token}" | base64 -d

kubectl create secret tls helm-secret --cert=~/INSTALL/cluster/cfc-certs/helm/admin.crt --key=~/INSTALL/cluster/cfc-certs/helm/admin.key -n kube-system

helm install hcm-allinone -tls -n hcmk --namespace kube-system -f hcmk.yaml


**Setup HCMCTL CLI**
cp ~/INSTALL/APPS/hcm/hcm.config ~/.hcm/config

export HCM_ENDPOINT_CONFIG=~/.hcm/config


**Setup HCM Menu Extensions to ICP Console**
kubectl patch daemonset -n kube-system platform-ui -p '{"spec": {"template": {"spec": {"containers": [{"name": "platform-ui", "image": "registry.ng.bluemix.net/mdelder/icp-platform-ui-amd64:2.1.0.3-hcm"}]}}}}'
