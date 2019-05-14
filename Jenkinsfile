pipeline {
    agent {label 'dockere'}
    stages {
        stage('Build') {
            steps {
                sh 'bash -c "sh shell.sh"'  
            }
        }
        }
    node marathonlb {
        stage('Build1') {
            steps {
                sh 'bash -c "./opt/json/updateweb.sh"'  
            }
        }
    }

}
