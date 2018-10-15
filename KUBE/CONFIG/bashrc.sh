
  alias gitrefresh='git checkout origin/master -f | git checkout master -f | git pull origin master'
  alias klogin='cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -u admin -p admin -n services  -c id-mycluster-account'
  alias hlist='helm list -d -r --tls'
  alias hkill='helm delete --tls --purge '
  alias icpstatus='watch -n 5 docker ps -n 5'
  alias pkill='kubectl delete pod --force --grace-period 0 '
  alias plist='kubectl get pods --sort-by='{.metadata.creationTimestamp}' -o wide'
  alias pinspect='kubectl get pod -o yaml '
  alias plog='kubectl logs '
  alias pdesc='kubectl describe pod '
  alias dsearch='docker ps | grep '
  alias dlist='docker ps -n15 --format "table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}" | cut -c -140'
  alias dlistall='docker ps -n15 -a --format "table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}" | cut -c -140'
  alias dlog='docker logs '
  alias ..='cd ..'
  ## Colorize the ls output ##
  alias ls='ls --color=auto'



    function stresstest()
    {
    echo "Starting busybox";
    echo "then start    yes > /dev/null & ";
    docker run -it --rm busybox
    }
