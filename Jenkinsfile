pipeline {
    agent {label 'marathonlb'}
    stages {
        stage('Build') {
            steps {
                sh 'bash -c "sh shell.sh"'  
            }
        }
        
    
        stage('Build1') {
            steps {
                sh 'bash -c "sh /opt/json/updateweb.sh"'  
            }
        }
    
    }
}
