pipeline {
    agent any

    stages {
        stage('eks-connection-test') {
            steps {
                script {
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8-cred-jenkins', namespace: '', restrictKubeConfigAccess: false, serverUrl: ''){
                        bat 'kubectl get nodes'
                    }
                }
            }
        }
    }
}
 
