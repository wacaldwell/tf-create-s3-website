##########################################
# File: scripts/bootstrap.sh
##########################################

#!/bin/bash
set -e

echo "Initializing and applying persistent stack..."
cd ../persistent
terraform init && terraform apply -auto-approve

cd ../ephemeral
echo "Initializing and applying ephemeral stack..."
terraform init && terraform apply -auto-approve