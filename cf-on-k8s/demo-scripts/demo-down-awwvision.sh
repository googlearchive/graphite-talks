#!/usr/bin/env bash

set -x

cf delete awwvision
cf delete-service ml
cf delete-service awwvision-storage

