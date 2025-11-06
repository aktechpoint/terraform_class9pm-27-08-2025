pipeline {
    agent any

    environment {
        TF_DIR = "day-2_instance"
    }

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
                    // Auto-approve so no manual input is required
                    sh 'terraform apply -auto-approve tfplan'
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
