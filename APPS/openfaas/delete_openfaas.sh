#!/bin/bash

helm delete --purge openfaas --tls

kubectl delete namespace openfaas
kubectl delete namespace openfaas-fn
