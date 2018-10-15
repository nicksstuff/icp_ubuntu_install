#!/bin/bash

helm delete --purge openwhisk --tls

kubectl delete namespace openwhisk
