#!/bin/bash

# This is specifically to deploy to Google Cloud Run from your local machine
# This is not for deploying to Google Kubernetes Engine
# To use this you must sign in to Google Cloud SDK and set your project ID

# # Load environment variables
. ./.env

# # Configure Docker to use Google Cloud as a registry
gcloud auth configure-docker $DOCKER_REPO

gcloud artifacts repositories create vite-repo \
    --project=$GOOGLE_PROJECT_ID \
    --repository-format=docker \
    --location=$DOCKER_REPO_REGION \
    --description="Docker repository"

# # Build the Docker image
docker build -t us-central1-docker.pkg.dev/$GOOGLE_PROJECT_ID/vite-repo/vite-gke:latest .

# # Push the Docker image to the Google Container Registry
docker push us-central1-docker.pkg.dev/$GOOGLE_PROJECT_ID/vite-repo/vite-gke:latest

# # Restart the deployment. Used for rolling updates
kubectl rollout restart deployment <DEPLOYMENT_NAME>