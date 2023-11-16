#!/bin/bash

# Define your AWS region and ECR repository name
AWS_ACCOUNT_ID="508632573795"
AWS_REGION="us-east-1"
AWS_PROFILE="juanjodevio"
ECR_REPO_NAME="data-lake-etl-poc"


# Check if a version/tag parameter is provided, or set it to "latest" by default
if [ $# -eq 1 ]; then
  IMAGE_TAG="$1"
else
  IMAGE_TAG="latest"
fi

# Generate requirements.txt file
poetry export -f requirements.txt --without-hashes --output ./data_lake_etl_poc/requirements.txt

# Build Docker image
docker build -t $ECR_REPO_NAME:$IMAGE_TAG .

# Authenticate Docker to your ECR registry
aws ecr get-login-password --region $AWS_REGION --profile $AWS_PROFILE | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Tag your Docker image with the ECR repository URI
docker tag $ECR_REPO_NAME:$IMAGE_TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG

# Push the Docker image to ECR
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG

echo "Docker image with tag $IMAGE_TAG pushed to ECR: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG"
