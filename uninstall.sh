#!/bin/bash

# Kill processes
pkill prometheus
pkill grafana
pkill python

# Remove directories
rm -rf prometheus*
rm -rf grafana*

