#!/bin/bash

# Create User Pool and capture Pool ID directly
export POOL_ID=$(aws cognito-idp create-user-pool \
  --pool-name "AgentCore-a2aServer" \
  --policies '{"PasswordPolicy":{"MinimumLength":6}}' \
  --region $AWS_REGION | jq -r '.UserPool.Id')

# Create App Client and capture Client ID directly
export CLIENT_ID=$(aws cognito-idp create-user-pool-client \
  --user-pool-id $POOL_ID \
  --client-name "MyClient" \
  --no-generate-secret \
  --explicit-auth-flows "ALLOW_USER_PASSWORD_AUTH" "ALLOW_REFRESH_TOKEN_AUTH" \
  --region $AWS_REGION | jq -r '.UserPoolClient.ClientId')

# Create User
aws cognito-idp admin-create-user \
  --user-pool-id $POOL_ID \
  --username $USERNAME \
  --region $AWS_REGION \
  --message-action SUPPRESS > /dev/null

# Set Permanent Password
aws cognito-idp admin-set-user-password \
  --user-pool-id $POOL_ID \
  --username $USERNAME \
  --password $PASSWORD \
  --region $AWS_REGION \
  --permanent > /dev/null

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