pipeline {
    agent {
        label 'windows && qt5'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                checkout scm
                bat 'git status'
                bat ''' echo Lol '''
            }
        }
    }
}
