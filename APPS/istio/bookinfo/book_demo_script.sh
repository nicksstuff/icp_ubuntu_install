


kubectl apply -f ~/INSTALL/APPS/istio/bookinfo/book_all_v1.yaml
kubectl apply -f ~/INSTALL/APPS/istio/bookinfo/book_50.yaml

KUBE_EDITOR="nano" kubectl  edit virtualservice reviews

kubectl apply -f ~/INSTALL/APPS/istio/bookinfo/book_jason.yaml

kubectl apply -f ~/INSTALL/APPS/istio/bookinfo/book_deny_v2.yaml

for i in `seq 1 200000`; do curl http://$(hostname --ip-address):31380/productpage; done

kubectl label namespace default istio-injection=enabled
kubectl label namespace cert-manager istio-injection=enabled
kubectl get ns --show-labels

kubectl delete -f ~/INSTALL/APPS/istio/bookinfo/book_deny_v2.yaml
kubectl delete -f ~/INSTALL/APPS/istio/"$NAME"/samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl delete -f ~/INSTALL/APPS/istio/"$NAME"/samples/bookinfo/networking/destination-rule-all.yaml
kubectl delete -f ~/INSTALL/APPS/istio/"$NAME"/samples/bookinfo/platform/kube/bookinfo.yaml
