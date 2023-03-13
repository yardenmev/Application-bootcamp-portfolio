pipeline {
  agent {label 'yarden-ec2'}

    stages {
        stage('Build') {
        steps {
            // docer compose up
            script {
                sh 'docker compose up -d'
                sleep 10 // Wait for the containerized application to start up
                }

                // Check if MongoDB is running
                // script {
                //   def response = sh script: 'curl --silent --fail -I http://localhost:5000/', returnStdout: true
                //   if (response.contains("HTTP/1.1 200 OK")) {
                //     echo "The TODO application is running successfully"
                //   } else {
                //     error "The TODO application is not running"
                //   }
                // }
            }
        }
        stage('Test API') {
            steps {
                script {
                    // Test if API is responsive
                    sh 'curl --silent --fail -I http://localhost:5000/'
                    if (sh.returnStatus != 0) {
                        error('API did not respond')
                    }

                    // Test POST endpoint
                    sh 'curl -d "task=test" -X POST http://localhost:5000/api/add'
                    if (sh.returnStatus != 0) {
                        error('POST request failed')
                    }

                    // Get list of tasks
                    def tasks = sh(script: 'curl http://localhost:5000/api', returnStdout: true).trim()

                    // Test PUT endpoint
                    sh 'curl -X PUT http://localhost:5000/api/edit -d "old_task=test&new_task=edit-test"'
                    if (sh.returnStatus != 0) {
                        error('PUT request failed')
                    }

                    // Test DELETE endpoint
                    sh 'curl -X POST http://localhost:5000/api/delete -d "task=edit-test"'
                    if (sh.returnStatus != 0) {
                        error('DELETE request failed')
                    }

                    // Check if task was deleted
                    def updatedTasks = sh(script: 'curl http://localhost:5000/api', returnStdout: true).trim()
                    if (tasks == updatedTasks) {
                        error('Task was not deleted')
                    }
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


