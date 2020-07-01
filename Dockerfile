FROM vmware/kube-fluentd-operator:v1.12.0

RUN set -e \
 && tdnf install -y jq \
 && gem install -N fluent-plugin-kubernetes_metadata_filter -v "2.4.1" \
 && gem uninstall fluent-plugin-kubernetes_metadata_filter -v "2.4.2" \
 && gem install -N fluent-plugin-jq -v "0.5.1" \
 && gem install -N fluent-plugin-splunk-hec -v "1.1.0" \
 && echo OK

# Patch configuration files:
# - Include kube-system.conf after the configs of all other namespaces. 
#   The original behaviour was to include kube-system.conf before all other namespaces.
RUN set -e \
 && sed -i '/^#.*kube-system/,/^$/{H; d} ; /#.*namespace annotations/,/^$/{ /^$/G }' /templates/fluent.conf