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
                    // Setup Virtual Environment
                    echo 'Setup Virtual Environment.........'
                    sh '''
                        python -m venv ${VENV_DIR}
                        . ${VENV_DIR}/bin/activate
                        pip install --upgrade pip
                        pip install -e .
                    '''
                }
            }
        }
         stage('Linting Code') {
            steps {
                script {
                    // Linting Code
                    echo 'Linting Code.........'
                    sh '''
                        set -e
                        . ${VENV_DIR}/bin/activate
                        # Run pylint on all Python files, save report, exit with 0 always
pylint $(find . -name "*.py") --output=pylint-report.txt --exit-zero || echo "Pylint stage completed"

# Run flake8 on all Python files, ignore specific warnings, save report
flake8 $(find . -name "*.py") --ignore=E501,E302 --output-file=flake8-report.txt || echo "Flake8 stage completed"

# Format all Python files using black
black . || echo "Black stage completed"

                    '''
                    
                }
            }
    }
}

