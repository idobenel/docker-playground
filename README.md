# DevOps Assignment - Application Containerization and Deployment

## Overview

Your task is to containerize a provided application, deploy it along with a MongoDB instance to a local Kubernetes cluster, and orchestrate the deployment using Helm. The goal is to demonstrate your ability to use Docker multi-stage builds, create parameterized Helm charts, and implement a reliable deployment strategy (including rolling updates) for a modern microservice application.

## Prerequisites

Before you begin, ensure that you have the following installed on your PC (with Administrator/root permissions and an active internet connection):

1. **Docker** – for building and running containers
2. **Docker-compose** - for building and running multiple containers at once 

## Part 1: Docker Containerization

### Objectives
* **Create a Docker container** for the provided application using a multi-stage Dockerfile.

### Requirements for the Docker container:
* **Start Script:** The container should start the application using a provided start.sh script.
* **Installed Packages:** The container must include:
   * ca-certificates
   * bash
   * vim
   * procps
   * curl
* **User Settings:**
   * Home directory set to /home/user
   * Create a user and group with ID **1500**
* **Node Modules:** Ensure that the application's node_modules are preserved in the container.

### Deliverable
* A **Dockerfile** that implements the multi-stage build for your application according to the above requirements.

## Part 2: Multi Container Deploy with Docker Compose

### Objectives
* **Deploy the application and a MongoDB image** using docker compose.

### Deployment Parameters
The deployment should support the following configurable parameters:
* **command:** node
* **args:** compose-test.js
* **port:** 8080
* **Environment Variable:** NODE_ENV=production

### Service & Connectivity
* Create a docker compose Service and configure connectivity between the application and the MongoDB instance using host-based networking.

### Deliverable
* A **docker-compose.yml** file that orchestrates both the application and MongoDB services according to the above requirements.