docker login -u niklaushirt

#-------------------------------------------------------
# KNATIVE
#-------------------------------------------------------
sudo docker pull istio/citadel:0.8.0
sudo docker pull istio/examples-helloworld-v1:latest
sudo docker pull istio/examples-helloworld-v2:latest
sudo docker pull istio/grafana:0.8.0
sudo docker pull istio/mixer:0.8.0
sudo docker pull istio/pilot:0.8.0
sudo docker pull istio/proxy_debug:0.8.0
sudo docker pull istio/proxy_init:0.8.0
sudo docker pull istio/proxyv2:0.8.0
sudo docker pull istio/servicegraph:0.8.0
sudo docker pull istio/sidecar_injector:0.8.0

sudo docker pull docker.io/istio/proxyv2:0.8.0
sudo docker pull gcr.io/knative-releases/github.com/knative/build/cmd/controller@sha256:6c88fa5ae54a41182d9a7e9795c3a56f7ef716701137095a08f24ff6a3cca37d
sudo docker pull gcr.io/knative-releases/github.com/knative/build/cmd/webhook@sha256:8c894b1f4ad5d89e31d1e4fba0db2bc5930931a48f3d5ac988b66c2c3f82e849
sudo docker pull gcr.io/knative-releases/github.com/knative/serving/cmd/activator@sha256:486d806e33f487d2475d1ff70eb5dcff51cf62a16f4b9af06788674b60b1f2ef
sudo docker pull gcr.io/knative-releases/github.com/knative/serving/cmd/autoscaler@sha256:2a9931ab1cbe6efeec43a47517163622002e0dc2ea5d6ffa0d0e546c2c94b841
sudo docker pull gcr.io/knative-releases/github.com/knative/serving/cmd/queue@sha256:65b4824c5f21134a1b8373cbc2be8d431744f06caf118a309f94b6514cd6f40c
sudo docker pull k8s.gcr.io/fluentd-elasticsearch:v2.0.4
sudo docker pull k8s.gcr.io/fluentd-elasticsearch:v2.0.4
sudo docker pull gcr.io/knative-releases/github.com/knative/serving/cmd/controller@sha256:59abc8765d4396a3fc7cac27a932a9cc151ee66343fa5338fb7146b607c6e306
sudo docker pull gcr.io/knative-releases/github.com/knative/serving/cmd/webhook@sha256:7196a38aaf11ed6426db7c40a771e4f2a27d987606b5773b2d05bb9676908e7d
sudo docker pull quay.io/coreos/kube-rbac-proxy:v0.3.0
sudo docker pull quay.io/coreos/kube-state-metrics:v1.3.0
sudo docker pull k8s.gcr.io/addon-resizer:1.7
sudo docker pull quay.io/prometheus/node-exporter:v0.15.2
sudo docker pull quay.io/coreos/kube-rbac-proxy:v0.3.0
sudo docker pull k8s.gcr.io/elasticsearch:v5.6.4
sudo docker pull alpine:3.6
sudo docker pull docker.elastic.co/kibana/kibana:5.6.4
sudo docker pull quay.io/coreos/monitoring-grafana:5.0.3
sudo docker pull docker.io/openzipkin/zipkin:latest
sudo docker pull prom/prometheus:v2.2.1

#-------------------------------------------------------
# SPINNAKER
#-------------------------------------------------------
sudo docker pull gcr.io/spinnaker-marketplace/halyard:1.9.1
sudo docker pull gcr.io/spinnaker-marketplace/clouddriver:3.4.1-20180827143405
sudo docker pull gcr.io/spinnaker-marketplace/deck:2.4.1-20180824212434
sudo docker pull gcr.io/spinnaker-marketplace/rosco:0.7.3-20180818041609
sudo docker pull gcr.io/spinnaker-marketplace/echo:2.0.1-20180817041609
sudo docker pull gcr.io/spinnaker-marketplace/orca:1.0.0-20180814155153
sudo docker pull gcr.io/spinnaker-marketplace/gate:1.1.0-20180803022808
sudo docker pull gcr.io/spinnaker-marketplace/front50:0.12.0-20180802022808
sudo docker pull gcr.io/spinnaker-marketplace/igor:0.12.0-20180726022808

#-------------------------------------------------------
# VOICEGATEWAY
#-------------------------------------------------------
sudo docker pull ibmcom/voice-gateway-mr:1.0.2.7
sudo docker pull ibmcom/voice-gateway-so:1.0.2.7
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
sudo docker pull ibmblockchain/composer-rest-server:0.19.5
sudo docker pull ibmblockchain/fabric-couchdb:0.4.6


#-------------------------------------------------------
#  OpenWhisk
#-------------------------------------------------------
sudo docker pull redis:3.2
sudo docker pull nginx:1.11
sudo docker pull apache/couchdb:2.1
sudo docker pull openwhisk/apigateway:latest

#-------------------------------------------------------
#  WeaveScope
#-------------------------------------------------------
sudo docker weaveworks/scope:1.9.1

#-------------------------------------------------------
# TA
#-------------------------------------------------------
sudo docker pull ibmcom/transformation-advisor-db:1.8.0
sudo docker pull ibmcom/transformation-advisor-server:1.8.0
sudo docker pull ibmcom/transformation-advisor-ui:1.8.0

#-------------------------------------------------------
# ISITO
#-------------------------------------------------------
sudo docker pull istio/citadel:1.0.2
sudo docker pull istio/examples-helloworld-v1:latest
sudo docker pull istio/examples-helloworld-v2:latest
sudo docker pull istio/grafana:1.0.2
sudo docker pull istio/mixer:1.0.2
sudo docker pull istio/pilot:1.0.2
sudo docker pull istio/proxy_debug:1.0.2
sudo docker pull istio/proxy_init:1.0.2
sudo docker pull istio/proxyv2:1.0.2
sudo docker pull istio/servicegraph:1.0.2
sudo docker pull istio/sidecar_injector:1.0.2


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
sudo docker pull store/ibmcorp/icam-bpd-cds:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-bpd-mariadb:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-bpd-mds:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-bpd-ui:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-broker:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-iaas:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-mongo:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-orchestration:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-portal-ui:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-provider-helm:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-provider-terraform:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-proxy:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-redis:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-service-composer-api:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-service-composer-ui:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-tenant-api:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-ui-basic:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-ui-connections:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-ui-instances:3.1.0.0-x86_64
sudo docker pull store/ibmcorp/icam-ui-templates:3.1.0.0-x86_64
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
sudo docker pull weaveworks/scope:1.9.1
sudo docker pull datadog/agent:6.2.0
sudo docker pull gcr.io/google_containers/kubernetes-dashboard-amd64:v1.8.3
sudo docker pull gcr.io/spinnaker-marketplace/halyard:stable
sudo docker pull gocd/gocd-agent-docker-dind:v18.7.0
sudo docker pull gocd/gocd-server:v18.7.0
sudo docker pull k8s.gcr.io/spark:1.5.1_v3
sudo docker pull nginx:latest
sudo docker pull nodered/node-red-docker:0.18.5
sudo docker pull postgres:9.6.2
sudo docker pull quay.io/kubernetes-service-catalog/user-broker:v0.1.9
