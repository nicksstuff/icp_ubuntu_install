#!/bin/bash

source ~/INSTALL/0_variables.sh


# Install OpenLDAP
echo "Install OpenLDAP "
echo "Use mycluster.icp as DNS Domain Name"
echo "and icp as Organization Name"
sudo apt-get update
sudo apt-get --yes --force-yes install slapd ldap-utils
sudo dpkg-reconfigure slapd

# Create LDAP Users
echo "Create LDAP Users"
ldapadd -x -D cn=admin,dc=mycluster,dc=icp -W -f  ~/INSTALL/KUBE/LDAP/addldapcontent.ldif

echo "Import LDAP Users "
export ACCESS_TOKEN=$(curl -k -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d "grant_type=password&username=admin&password=admin&scope=openid" https://${MASTER_IP}:8443/idprovider/v1/auth/identitytoken --insecure |       python3 -c "import sys, json; print(json.load(sys.stdin)['access_token'])")
echo "$ACCESS_TOKEN"
curl -k -X POST --header "Authorization: bearer $ACCESS_TOKEN" --header 'Content-Type: application/json' -d '{"LDAP_BINDPASSWORD": "admin", "LDAP_ID":"LDAP","LDAP_REALM":"REALM","LDAP_HOST":"'${MASTER_IP}'","LDAP_PORT":"389","LDAP_IGNORECASE":"false","LDAP_BASEDN":"dc=mycluster,dc=icp","LDAP_BINDDN":"cn=admin,dc=mycluster,dc=icp","LDAP_TYPE":"Custom","LDAP_USERFILTER":"(&(uid=%v)(objectclass=person))","LDAP_GROUPFILTER":"(&(cn=%v)(objectclass=groupOfUniqueNames))","LDAP_USERIDMAP":"*:uid","LDAP_GROUPIDMAP":"*:cn","LDAP_GROUPMEMBERIDMAP":"groupOfUniqueNames:uniqueMember","LDAP_URL":"ldap://'${MASTER_IP}':389","LDAP_PROTOCOL":"ldap"}' 'https://'${MASTER_IP}':8443/idmgmt/identity/api/v1/directory/ldap/onboardDirectory'


echo "Configure LDAP"
echo "-----------------------------------------------------------------------------------------------------------"
echo "LDAP_ID               : OPENLDAP"
echo "LDAP_URL              : ldap://${PUBLIC_IP}:389"
echo "LDAP_BASEDN           : dc=mycluster,dc=icp"
echo "LDAP_BINDDN           : cn=admin,dc=mycluster,dc=icp"
echo "LDAP_BINDPASSWORD     : admin"
echo "LDAP_TYPE             : Custom"
echo "LDAP_USERFILTER       : (&(uid=%v)(objectclass=person))"
echo "LDAP_GROUPFILTER      : (&(cn=%v)(objectclass=groupOfUniqueNames))"
echo "LDAP_USERIDMAP        :  *:uid"
echo "LDAP_GROUPIDMAP       : *:cn"
echo "LDAP_GROUPMEMBERIDMAP : groupOfUniqueNames:uniquemember"
echo "-----------------------------------------------------------------------------------------------------------"
