pipeline {
  agent {label 'yarden-ec2'}

    stages {
        stage('Build') {
        steps {
            // docer compose up
            script {
                sh 'docker compose up -d'
                sleep 5 // Wait for the containerized application to start up
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
                    // Test if APP is responsive
                    def curl = sh script: 'curl --silent --fail -I http://localhost:5000/', returnStdout: true
                    if (curl.contains("HTTP/1.1 200 OK")) {
                    echo "The TODO application is running successfully"
                  } else {
                    error "The TODO application is not running successfully"
                  }

                    // Test POST endpoint
                    def ADD = sh script: 'curl --silent -d "task=test" -X POST http://localhost:5000/api/add', returnStdout: true
                    if (ADD.contains('{"task":"test"}')) {
                    echo "The ADD API  is running successfully"
                    } else {
                    error "The ADD API  is not running successfully"
                    }

                    // Get list of tasks
                    def tasks = sh(script: 'curl --silent http://localhost:5000/api', returnStdout: true).trim()

                    // Test PUT(edit)endpoint
                    def PUT = sh script: 'curl --silent -X PUT http://localhost:5000/api/edit -d "old_task=test&new_task=edit-test"', returnStdout: true
                    if (PUT.contains('{"task":"test"}')) {
                    echo "The PUT API  is running successfully"
                    } else {
                    error "The PUT API  is not running successfully"
                    }

                    // Test DELETE endpoint
                    def DELETE = sh script: 'curl --silent -X POST http://localhost:5000/api/delete -d "task=edit-test"', returnStdout: true
                    if (DELETE.contains('{"task":"edit-test"}')) {
                    echo "The DELETE API  is running successfully"
                    } else {
                    error "The DELETE API  is not running successfully"
                    }
                }
            }
        }    
    }


    post {
        always {
            // Bring containers down
            sh 'docker compose down'
        }
    }

}


