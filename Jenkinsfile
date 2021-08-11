def secrets = [
  [path: 'kv/abi/secrets', engineVersion: 2, secretValues: [
   [envVar: 'AWS_ACCESS_KEY_ID',vaultKey: 'AWS_ACCESS_KEY_ID'],
    [envVar: 'AWS_SECRET_ACCESS_KEY',vaultKey: 'AWS_SECRET_ACCESS_KEY']]],
]

def configuration = [vaultUrl: 'http://127.0.0.1:8200',  vaultCredentialId: 'Vault_Token', engineVersion: 2]

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
           withVault([configuration: configuration, vaultSecrets: secrets]) {
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

