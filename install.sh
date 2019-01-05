#!/bin/bash

echo -e "---------------------"
echo -e "Preparing Environment"
echo -e "---------------------"

# Kill processes
pkill prometheus
pkill grafana
pkill python

# Remove old directories if exists
rm -rf prometheus*
rm -rf grafana*

echo -e "Environment prepared !\n\n"

echo -e "---------------------"
echo -e "-Download Prometheus-"
echo -e "---------------------"
# Install Prometheus binaries
wget -q --show-progress https://github.com/prometheus/prometheus/releases/download/v2.6.0/prometheus-2.6.0.linux-amd64.tar.gz -O prometheus.tar.gz
tar -xf prometheus.tar.gz
rm prometheus.tar.gz
echo -e "Prometheus Downloaded\n\n"

echo -e "---------------------"
echo -e "-Download Grafana----"
echo -e "---------------------"
# Install Grafana binaries
wget -q --show-progress https://dl.grafana.com/oss/release/grafana-5.4.2.linux-amd64.tar.gz -O grafana.tar.gz
tar -xf grafana.tar.gz
rm grafana.tar.gz
echo -e "Grafana Downloaded\n\n"

PROM_HOME=prometheus-2.6.0.linux-amd64
GRAF_HOME=grafana-5.4.2

echo -e "---------------------"
echo -e "-Copy configurations-"
echo -e "---------------------"
# Copy prometheus conf
cp conf/prometheus.yml $PROM_HOME/prometheus.yml
cp conf/defaults.ini $GRAF_HOME/conf/defaults.ini
echo -e "Configurations copied\n\n"

echo -e "---------------------"
echo -e "Run Prometheus client"
echo -e "---------------------"
# Run prometheus client
/usr/bin/pip3 install prometheus_client
/usr/bin/python3 client.py &>/dev/null &
echo -e "Prometheus client runs !\n\n"

echo -e "---------------------"
echo -e "-Run Promethues------"
echo -e "---------------------"
# Run prometheus
./$PROM_HOME/prometheus --web.listen-address="0.0.0.0:9090" --config.file=$PROM_HOME/prometheus.yml --storage.tsdb.path=$PROM_HOME/data/ &>/dev/null &
echo -e "Prometheus runs !\n\n"

echo -e "---------------------"
echo -e "-Run Grafana---------"
echo -e "---------------------"
# Run grafana
./$GRAF_HOME/bin/grafana-server -homepath=$GRAF_HOME/ &>/dev/null &
echo -e "Grafana runs !\n\n"
