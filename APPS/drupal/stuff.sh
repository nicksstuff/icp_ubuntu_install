hkill drupal-test2
hkill drupal-mariadb-test2
hkill drupal-test1
hkill drupal-mariadb-test1


kubectl delete pvc --namespace dev-namespace data-drupal-mariadb-test1-mariadb-master-0
kubectl delete pvc --namespace dev-namespace data-drupal-mariadb-test1-mariadb-slave-0
kubectl delete pvc --namespace dev-namespace data-drupal-mariadb-test2-mariadb-master-0
kubectl delete pvc --namespace dev-namespace data-drupal-mariadb-test2-mariadb-slave-0


./install_drupal.sh test1 dev-namespace
./install_drupal.sh test2 dev-namespace
