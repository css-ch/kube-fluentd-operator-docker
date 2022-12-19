FROM vmware/kube-fluentd-operator:v1.16.8

RUN set -e \
 && tdnf install -y jq sed \
 && gem install -N fluent-plugin-jq -v "0.5.1" \
 && echo OK

# Patch configuration files:
# - relabel all at end to allow default match in kube-system.conf (is before all other namespaces)
# - kubelet.log of rancher is in /var/lib/rancher/rke2/agent/logs
RUN set -e \
  && sed -i 's/@type null/@type relabel\n  @label @DEFAULT_OUTPUT/' /templates/fluent.conf \
  && sed -i 's!/var/log/kubelet.log!/var/lib/rancher/rke2/agent/logs/kubelet.log!' /templates/kubernetes.conf
