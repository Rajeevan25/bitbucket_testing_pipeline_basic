# bitbucket_testing_pipeline_basic
# CI/CD Pipeline for Docker Deployment

This project demonstrates the use of a CI/CD pipeline that automates the process of building Docker images, uploading them to Docker Hub, Google Container Registry (GCR), Artifact Registry, and deploying them to Google Cloud Run. The pipeline is designed to run on Bitbucket Pipelines, and this README provides an overview of the setup and the steps involved in the process.

## Prerequisites

- A Bitbucket repository with the pipeline configuration (`bitbucket-pipelines.yml`).
- Docker installed on your local machine for testing purposes.
- Docker Hub account.
- Google Cloud Platform (GCP) account.
- Google Cloud SDK and authentication service account key for GCR and Artifact Registry.
- GCP Project with Cloud Run enabled.

## Overview of the Pipeline

This pipeline performs the following tasks:

1. **Build Docker Image**:
   - Builds the Docker image locally using the `Dockerfile` in the repository.
   - Tags the image with a specified version (e.g., `rajeevany/sample_app2:1.0`).
   - Pushes the image to Docker Hub.

2. **Upload to Google Container Registry (GCR)**:
   - Pulls the image from Docker Hub.
   - Logs in to GCR using a service account key.
   - Tags the image to match the GCR repository format.
   - Pushes the image to GCR.

3. **Upload to Artifact Registry**:
   - Pulls the image from Docker Hub.
   - Authenticates using a service account and uploads the image to Google Cloud’s Artifact Registry.

4. **Deploy to Cloud Run**:
   - Authenticates with GCP using a service account.
   - Deploys the Docker image to Cloud Run in the specified region.

## Bitbucket Pipeline Configuration

### 1. Docker Build and Push to Docker Hub

This step builds a Docker image locally using the repository’s `Dockerfile`. It then tags the image and pushes it to Docker Hub.

```yaml
- step:
    name: build          
    caches:
      - docker
    services:
      - docker
    script:
      - echo "Start Docker building...."
      - docker build -t app01 .    
      - echo "completed Docker building...."
      - docker images
      - docker image tag app01 rajeevany/sample_app2:1.0
      - echo "login docker hub"
      - echo $docker_hub_password | docker login -u rajeevany --password-stdin
      - docker push rajeevany/sample_app2:1.0
