#!/usr/bin/env bash

cd infrastructure

# Define the project name from terraform variables
PROJECT_NAME="$(cat "variables.tf" | grep 'project_name' -A 2 | grep 'default' | cut -d '=' -f 2 | cut -d '"' -f 2)"

# Delete s3 content
aws s3 rm --recursive "s3://$PROJECT_NAME-backend"
aws s3 rm --recursive "s3://$PROJECT_NAME-frontend"

# Delete terraform architecture
terraform destroy -auto-approve