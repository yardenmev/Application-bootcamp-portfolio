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
          def response = sh script: 'curl --silent --fail mongodb://mongo:27017/', returnStdout: true
          if (response.contains("It looks like you are trying to access MongoDB over HTTP on the native driver port.")) {
            echo "MongoDB is running successfully"
          } else {
            error "MongoDB is not running"
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
