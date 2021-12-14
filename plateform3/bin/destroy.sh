#!/usr/bin/env bash

cd infrastructure

# Delete s3 content
aws s3 rm --recursive s3://mk-rtla-backend
aws s3 rm --recursive s3://mk-rtla-frontend

# Delete terraform architecture
terraform destroy -auto-approve