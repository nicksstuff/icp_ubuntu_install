#!/bin/bash
# ----------------------------------------------------------------------------------------------------\\
# Description:
#   A basic installer for IBM Cloud Private-CE 2.1.0.3 on UBUNTU 16.04
# ----------------------------------------------------------------------------------------------------\\
# Note:
#   This assumes all VMs were provisioned to be accessable with the same SSH key
#   All scripts should be run from the master node
# ----------------------------------------------------------------------------------------------------\\
# System Requirements:
#   Tested against Ubuntu 1§6.04
#   Master Node - 4 CPUs, 8 GB RAM, 80 GB disk, public IP
#   Worker Node - 2 CPUs, 4 GB RAM, 40 GB disk
#   Requires sudo access
# ----------------------------------------------------------------------------------------------------\\
# Docs:
#   Installation Steps From:
#    - https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/installing/prep_cluster.html
#    - https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/installing/install_containers_CE.html
#
#   Wiki:
#    - https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/W1559b1be149d_43b0_881e_9783f38faaff
#    - https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/W1559b1be149d_43b0_881e_9783f38faaff/page/Connect
# ----------------------------------------------------------------------------------------------------\\


# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\
export DOCKER_HUB_LOGIN=niklaushirt
export DOCKER_HUB_PWD=changeMe
export DOCKER_HUB_MAIL=me@icp.com


# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\
export ICP_VERSION=2.1.0.3

export SSH_KEY=/path/to/key
export SSH_USER=root

export PUBLIC_IP=x.x.x.x
export MASTER_IP=x.x.x.x

# WORKER_IPS[0] should be the same worker at WORKER_HOSTNAMES[0]
export WORKER_IPS=("x.x.x.x" "x.x.x.x" "x.x.x.x")
export WORKER_HOSTNAMES=("name" "name" "name")

# Monitoring IP, only taken into account if filled in
export MONITORING_IP=x.x.x.x



# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\
# DO NOT EDIT BELOW
# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\
# ----------------------------------------------------------------------------------------------------\\



if [[ "${#WORKER_IPS[@]}" != "${#WORKER_HOSTNAMES[@]}" ]]; then
  echo "ERROR: Ensure that the arrays WORKER_IPS and WORKER_HOSTNAMES are of the same length"
  return 1
fi

export NUM_WORKERS=${#WORKER_IPS[@]}

export ARCH="$(uname -m)"
if [ "${ARCH}" != "x86_64" ]; then
  export INCEPTION_TAG="-${ARCH}"
fi

#echo ${WORKER_HOSTNAMES}
#export ARRAY_IDX=${!WORKER_IPS[*]}
#for index in $ARRAY_IDX;
#do
#    echo ${WORKER_IPS[$index]}
#done
