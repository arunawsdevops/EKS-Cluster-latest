pipeline {
    agent any

    environment {
        
        AWS_ACCESS_KEY_ID = credentials('aws_credential')
    
    }

    stages {
        stage('eks-connection-test') {
            steps {
                script {
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'config-eks', namespace: '', restrictKubeConfigAccess: false, serverUrl: ''){
                        sh 'kubectl get nodes'
                    }
                }
            }
        }
    }
}
 
