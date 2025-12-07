This Terraform project provisions a complete Azure infrastructure required to deploy containerized applications using Azure Kubernetes Service (AKS).
The setup includes:

Virtual Network (VNet)
Subnet for AKS
Network Security Group (NSG) attached to the subnet
Azure Container Registry (ACR)
AKS cluster integrated with:
the previously created ACR
the dedicated subnet
the NSG for traffic control

**Project Structure**

main.tf - Calls All modules needed
variables.tf - Input variables for customization
env/test-env.tfvars - Real values for the input variables
modules/acr - Module setup to create a new ACR
modiules/aks-cluster - Module setup to provision a new AKS
modules/network - Module setup to create the virtual network for the account


**Prerequisites**

Before deploying:
Install Terraform (v1.0+)
Install Azure CLI
Login to Azure:
az login

**How to Deploy**
- Initialize Terraform
  terraform init

- Review the plan
  terraform plan -var-file env/test-env.tfvars

- Apply the infrastructure
  terraform apply -var-file env/test-env.tfvars
