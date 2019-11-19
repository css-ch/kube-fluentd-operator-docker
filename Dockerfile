FROM jvassev/kube-fluentd-operator:v1.11.0

RUN set -e \
 && apt-get update \
 && apt-get install -y --no-install-recommends jq \
#&& apt-get install -y --no-install-recommends jq libjemalloc1 \ # hat bereits 
#&& buildDeps="make gcc g++ wget ruby-dev" \
#&& apt-get install -y --no-install-recommends $buildDeps \
#&& gem install -N fluentd -v "1.5.1" \ # hat bereits 1.5.2
#&& gem install -N fluent-plugin-systemd -v "0.3.1" \ # hat bereits 1.0.1
#&& gem install -N fluent-plugin-concat -v "2.2.2" \ # hat bereits 2.3.0
#&& gem install -N fluent-plugin-prometheus -v "1.0.1" \ # hat bereits 1.3.0
 && gem install -N fluent-plugin-jq -v "0.5.1" \
 && gem install -N fluent-plugin-splunk-hec -v "1.1.0" \
#&& gem install -N oj -v "3.5.1" \  # hat bereits 3.3.10.
#&& apt-get purge -y --auto-remove \
#                 -o APT::AutoRemove::RecommendsImportant=false \
#                 $buildDeps \
#&& rm -rf /var/lib/apt/lists/* \
#&& rm -rf /tmp/* /var/tmp/* $GEM_HOME/cache/*.gem \
 && echo OK
