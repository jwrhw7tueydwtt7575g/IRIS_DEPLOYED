pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
    }

    stages {
        stage('Cloning from Github Repo') {
            steps {
                script {
                    echo 'Cloning from Github Repo.........'
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'token', url: 'https://github.com/jwrhw7tueydwtt7575g/IRIS_DEPLOYED.git']]])
                }
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                script {
                    echo 'Setting up Virtual Environment.........'
                    sh '''
                        python -m venv ${VENV_DIR}
                        . ${VENV_DIR}/bin/activate
                        pip install --upgrade pip
                        pip install -r requirements.txt
                    '''
                }
            }
        }

        stage('Linting Code') {
            steps {
                script {
                    echo 'Linting Code.........'
                    sh '''
                        set -e
                        . ${VENV_DIR}/bin/activate

                        # Run pylint
                        pylint $(find . -name "*.py") --output=pylint-report.txt --exit-zero || echo "Pylint completed"

                        # Run flake8
                        flake8 $(find . -name "*.py") --ignore=E501,E302 --output-file=flake8-report.txt || echo "Flake8 completed"

                        # Format with black
                        black . || echo "Black completed"
                    '''
                }
            }
        }
    }
}
