#!/bin/bash
#-----------------------------------------------------------------------------------
# DEFAULTS
#-----------------------------------------------------------------------------------

export APP_NAME="app1"
export NAMESPACE="default"


#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
# DO NOT CHANGE BELOW
#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------

if [ "$1" != "" ]; then
    export APP_NAME=$1
    if [ "$2" != "" ]; then
        export NAMESPACE=$2
    fi
fi

echo "Installing into namespace $NAMESPACE as application $APP_NAME"


export DB_HOST="owncloud-mariadb-$APP_NAME-mariadb.$NAMESPACE.svc.cluster.local"

docker login mycluster.icp:8500 -u admin -p admin

docker pull bitnami/mariadb:10.1.36-debian-9
docker tag bitnami/mariadb:10.1.36-debian-9 mycluster.icp:8500/dev-namespace/mariadb:10.1.36-debian-9
docker push mycluster.icp:8500/dev-namespace/mariadb:10.1.36-debian-9

docker pull bitnami/owncloud:10.0.10-debian-9
docker tag bitnami/owncloud:10.0.10-debian-9 mycluster.icp:8500/dev-namespace/owncloud:10.0.10-debian-9
docker push mycluster.icp:8500/dev-namespace/owncloud:10.0.10-¨debian-9


helm install --name owncloud-mariadb-$APP_NAME stable/mariadb --namespace $NAMESPACE -f mariadb_values.yaml --tls

helm install --name owncloud-$APP_NAME stable/owncloud --namespace $NAMESPACE -f owncloud_values.yaml --set owncloudHost=$DB_HOST --tls
