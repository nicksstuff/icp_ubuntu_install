docker login -u niklaushirt
#-------------------------------------------------------
# VOICEGATEWAY
#-------------------------------------------------------
sudo docker pull ibmcom/voice-gateway-mr:1.0.0.6b
sudo docker pull ibmcom/voice-gateway-so:1.0.0.6b
#-------------------------------------------------------
# BLOCKCHAIN
#-------------------------------------------------------
sudo docker pull ibmblockchain/composer-cli:0.19.5
sudo docker pull ibmblockchain/composer-playground:0.19.5
sudo docker pull ibmblockchain/fabric-baseos:0.4.6
sudo docker pull ibmblockchain/fabric-ca:1.1.0
sudo docker pull ibmblockchain/fabric-ccenv:1.1.0
sudo docker pull ibmblockchain/fabric-orderer:1.1.0
sudo docker pull ibmblockchain/fabric-peer:1.1.0
sudo docker pull ibmblockchain/fabric-tools:1.1.0

#-------------------------------------------------------
#  OpenWhisk
#-------------------------------------------------------
sudo docker pull redis:3.2
sudo docker pull nginx:1.11
sudo docker pull apache/couchdb:2.1
sudo docker pull openwhisk/apigateway:latest


#-------------------------------------------------------
# TA
#-------------------------------------------------------
sudo docker pull ibmcom/transformation-advisor-db:1.6.0
sudo docker pull ibmcom/transformation-advisor-server:1.6.0
sudo docker pull ibmcom/transformation-advisor-ui:1.6.0

#-------------------------------------------------------
# ISITO
#-------------------------------------------------------
sudo docker pull istio/citadel:1.0.0
sudo docker pull istio/examples-helloworld-v1:latest
sudo docker pull istio/examples-helloworld-v2:latest
sudo docker pull istio/grafana:1.0.0
sudo docker pull istio/mixer:1.0.0
sudo docker pull istio/pilot:1.0.0
sudo docker pull istio/proxy_debug:1.0.0
sudo docker pull istio/proxy_init:1.0.0
sudo docker pull istio/proxyv2:1.0.0
sudo docker pull istio/servicegraph:1.0.0
sudo docker pull istio/sidecar_injector:1.0.0


sudo docker pull istio/examples-bookinfo-details-v1:1.8.0
sudo docker pull istio/examples-bookinfo-ratings-v1:1.8.0
sudo docker pull istio/examples-bookinfo-productpage-v1:1.8.0
sudo docker pull istio/examples-bookinfo-reviews-v1:1.8.0
sudo docker pull istio/examples-bookinfo-reviews-v2:1.8.0
sudo docker pull istio/examples-bookinfo-reviews-v3:1.8.0

#-------------------------------------------------------
# DevOps
#-------------------------------------------------------
sudo docker pull jenkins/jenkins:2.132
sudo docker pull jenkins/jnlp-slave:3.10-1
sudo docker pull gitlab/gitlab-ce:9.3.8-ce.0
sudo docker pull sonarqube:6.7.3


#-------------------------------------------------------
# OpenFaaS
#-------------------------------------------------------
sudo docker pull prom/alertmanager:v0.15.0
sudo docker pull openfaas/gateway:0.9.0
sudo docker pull nats-streaming:0.6.0
sudo docker pull prom/prometheus:v2.3.1



#-------------------------------------------------------
#  DSX
#-------------------------------------------------------
sudo docker pull hybridcloudibm/dsx-dev-icp-jupyter:v1.015
sudo docker pull hybridcloudibm/dsx-dev-icp-dsx-core:v1.015
sudo docker pull hybridcloudibm/dsx-dev-icp-rstudio:v1.015
sudo docker pull hybridcloudibm/dsx-dev-icp-zeppelin:v1.01


#-------------------------------------------------------
# CAM
#-------------------------------------------------------
sudo docker pull store/ibmcorp/icam-bpd-cds:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-bpd-mariadb:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-bpd-mds:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-bpd-ui:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-broker:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-iaas:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-mongo:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-orchestration:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-portal-ui:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-provider-helm:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-provider-terraform:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-proxy:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-redis:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-service-composer-api:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-service-composer-ui:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-tenant-api:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-ui-basic:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-ui-connections:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-ui-instances:2.1.0.3_fp1-x86_64
sudo docker pull store/ibmcorp/icam-ui-templates:2.1.0.3_fp1-x86_64

#-------------------------------------------------------
# MISC IBM
#-------------------------------------------------------
sudo docker pull ibmcom/mq:9.1.0.0
sudo docker pull ibmcom/odm:8.9.2.1_1.1.0-x86_64
sudo docker pull ibmcom/skydive:0.18
sudo docker pull websphere-liberty:8.5.5.9
sudo docker pull websphere-liberty:webProfile7


#-------------------------------------------------------
# MISC
#-------------------------------------------------------
sudo docker pull tomcat:9.0
sudo docker pull tomcat:latest
sudo docker pull weaveworks/scope:1.6.5
sudo docker pull apache/zeppelin:0.7.3
sudo docker pull bitnami/mariadb:10.1.34-debian-9
sudo docker pull bitnami/mediawiki:1.31.0-debian-9
sudo docker pull bitnami/mongodb:3.4.10-r0
sudo docker pull bitnami/redis:4.0.10-debian-9
sudo docker pull bpineau/katafygio:v0.7.1
sudo docker pull busybox:latest
sudo docker pull gcr.io/google_containers/kubernetes-dashboard-amd64:v1.8.3
sudo docker pull gcr.io/spinnaker-marketplace/halyard:stable
sudo docker pull gocd/gocd-agent-docker-dind:v18.7.0
sudo docker pull gocd/gocd-server:v18.7.0
sudo docker pull k8s.gcr.io/spark:1.5.1_v3
sudo docker pull nginx:latest
sudo docker pull nodered/node-red-docker:0.18.5
sudo docker pull postgres:9.6.2
sudo docker pull quay.io/kubernetes-service-catalog/user-broker:v0.1.9
