# Wisecow Application - Kubernetes Deployment with CI/CD

## Project Overview

This project demonstrates the containerization and deployment of the **Wisecow** application using Docker, Kubernetes, and GitHub Actions. Additionally, utility scripts are provided to support backup, and application health checks.

---

## Project Objectives

### 1. **Dockerization**

- Created a Dockerfile to containerize the Wisecow application.
- The image installs required tools (`cowsay`, `fortune`, etc.) and runs a custom script on container startup.
- The app runs on port `4499`.

### 2. **Kubernetes Deployment**

- Developed Kubernetes manifest files:
  - **Deployment**: Runs the Wisecow container as a Pod.
  - **Service**: Exposes the application internally using `ClusterIP`.
- The application can be accessed within the cluster or via `kubectl port-forward`.

### 3. **CI/CD with GitHub Actions**

- Configured a GitHub Actions workflow to automate:
  - Docker image build and push to Docker Hub.
  - Kubernetes deployment after a successful build.
- Uses GitHub Secrets for Docker Hub and Kubernetes authentication.

---

## Utility Bash Scripts

Located in the `scripts/` directory.

| Script | Description | Usage |
|-------|-------------|-------|
| `Automated_Backup_Script.sh` | Backs up a directory to a destination folder with logging. | `./Automated_Backup_Script.sh <SOURCE_DIR> <BACKUP_DEST>` |
| `Application_Health_Checker.sh` | Checks if an application is running by testing the URL's HTTP response. | `./Application_Health_Checker.sh <APP_URL>` |

> Make scripts executable using `chmod +x script_name.sh` before running.

---

## Steps to Run the Project

1. **Build and Push Docker Image**  
   - Handled automatically via GitHub Actions when code is pushed to the `main` branch.

2. **Deploy to Kubernetes Cluster**
   - GitHub Actions uses `kubectl apply` to deploy manifests using a kubeconfig stored in GitHub Secrets.

3. **Access the App**
   - Use `kubectl port-forward` or create an external service if needed:
     ```
     kubectl port-forward svc/wisecow-service 8080:80
     curl http://localhost:8080
     ```

---

## Author

**Pavani Nettimi**  
DevOps enthusiast working on automation and cloud-native solutions.

---
