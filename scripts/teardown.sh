##########################################
# File: scripts/teardown.sh
##########################################

#!/bin/bash
set -e

echo "Destroying ephemeral stack..."
cd ../ephemeral
terraform destroy -auto-approve
