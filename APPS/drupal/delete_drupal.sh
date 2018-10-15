#!/bin/bash

sudo helm delete --purge --tls drupal

sudo helm delete --purge --tls drupal-app1
sudo helm delete --purge --tls drupal-mariadb-app1
sudo helm delete --purge --tls drupal-app2
sudo helm delete --purge --tls drupal-mariadb-app2
