// pipeline {
//     agent any
//     stages {
//         stage('Build image') {
//             steps {
//                 // sh 'docker build -t yarden-todo:1 .'
//                 // sh 'docker images'
//                 sh 'git tag -l'
//             }
//         }
//     }    
            
// }

pipeline {
  agent any

  stages {
    stage('Build and Test') {
      steps {
        // docer compose up
        script {
          sh 'docker-compose up -d'
        }

        // Check if MongoDB is running
        script {
           def response = sh script: 'curl --silent --fail -I http://34.240.82.35:5000/', returnStdout: true
          if (response.contains("HTTP/1.1 200 OK")) {
            echo "The containerized application is running successfully"
          } else {
            error "The containerized application is not running"
          }
        }
      }
    }
  }

  post {
    always {
      // Bring containers down
      sh 'docker-compose down'
    }
  }
}
