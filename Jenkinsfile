pipeline {
    agent none
    stages {
        stage('Build') {
            agent {label 'dockere'}
            steps {
                sh 'bash -c "sh shell.sh"'  
            }
        }
        
    
        stage('Build1') {
            agent {
                 label 'marathonlb'
             }
            steps {
                sh 'bash -c "./opt/json/updateweb.sh"'  
            }
        }
    
    }
}
