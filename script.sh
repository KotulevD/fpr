#!/bin/bash

cd stage/remote-backend
pwd
terraform init && terraform plan && terraform apply -auto-approve
#terraform init && terraform plan && terraform apply

cd ../postgres/
pwd
terraform init && terraform plan && terraform apply -auto-approve

cd ../services/webserver-cluster
pwd
#terraform init && terraform plan && terraform apply
terraform init && terraform plan && terraform apply -auto-approve
