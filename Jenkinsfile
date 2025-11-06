pipeline {
    agent any

    environment {
        TF_DIR = "day-2_instance"
    }

    stages {
        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    echo "Initializing Terraform in ${TF_DIR}..."
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    echo "Creating Terraform plan..."
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    echo "Applying Terraform plan..."
                    sh 'terraform ${ation} -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo "Terraform deployment completed successfully!"
        }
        failure {
            echo "❌ Terraform deployment failed!"
        }
    }
}
