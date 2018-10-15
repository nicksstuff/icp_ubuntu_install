#!/bin/bash

sudo helm delete --purge --tls owncloud-mariadb
sudo helm delete --purge --tls owncloud
