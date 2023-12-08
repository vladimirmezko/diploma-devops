pipeline {
    agent any
    environment {
        AWS_CREDENTIALS_ID     = 'aws-credentials'
    }
    stages {
        stage('Terraform Apply') {
            steps {
                withCredentials([
                    [ $class: 'AmazonWebServicesCredentialsBinding',
                      credentialsId: AWS_CREDENTIALS_ID,
                    ]
                ]) {
                    script {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}
