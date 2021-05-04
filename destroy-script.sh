#!/bin/bash

#cd stage/remote-backend
#pwd
#terraform init && terraform plan -destroy -out destroy.plan && terraform apply destroy.plan  -auto-approve

cd stage/postgres/
pwd
terraform init && terraform plan -destroy -out destroy.plan && terraform apply destroy.plan  

cd ../services/webserver-cluster
pwd
terraform init && terraform plan -destroy -out destroy.plan && terraform apply destroy.plan 
