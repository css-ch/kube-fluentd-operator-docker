# kube-fluentd-operator-docker

Extend [vmware/kube-fluentd-operator](https://github.com/vmware/kube-fluentd-operator) with more plugins.

Docker Hub: [cssinsurance/kube-fluentd-operator](https://hub.docker.com/r/cssinsurance/kube-fluentd-operator).

## Build

    $ docker build -t kube-fluentd-operator .
    
## Examine

    $ docker run -it --rm --entrypoint /bin/bash kube-fluentd-operator 
    $ gem list fluentd
