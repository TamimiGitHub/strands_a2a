#!/bin/bash
# This script sets environment variables for the terminal session
# Usage: source ./env.sh or . ./env.sh

# Export environment variables
export USERNAME="tamimi"
export PASSWORD="MyStrongPass123!"
export AWS_REGION="us-west-2"

# Print confirmation message
echo "Environment variables set:"
echo "USERNAME=$USERNAME"
echo "PASSWORD=$PASSWORD"
echo "AWS_REGION=$AWS_REGION"

# Add a warning if the script is executed directly instead of being sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo ""
  echo "WARNING: This script should be sourced, not executed directly."
  echo "Run 'source ./env.sh' or '. ./env.sh' instead of './env.sh'"
  echo "The environment variables will not persist in your current shell."
fi