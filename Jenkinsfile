pipeline {
    agent {label 'yarden-ec2'}

        stages {
            stage('version number calculation') {
                when{
                    branch 'main'
                }
                steps{
                    sh "echo ${env.GIT_COMMIT}"
                    sh "echo ${env.GIT_BRANCH}"
                }
            }  
            
        


            stage('Build') {
                steps {
                    // docer compose up
                    script {
                        sh 'docker compose up -d'
                        sleep 5 // Wait for the containerized application to start up
                    }
                }
            }

            stage('Test APP & API') {
                steps {
                    script {
                        // Test if APP is responsive
                        def curl = sh script: 'curl --silent --fail -I http://localhost:5000/', returnStdout: true
                        if (curl.contains("HTTP/1.1 200 OK")) {
                        echo "The TODO application is running successfully"
                        } else {
                        error "The TODO application is not running successfully"
                        }

                        // Test ADD endpoint
                        def ADD = sh script: 'curl --silent -d "task=test" -X POST http://localhost:5000/api/add', returnStdout: true
                        if (ADD.contains('{"task":"test"}')) {
                        echo "The ADD API  is running successfully"
                        } else {
                        error "The ADD API  is not running successfully"
                        }

                        // Test Get list of tasks
                        def GET = sh(script: 'curl --silent http://localhost:5000/api', returnStdout: true)
                        if (GET.contains('["test"]')) {
                        echo "The GET API  is running successfully"
                        } else {
                        error "The GET API  is not running successfully"
                        }

                        // Test PUT(edit) endpoint
                        def EDIT = sh script: 'curl --silent -X PUT http://localhost:5000/api/edit -d "old_task=test&new_task=edit-test"', returnStdout: true
                        if (EDIT.contains('{"new_task":"edit-test","old_task":"test"}')) {
                        echo "The EDIT API  is running successfully"
                        } else {
                        error "The EDIT API  is not running successfully"
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


