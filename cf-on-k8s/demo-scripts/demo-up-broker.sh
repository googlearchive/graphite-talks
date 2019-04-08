#!/usr/bin/env bash

set -x

cf enable-service-access google-storage
cf enable-service-access google-ml-apis
cf enable-service-access google-cloudsql-mysql

