pipeline {
environment {
        
        AWS_DEFAULT_REGION = "us-east-1"
    }
agent  any
stages {
        stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/Abishek-Ravichander/Terraform-Vault.git"
                        
                    }
                }
            }
        stage('AWS Connection Check') {
            steps {
                        sh '''
                        aws --version
                        aws ec2 describe-instances
                        '''
                }
            }
        
        stage('Get credentials') {
            steps{
           withVault(configuration: [timeout: 60, vaultCredentialId: 'Vault_Token', vaultUrl: 'http://127.0.0.1:8200'], vaultSecrets: [[path: 'kv/abi/secrets', secretValues: [[envVar: 'AWS_ACCESS_KEY_ID',vaultKey: 'AWS_ACCESS_KEY_ID']]],]) {
    //sh 'echo $AWS_ACCESS_KEY_ID'    
    sh 'echo got credentials'    
}
}
        }
        
        stage('Plan') {
            steps {
                bat 'cd&cd terraform/Terraform-Vault & terraform init -input=false'
                bat 'cd&cd terraform/Terraform-Vault & terraform destroy -auto-approve'
                bat "cd&cd terraform/Terraform-Vault & terraform plan -input=false -out tfplan "
                bat 'cd&cd terraform/Terraform-Vault & terraform show -no-color tfplan > tfplan.txt'
            }
        }
       

        stage('Apply') {
            steps {
                bat "cd&cd terraform/Terraform-Vault & terraform apply -input=false tfplan"
            }
        }
        
        }
   }

