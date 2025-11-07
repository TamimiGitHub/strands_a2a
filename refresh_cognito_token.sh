#!/bin/bash

# Get Pool ID
export POOL_ID=$(aws cognito-idp list-user-pools \
  --max-results 60 \
  --region $AWS_REGION | jq -r '.UserPools[] | select(.Name=="AgentCore-a2aServer") | .Id')
echo "Using existing Pool ID: $POOL_ID"

# Retrieve existing client ID for the pool
export CLIENT_ID=$(aws cognito-idp list-user-pool-clients \
  --user-pool-id $POOL_ID \
  --region $AWS_REGION | jq -r '.UserPoolClients[0].ClientId')
echo "Using existing Client ID: $CLIENT_ID"

# Authenticate User and capture Access Token
export BEARER_TOKEN=$(aws cognito-idp initiate-auth \
  --client-id "$CLIENT_ID" \
  --auth-flow USER_PASSWORD_AUTH \
  --auth-parameters USERNAME=$USERNAME,PASSWORD=$PASSWORD \
  --region $AWS_REGION | jq -r '.AuthenticationResult.AccessToken')

# Output the required values
echo "Pool id: $POOL_ID"
echo "Discovery URL: https://cognito-idp.$AWS_REGION.amazonaws.com/$POOL_ID/.well-known/openid-configuration"
echo "Client ID: $CLIENT_ID"
echo "Bearer Token: $BEARER_TOKEN"