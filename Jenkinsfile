pipeline {
    agent any
    stages {
        stage('Build image') {
            steps {
                sh 'docker build -t todo:1 .'
                sh 'docker images'
            }
        }
    }    
            
}