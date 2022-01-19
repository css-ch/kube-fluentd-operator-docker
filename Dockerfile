FROM vmware/kube-fluentd-operator:v1.16.2

RUN set -e \
 && tdnf install -y jq sed \
 && gem install -N fluent-plugin-jq -v "0.5.1" \
 && gem install -N fluent-plugin-splunk-hec -v "1.2.9" \
 && echo OK

# Patch configuration files:
# - Include kube-system.conf after the configs of all other namespaces.
#   The original behaviour was to include kube-system.conf before all other namespaces.
RUN set -e \
 && sed -i '/^#.*kube-system/,/^$/{H; d} ; /#.*namespace annotations/,/^$/{ /^$/G }' /templates/fluent.conf \
 && sed -i '/format3/ s!/[|]!/|^!' /templates/kubernetes.conf
