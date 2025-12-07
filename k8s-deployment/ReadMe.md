This guide describes the steps to deploy a Python Flask application on Azure Kubernetes Service (AKS) using an ACR image, and monitor both the application and the cluster using Prometheus and Grafana.

The application exposes a LoadBalancer service and is deployed in a dedicated namespace. Prometheus is installed via Helm, and Grafana is exposed through a LoadBalancer for external access.

**Project Structure**

namespace.yaml - declartion to create a new namespace for the application
deployment.yaml - declartion to deploy the app using deployment kind
service.yaml - declartion to expose the app using a service of typr loadbalancer
service-monitor.yaml - declartion of service to be used for the monitoring of prometheus
grafana-lb.yaml - declartion to expose grafana UI


Install Prometheus and Grafana
    $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

Update the Helm Repository −
    $ helm repo update

Install Prometheus Stack using Helm 
    $ helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
Retrieve Grafana Admin password
    $kubectl --namespace monitoring get secrets prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

Apply all needed yaml files to start the deployment of the environment 
    $kubectl apply -f ./k8s-deployment

Modify Python App to Include Metrics

Install Prometheus client:

pip install prometheus_client


# Update __init__.py to include metrics endpoint

/metrics endpoint will be scraped by Prometheus.    

**Monitor Cluster Performance**

Node Exporter metrics are available via Prometheus.

Metrics include:
CPU usage
Memory usage
Disk I/O
Network statistics

**Monitor Application**

Configured Python app to expose /metrics endpoint with Prometheus metrics
Prometheus automatically scrapes metrics from the application

Prometheus query to get the number of total app requests:
rate(app_requests_total[1m])
