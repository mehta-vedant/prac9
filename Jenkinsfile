pipeline {
    agent any

    options {
        // Makes the Checkout stage visible instead of using Jenkins' implicit checkout.
        skipDefaultCheckout(true)
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'python3 -m pip install -r requirements.txt'
                    } else {
                        bat 'call run_tests.bat install'
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'python3 -m pytest --junitxml=test-results.xml'
                    } else {
                        bat 'call run_tests.bat test'
                    }
                }
            }
        }
    }

    post {
        always {
            // Publishes the PyTest result in Jenkins, even when a test fails.
            junit allowEmptyResults: true, testResults: 'test-results.xml'
        }
    }
}
