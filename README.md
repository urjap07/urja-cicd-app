# urja-cicd-app

CI/CD pipeline with Jenkins for Docker & Kubernetes — Cloud Native Orchestration, Practical 7.

**Student:** Urja Pipalia &nbsp;|&nbsp; **PRN:** 20240801001

Pipeline: GitHub → Jenkins → Docker build → push to registry → deploy to Kubernetes.

| File | Purpose |
|------|---------|
| `Jenkinsfile` | Declarative pipeline (Checkout, Build Docker Image, Push to Registry, Deploy to Kubernetes, Verify Deployment) |
| `Dockerfile` | nginx:alpine image serving `index.html` |
| `k8s/deployment.yaml` | Kubernetes Deployment (2 replicas) |
| `k8s/service.yaml` | Kubernetes Service |
