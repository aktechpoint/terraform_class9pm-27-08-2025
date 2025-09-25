#!/bin/bash

# Define array (no spaces around =)
resources=(
   "aws_s3_bucket.abhishek-bucket"
   "aws_instance.abhishek"
)

# Initialize target string
target=""

# Loop through array
for resource in "${resources[@]}"; do
   target="$target -target=$resource"
done

# Run terraform apply with all targets
terraform destroy $target -auto-approve
