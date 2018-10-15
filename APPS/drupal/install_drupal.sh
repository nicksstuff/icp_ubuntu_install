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

export DB_HOST="drupal-mariadb-$APP_NAME-mariadb.$NAMESPACE.svc.cluster.local"

helm install --name drupal-mariadb-$APP_NAME stable/mariadb --namespace $NAMESPACE -f mariadb_values.yaml --tls
helm install --name drupal-$APP_NAME --namespace $NAMESPACE --version 2.1.0 -f drupal_values.yaml --set externalDatabase.host=$DB_HOST stable/drupal --tls
