#!/usr/bin/env bash

cd infrastructure/

terraform init

terraform validate

terraform apply -auto-approve