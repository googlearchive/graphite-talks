#!/usr/bin/env bash

mkdir -p ~/src

set -x
git clone --branch develop https://github.com/GoogleCloudPlatform/gcp-service-broker ~/src/gcp-service-broker
cd ~/src/gcp-service-broker/deployments/helm/gcp-service-broker

