This project demonstrates a CI/CD pipeline that automates:

Building a Docker image of a Python Flask application

Pushing the image to Azure Container Registry (ACR)

Deploying the new image to an Azure Kubernetes Service (AKS) deployment


**Pipeline Stages**
Stage 1: Build Docker Image
Build the Docker image and tag it
docker build -t <ACR_NAME>/python-app:latest .

Stage 2: Push Image to ACR
Login to ACR:
az acr login --name <ACR_NAME>
docker push <ACR_NAME>/python-app:latest


Stage 3: Deploy to AKS
Update the deployment with new image:
kubectl set image deployment/python-app python-app=<ACR_NAME>/python-app:latest -n <NAMESPACE>

Restart the deployment to make sure the deployment has the latest change
kubectl rollout restart deployment/python-app -n <NAMESPACE>

Verify rollout status:
kubectl rollout status deployment/python-app -n <NAMESPACE>




