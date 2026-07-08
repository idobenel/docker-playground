pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                echo "Description: Starting to build the Docker image from the local Dockerfile ==="
                sh 'docker build -t devops-assignment .'
            }
            post {
                success { echo "SUCCESS: Docker image 'devops-assignment' built successfully!" }
                failure { echo "FAILURE: Failed to build Docker image. Check Dockerfile or context." }
            }
        }
        
        stage('Cleanup old deployment') {
            steps {
                echo "Description: Making sure no previous containers are running on the system ==="
                sh 'docker compose down || true'
            }
            post {
                success { echo "SUCCESS: Old deployment cleanup finished." }
            }
        }

        stage('Deploy') {
            steps {
                echo "=== Deploying containers in detached mode using Docker Compose ==="
                sh 'docker compose up -d --build'
            }
            post {
                success { echo "SUCCESS: Containers deployed successfully in the background." }
                failure { echo "FAILURE: Docker Compose failed to start the containers." }
            }
        }

        stage('Validation') {
            steps {
                echo "=== Validating application health status by hitting the /health endpoint ==="
                sh 'curl -f --retry 10 --retry-connrefused --retry-delay 3 http://host.docker.internal:8082/health'
            }
            post {
                success { echo "SUCCESS: Health check passed! The application is healthy and responding." }
                failure { echo "FAILURE: Health check failed. The application did not respond correctly within the time limit." }
            }
        }
    }

    post {
        always {
            echo "=== Running final environment cleanup (Always executes) ==="
            sh '''
                docker compose down || true
                docker image prune -f || true
            '''
        }
        success {
            echo "PIPELINE SUCCESS: All stages completed successfully! Code is solid."
        }
        failure {
            echo "PIPELINE FAILURE: Something went wrong during the execution. Please review the logs above."
        }
    }
}
