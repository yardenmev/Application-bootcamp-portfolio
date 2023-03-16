pipeline {
    agent any //{label 'yarden-ec2'}
        environment { 
            IMAGE_NAME = 'todo'
        }
        parameters {
            booleanParam(name: 'docker-compose', defaultValue: false, description: 'Check to docker compose up.')
            booleanParam(name: 'testing', defaultValue: false, description: 'Check for testing.')
            }

        stages {
            stage('version number calculation.') {
                // when{
                //     branch 'main'
                // }
                steps{
                    sshagent(credentials: ['yarden-github-ssh']) {
                        script{
                            tag = sh ( 
                            script: "sh tag-search.sh",
                            returnStdout: true
                            ).trim()
                            echo "the new git tag is: ${tag}"
                        }
                    }
                } 
            } 

            // stage('docker-compose') {
            //     when {
            //         expression { params.docker-compose }
            //         }
            //     steps {
            //         script {
            //             sh 'docker compose up -d'
            //             sleep 5 // Wait for the containerized application to start up
            //         }
            //     }
            // }

            // stage('Test APP & API') {
            //     when {
            //         expression { params.testing }
            //         }
            //     steps {
            //         script {
            //             // Test if APP is responsive
            //             def curl = sh script: 'curl --silent --fail -I http://localhost:5000/', returnStdout: true
            //             if (curl.contains("HTTP/1.1 200 OK")) {
            //             echo "The TODO application is running successfully"
            //             } else {
            //             error "The TODO application is not running successfully"
            //             }

            //             // Test ADD endpoint
            //             def ADD = sh script: 'curl --silent -d "task=test" -X POST http://localhost:5000/api/add', returnStdout: true
            //             if (ADD.contains('{"task":"test"}')) {
            //             echo "The ADD API  is running successfully"
            //             } else {
            //             error "The ADD API  is not running successfully"
            //             }

            //             // Test Get list of tasks
            //             def GET = sh(script: 'curl --silent http://localhost:5000/api', returnStdout: true)
            //             if (GET.contains('["test"]')) {
            //             echo "The GET API  is running successfully"
            //             } else {
            //             error "The GET API  is not running successfully"
            //             }

            //             // Test PUT(edit) endpoint
            //             def EDIT = sh script: 'curl --silent -X PUT http://localhost:5000/api/edit -d "old_task=test&new_task=edit-test"', returnStdout: true
            //             if (EDIT.contains('{"new_task":"edit-test","old_task":"test"}')) {
            //             echo "The EDIT API  is running successfully"
            //             } else {
            //             error "The EDIT API  is not running successfully"
            //             }

            //             // Test DELETE endpoint
            //             def DELETE = sh script: 'curl --silent -X POST http://localhost:5000/api/delete -d "task=edit-test"', returnStdout: true
            //             if (DELETE.contains('{"task":"edit-test"}')) {
            //             echo "The DELETE API  is running successfully"
            //             } else {
            //             error "The DELETE API  is not running successfully"
            //             }
            //         }
            //     }
            // }

            stage('Git tag') { 
                // when {
                //     branch 'develop'
                // }
                steps {
                    sshagent(['yarden-github-ssh']) {
                        sh "git tag ${tag}"
                        sh "git push origin ${tag}"
                    }
                }
            }
            stage('push image') {
                steps {
                    sh """
                    aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.us-east-2.amazonaws.com
                    docker build -t ${IMAGE_NAME}:${tag} .
                    docker tag ${IMAGE_NAME}:${tag} 644435390668.dkr.ecr.us-east-2.amazonaws.com/yarden-todo:${tag}
                    docker push 644435390668.dkr.ecr.us-east-2.amazonaws.com/yarden-todo:${tag}
                    """
                } 
            }
        }
    
    // post {
    //     always {
    //         // Bring containers down
    //         sh 'docker compose down'
    //     }
    // }
}


