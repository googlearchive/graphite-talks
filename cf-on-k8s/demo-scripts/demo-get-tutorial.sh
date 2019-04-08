#!/usr/bin/env bash

mkdir -p ~/src

set -x
git clone --branch cf-na-summit-2019 https://github.com/GoogleCloudPlatform/graphite-talks ~/src/graphite-talks
cd ~/src/graphite-talks/cf-on-k8s

