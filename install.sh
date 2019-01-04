#!/bin/bash

# Kill processes
pkill prometheus
pkill grafana
pkill python

# Remove old directories if exists
rm -rf prometheus*
rm -rf grafana*

# Install Prometheus binaries
wget https://github.com/prometheus/prometheus/releases/download/v2.6.0/prometheus-2.6.0.linux-amd64.tar.gz -O prometheus.tar.gz
tar -xvf prometheus.tar.gz
rm prometheus.tar.gz

# Install Grafana binaries
wget https://dl.grafana.com/oss/release/grafana-5.4.2.linux-amd64.tar.gz -O grafana.tar.gz
tar -xvf grafana.tar.gz
rm grafana.tar.gz

PROM_HOME=prometheus-2.6.0.linux-amd64
GRAF_HOME=grafana-5.4.2

# Copy prometheus conf
cp conf/prometheus.yml $PROM_HOME/prometheus.yml
cp conf/defaults.ini $GRAF_HOME/conf/defaults.ini


# Run prometheus client
/usr/bin/pip3 install prometheus_client
/usr/bin/python3 client.py &>/dev/null &

# Run prometheus
./$PROM_HOME/prometheus --web.listen-address="0.0.0.0:9090" --config.file=$PROM_HOME/prometheus.yml --storage.tsdb.path=$PROM_HOME/data/ &>/dev/null &

# Run grafana
./$GRAF_HOME/bin/grafana-server -homepath=$GRAF_HOME/ &>/dev/null &
