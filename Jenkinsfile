pipeline {
    agent any

    stages {
        stage('Cloning from Github Repo') {
            steps {
                script {
                    echo 'Cloning from Github Repo.........'
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'token', url: 'https://github.com/jwrhw7tueydwtt7575g/IRIS_DEPLOYED.git']]])
                }
            }
        }
    }
}

