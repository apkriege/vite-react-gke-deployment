# React + TypeScript + Vite + GKE

This template provides a minimal setup to get React working in Vite and has all the necessary scripts to build and deploy to a GKE cluster. 

## Setup 
1. Install dependencies `npm install`
2. Add and .env file from the .env.example file
3. Make sure you have Artifact Registry and Kubernetes APIs enabled in GCP
5. Download the gcloud CLI SDK https://cloud.google.com/sdk/docs/install

Once you have all the above done open your terminal and do the following to connect to your project
-  Authenticate your local machine to the GCP `gcloud auth login`
-  Or login with application default credentials `gcloud auth application-default login` 
   ** Note this is only for development purposes. Follow best practice on production. **
<br>

## GKE Setup
Create your a cluster that will use GKE autopilot. This feature is great because it takes all the overhead off you plate.
```
gcloud config set project PROJECT_ID
```
```
gcloud container clusters create-auto hello-cluster \
    --location=us-central1
```
Here is a reource if you want to get a better understanding. Also, it covers a few useful commands which will become essential to understand how the system is operating. 

https://cloud.google.com/kubernetes-engine/docs/deploy-app-cluster#main.go
<br><br>

## Scripts
The yaml files are what will create the GKE configuration and connect each resource to one another. 

<span style="color: blue">deployment.yaml</span> - Creates a Workload. This is the logic of your application.
  ```
  kubectl apply -f deployment.yaml
  ```
<br>

<b>service.yaml</b> - Creates a service that opens a port to connect to your workload.
  ```
  kubectl apply -f service.yaml
  ```
<br>

<b>ingress.yaml</b> - Creates a load balancer that will expose the service to an external IP.
  ```
  kubectl apply -f ingress.yaml
  ```
<br>

<b>cert.yaml</b> - Creates a google managed certificate. Only necessary if you need to service your app over https (which you should)
  ```
  kubectl apply -f cert.yaml
  ```
<br>

*** As a general note all of these take a minute to apply and propegate so be patient. If there are errors it should explain where the disconnection is. The cert will take the longest and may take some time to provision. ***
<br><br>

## Helpful Commands
```
kubectl get pods
kubectl describe deployment <deployment-name>
kubectl describe service <service-name>
kubectl describe ingress <ingress-name>
kubectl describe managedcertificate <certificate-name>
```
