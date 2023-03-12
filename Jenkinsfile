pipeline {
    agent any
    stages {
        stage('Build image') {
            steps {
                sh 'sudo docker build -t todo: .'
                sh 'sudo docker images'
            }
        }
            
}