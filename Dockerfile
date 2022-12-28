# Use patched reloader. Can be removed after version with fix (https://github.com/vmware/kube-fluentd-operator/pull/360) is available.
FROM golang:1.18 as builder
WORKDIR /go/src/github.com/vmware/kube-fluentd-operator
RUN set -e \
 && git clone --depth 1 --branch bugfix/migration-mode-with-cr-namespaces https://github.com/jonasrutishauser/kube-fluentd-operator.git . \
 && cd config-reloader \
 && GO111MODULE=on GOARCH=amd64 CGO_ENABLED=0 go build -v -ldflags "-X github.com/vmware/kube-fluentd-operator/config-reloader/config.Version=1.16.8-1 -w -s" .
# End patch build

FROM vmware/kube-fluentd-operator:v1.16.8

RUN set -e \
 && tdnf install -y jq sed \
 && gem install -N fluent-plugin-jq -v "0.5.1" \
 && echo OK

# Use patched reloader
COPY --from=builder /go/src/github.com/vmware/kube-fluentd-operator/config-reloader/config-reloader /bin/config-reloader

# Patch configuration files:
# - relabel all at end to allow default match in kube-system.conf (is before all other namespaces)
# - kubelet.log of rancher is in /var/lib/rancher/rke2/agent/logs
RUN set -e \
  && sed -i 's/@type null/@type relabel\n  @label @DEFAULT_OUTPUT/' /templates/fluent.conf \
  && sed -i 's!/var/log/kubelet.log!/var/lib/rancher/rke2/agent/logs/kubelet.log!' /templates/kubernetes.conf
