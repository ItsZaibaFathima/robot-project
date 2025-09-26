pipeline {
    agent any
    environment {
        VENV_DIR = 'venv'
        BROWSER_OPTIONS = '--guest'
    }

    stages {
        stage('Setup Python Environment') {
            steps {
                bat """
                if not exist %VENV_DIR% python -m venv %VENV_DIR%
                %VENV_DIR%\\Scripts\\pip install --upgrade pip
                %VENV_DIR%\\Scripts\\pip install robotframework selenium robotframework-seleniumlibrary
                """
            }
        }

        stage('Login Tests') {
            steps {
                bat "%VENV_DIR%\\Scripts\\robot tests\\login"
            }
        }

        stage('Product Tests') {
            steps {
                bat "%VENV_DIR%\\Scripts\\robot tests\\product"
            }
        }

        stage('Checkout Tests') {
            steps {
                bat "%VENV_DIR%\\Scripts\\robot tests\\checkout"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/output.xml, **/report.html, **/log.html', allowEmptyArchive: true
        }
    }
}
