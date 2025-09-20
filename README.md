# Wisecow Application - Kubernetes Deployment with CI/CD

## Project Overview

This project demonstrates the containerization and deployment of the **Wisecow** application using Docker, Kubernetes, and GitHub Actions. Additionally, utility scripts are provided to support backup, and application health checks.

---

## Project Objectives

### 1. **Dockerization**

- The application is containerized using **Docker**.
- A **Dockerfile** has been created to set up the environment with required dependencies.
- The Docker image installs tools such as `cowsay`, `fortune`, etc.
- The application runs on port **4499**.

### 2. **Kubernetes Deployment**

- Kubernetes manifests are used for deploying the application to the cluster:
  - **Deployment**: Runs the Wisecow container as a Pod.
  - **Service**: Exposes the application within the cluster using `ClusterIP`.
- The application can be accessed internally within the cluster.

### 3. **CI/CD with GitHub Actions and Self-hosted Runner**

- A **self-hosted GitHub Actions runner** is set up on an **EC2 instance** inside your AWS VPC (with a private IP) for security and to ensure that all Kubernetes commands can be executed within the internal network.
- **GitHub Actions** is configured to automate the following processes:
  - Docker image build and push to **Docker Hub**.
  - Kubernetes deployment using updated images after every successful build.
- **GitHub Secrets** are used for storing Docker Hub credentials and Kubernetes authentication details.

---

## Utility Bash Scripts

Located in the `scripts/` directory.

| Script | Description | Usage |
|-------|-------------|-------|
| `Automated_Backup_Script.sh` | Backs up a directory to a destination folder with logging. | `./Automated_Backup_Script.sh <SOURCE_DIR> <BACKUP_DEST>` |
| `Application_Health_Checker.sh` | Checks if an application is running by testing the URL's HTTP response. | `./Application_Health_Checker.sh <APP_URL>` |

> Make scripts executable using `chmod +x script_name.sh` before running.

---

## How the Application is Deployed

### 1. **Docker Image**

- When code is pushed to the **main branch** in the GitHub repository, **GitHub Actions** triggers the build process for the Docker image.
- The image is built and tagged as `latest`, then pushed to **Docker Hub** for storage.
- This ensures the application is always available and up-to-date in the Docker repository.

### 2. **Kubernetes Deployment**

- After pushing the Docker image to Docker Hub, **GitHub Actions** deploys the updated image to the Kubernetes cluster using `kubectl`.
- The Kubernetes deployment is configured to pull the **latest** image from Docker Hub and deploy it on the Kubernetes cluster.

### 3. **Pod Management**

- The Kubernetes deployment is set to run **one replica** of the application by default.
- The number of replicas can be adjusted based on load and availability needs.

### 4. **Kubernetes Cluster and Nodes**

- The Kubernetes cluster is set up with **two EC2 instances** on AWS:
  - **Master Node**: Controls the cluster and runs the Kubernetes API server, scheduler, and controller manager.
  - **Worker Node**: Runs the application Pods and hosts the containers.
  
- The cluster is running **Kubernetes (k8s)**.

### 5. **Self-hosted GitHub Actions Runner**

- **Self-hosted GitHub Actions Runner** is configured on the EC2 instance running inside the private AWS network. This runner will trigger the CI/CD pipeline without needing a public IP.
- The runner connects to GitHub Actions and executes the deployment and image build pipeline.
- Once the runner is configured, GitHub Actions will trigger the CI/CD pipeline and the runner will execute the deployment commands internally, with access to the private IP resources.

### 6. **How to Access the Application**

- The application is deployed using a **ClusterIP** service, meaning it's accessible within the Kubernetes cluster.
- For external access from your local machine, you can use `kubectl port-forward` to forward the service's port to your local machine.

## Steps to Run the Project

1. **Build and Push Docker Image**  
   - This process is automated by **GitHub Actions** when code is pushed to the `main` branch. The Docker image is built and pushed to Docker Hub automatically.

2. **Deploy to Kubernetes Cluster**
   - **GitHub Actions** uses `kubectl apply` to apply the Kubernetes manifests (such as `deployment.yaml` and `service.yaml`) to the cluster, deploying the application to Kubernetes.

3. **Access the Application**  
   - To access the application locally, use `kubectl port-forward` to map the service's port to a local port.

---

## AWS EC2 Setup and Configuration

### 1. **EC2 Instances**

- The Kubernetes cluster runs on **two EC2 instances**:
  - **Master Node**: Runs the Kubernetes control plane and manages cluster operations.
  - **Worker Node**: Hosts the application Pods.
 
### 2. **Security Groups**

- The security groups associated with these EC2 instances should allow inbound traffic on the following ports:
  - Port `6443` for the Kubernetes API server.
  - Port `10250` for the Kubelet.
 
---

## Author

**Pavani Nettimi**  
DevOps enthusiast working on automation and cloud-native solutions.

---
