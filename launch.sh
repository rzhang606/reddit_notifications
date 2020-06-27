#!/bin/bash

#Description: builds the zip file from the script and required auth file, then applies the terraform
# using paths, ie scripts/file messes up the cloud function, as it expects main.py not script/main.py
cd script
zip reddit_notifs_src.zip authorization.json main.py requirements.txt

cd ../terraform

#safe to run multiple inits
terraform init

# tests if 'terraform show' displays anything; if it doesn't we can just apply without destroying existing resources
if [[ $(terraform show | wc -l ) -eq 1 ]]; then
    echo "No existing terraform resources ... safe to apply"
else
    echo "Existing terraform resources ... deleting for clean apply"
    terraform destroy -auto-approve
fi

#apply
terraform apply -auto-approve