pipeline {
    agent any

    environment {
        APP_NAME   = 'urja-cicd-app'
        REGISTRY   = 'localhost:5001'
        IMAGE      = "${REGISTRY}/${APP_NAME}"
        IMAGE_TAG  = "build-${BUILD_NUMBER}"
        KUBECONFIG = '/var/jenkins_home/.kube/config'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'ls -l && git log --oneline -3'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build --build-arg BUILD_NO=${BUILD_NUMBER} -t ${IMAGE}:${IMAGE_TAG} -t ${IMAGE}:latest .'
            }
        }

        stage('Push to Registry') {
            steps {
                sh '''
                    docker push ${IMAGE}:${IMAGE_TAG}
                    docker push ${IMAGE}:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    kubectl set image deployment/${APP_NAME} ${APP_NAME}=${IMAGE}:${IMAGE_TAG}
                    kubectl rollout status deployment/${APP_NAME} --timeout=180s
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    kubectl get deployment ${APP_NAME} -o wide
                    kubectl get pods -l app=${APP_NAME} -o wide
                    kubectl get service urja-cicd-service
                '''
            }
        }
    }

    post {
        success { echo "SUCCESS: ${IMAGE}:${IMAGE_TAG} deployed to Kubernetes by Urja Pipalia (PRN 20240801001)" }
        failure { echo 'FAILED: check the Console Output for the first error.' }
    }
}
