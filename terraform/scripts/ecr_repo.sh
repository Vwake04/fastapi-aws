#!/bin/bash

# Function to configure AWS CLI
function configure_aws {
  local access_key=$1
  local secret_key=$2
  local region=$3

  aws configure set aws_access_key_id "$access_key"
  aws configure set aws_secret_access_key "$secret_key"
  aws configure set region "$region"
}

# Function to check if an ECR repository exists
function check_ecr_repo {
  local repo_name=$1
  aws ecr describe-repositories --repository-names "$repo_name" > /dev/null 2>&1
}

# Function to create an ECR repository
function create_ecr_repo {
  local repo_name=$1
  aws ecr create-repository --repository-name "$repo_name" --query 'repository.repositoryUri' --output text
}

# Main script
ACCESS_KEY=$1
SECRET_KEY=$2
REGION=$3
REPO_NAME=$4

if [ -z "$ACCESS_KEY" ] || [ -z "$SECRET_KEY" ] || [ -z "$REGION" ] || [ -z "$REPO_NAME" ]; then
  echo '{"error": "Usage: $0 <access-key> <secret-key> <region> <repository-name>"}'
  exit 1
fi

# Configure AWS CLI
configure_aws "$ACCESS_KEY" "$SECRET_KEY" "$REGION"

# Check if the ECR repository exists
if check_ecr_repo "$REPO_NAME"; then
  # If the repository exists, return its URI
  REPO_URI=$(aws ecr describe-repositories --repository-names "$REPO_NAME" --query 'repositories[0].repositoryUri' --output text)
else
  # If the repository does not exist, create it and return the URI
  REPO_URI=$(create_ecr_repo "$REPO_NAME")
fi

echo '{"repository_url": "'$REPO_URI'", "repository_name": "'$REPO_NAME'"}'