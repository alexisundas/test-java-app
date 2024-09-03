## Project Overview

This project is a Spring Boot application designed to count website visits. The application is containerized using Docker and deployed on an AWS EC2 instance using Terraform. GitHub Actions is used to automate the build, Docker image creation, and deployment processes.

## Prerequisites

Before getting started, ensure you have the following:

1. **Java 17**: Required for building the Spring Boot application.
2. **Docker**: For containerizing the application.
3. **Terraform**: For provisioning AWS resources.
4. **GitHub Account**: For hosting the repository and setting up GitHub Actions.
5. **Docker Hub Account**: For storing the Docker image.
6. **AWS Account**: For deploying the application on AWS EC2.

## Setup Instructions

### 1. Build and Run Locally

1. **Clone the Repository**

    ```bash
    git clone https://github.com/your-username/WebsiteCounter.git
    cd WebsiteCounter
    ```

2. **Build the JAR File**

    Ensure the Maven wrapper script is executable:

    ```bash
    chmod +x mvnw
    ```

    Build the JAR file:

    ```bash
    ./mvnw package
    ```

3. **Run the Application**

    ```bash
    java -jar target/WebsiteCounter-0.0.1-SNAPSHOT.jar
    ```

### 2. Dockerize the Application

1. **Create Docker Image**

    Build the Docker image:

    ```bash
    docker build -t your-dockerhub-username/websitecounter:latest .
    ```

2. **Push Docker Image to Docker Hub**

    Log in to Docker Hub:

    ```bash
    docker login
    ```

    Push the Docker image:

    ```bash
    docker push your-dockerhub-username/websitecounter:latest
    ```

### 3. Set Up GitHub Actions

1. **Create the GitHub Actions Workflow**

    Create the file `.github/workflows/ci-cd.yml` in your repository with the following content:

    ```yaml
    name: CI/CD Pipeline

    on:
      push:
        branches:
          - main  # Trigger the pipeline on push to the main branch

    jobs:
      build-and-deploy:
        runs-on: ubuntu-latest

        steps:
        - name: Checkout code
          uses: actions/checkout@v4

        - name: Set up JDK 17
          uses: actions/setup-java@v4
          with:
            java-version: '17'
            distribution: 'oracle'  # Use 'Oracle'

        - name: Make Maven Wrapper Executable
          run: chmod +x mvnw

        - name: Build JAR
          run: ./mvnw package

        - name: Build Docker image
          run: |
            docker build -t ${{ secrets.DOCKER_USERNAME }}/websitecounter:latest .

        - name: Log in to Docker Hub
          run: echo "${{ secrets.DOCKER_PASSWORD }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin

        - name: Push Docker image to Docker Hub
          run: docker push ${{ secrets.DOCKER_USERNAME }}/websitecounter:latest
    ```

2. **Configure GitHub Secrets**

    In your GitHub repository, go to **Settings** > **Secrets and variables** > **Actions**, and add the following secrets:

    - `DOCKER_USERNAME`: Your Docker Hub username.
    - `DOCKER_PASSWORD`: Your Docker Hub password.
