pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-assignment .'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker compose up -d --build'
            }
        }

        stage('Validation') {
            steps {
                sh 'curl -f --retry 10 --retry-delay 3 http://host.docker.internal:8082/health'
            }
        }
    }
    post {
    always {
        sh '''
            docker compose down || true
            docker image prune -f || true
        '''
    }
}

}

