pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages {
        stage('Terraform Apply') {
            steps {
                script {
                    
                    sh 'echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"'

                
                    sh 'echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"'

                   
                    sh 'terraform init'

                    
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
