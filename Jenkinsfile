pipeline {
    agent {label 'dockere'}
    stages {
        stage('Build') {
            steps {
                sh 'bash -c "sh shell.sh"'  
            }
        }
        }
    agent {label 'marathonlb'}
    stages {
        stage('Build') {
            steps {
                sh 'bash -c "./opt/json/updateweb.sh"'  
            }
        }
        }

}
