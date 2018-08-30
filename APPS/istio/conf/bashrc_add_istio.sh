
  function istio_helloworld_test()
  {
  echo "TEST HELLOWORLD";
  for i in `seq 1 200000`; do curl http://$(hostname --ip-address):31461/hello; done
  }

  function istio_helloworld_V1()
  {
  echo "Only V1";
  istioctl delete virtualservice helloworld --namespace default
  istioctl create -f ~/INSTALL/APPS/istio/helloworld/vs_100_0.yaml
  }

  function istio_helloworld_BOTH()
  {
  echo "V1 and V2";
  istioctl delete virtualservice helloworld --namespace default
  istioctl create -f ~/INSTALL/APPS/istio/helloworld/vs_50_50.yaml
  }


  function istio_helloworld_V2()
  {
  echo "Only V2";
  istioctl delete virtualservice helloworld --namespace default
  istioctl create -f ~/INSTALL/APPS/istio/helloworld/vs_0_100.yaml
  }


  function istio_helloworld_remove_routingrule()
  {
  echo "Remove Routing Rule";
  istioctl delete virtualservice helloworld --namespace default
  }


  function istio_helloworld_start()
  {
  echo "Starting Hello World";
  istioctl kube-inject -f ~/INSTALL/APPS/istio/istio-1.0.0/samples/helloworld/helloworld.yaml -o ~/INSTALL/ISTIO/istio-1.0.0/samples/helloworld/helloworld-istio.yaml
  kubectl create -f ~/INSTALL/APPS/istio/istio-1.0.0/samples/helloworld/helloworld-istio.yaml
  }


  function istio_helloworld_stop()
  {
  echo "Stopping Hello World";
  kubectl delete -f ~/INSTALL/APPS/istio/istio-1.0.0/samples/helloworld/helloworld-istio.yaml
  }






  function istio_bookinfo_test()
  {
  echo "TEST BOOKINFO";
  for i in `seq 1 200000`; do curl http://$(hostname --ip-address):31461/productpage; done
  }


  function bookinfo_50()
  {
  echo "Only V1";
  istioctl create -f ~/INSTALL/APPS/istio/bookinfo/book_50.yaml
  }


  function bookinfo_jason()
  {
  echo "Only JASON on V3";
  istioctl replace -f ~/INSTALL/APPS/istio/bookinfo/book_jason.yaml
  }



  function bookinfo_edit()
  {
  echo "Edit";
  ~/INSTALL/APPS/istio/bookinfo/book_edit.sh
  }

  function bookinfo_reset()
  {
  echo "Reset Routing Rules";
  kubectl delete virtualservice reviews
  }


  function bookinfo_start()
  {
  echo "Starting Bookinfo";
  kubectl apply -f <(istioctl kube-inject -f ~/INSTALL/APPS/istio/istio-1.0.1/samples/bookinfo/platform/kube/bookinfo.yaml)
  kubectl apply -f ~/INSTALL/APPS/istio/istio-1.0.1/samples/bookinfo/networking/bookinfo-gateway.yaml

  }


  function bookinfo_stop()
  {
  echo "Stopping Bookinfo";
  kubectl delete -f ~/INSTALL/APPS/istio/istio-1.0.1/samples/bookinfo/platform/kube/bookinfo.yaml
  kubectl delete -f ~/INSTALL/APPS/istio/istio-1.0.1/samples/bookinfo/networking/bookinfo-gateway.yaml
  }
